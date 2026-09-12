#include <math.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

/*
 * Fully Animated ASCII Cube Renderer v2.0
 *
 * Features:
 *   - Three independently sized animated cubes
 *   - Smooth X/Y/Z rotation
 *   - Depth buffering
 *   - Improved frame timing (~60 FPS)
 *   - Terminal cursor hiding
 *   - Clean terminal redraw
 */

#define WIDTH 160
#define HEIGHT 44
#define CELLS (WIDTH * HEIGHT)
#define PI 3.14159265358979323846f

static float A = 0.0f;
static float B = 0.0f;
static float C = 0.0f;

static float zBuffer[CELLS];
static char buffer[CELLS];

static float calculateX(float i, float j, float k) {
    return j * sinf(A) * sinf(B) * cosf(C)
         - k * cosf(A) * sinf(B) * cosf(C)
         + j * cosf(A) * sinf(C)
         + k * sinf(A) * sinf(C)
         + i * cosf(B) * cosf(C);
}

static float calculateY(float i, float j, float k) {
    return j * cosf(A) * cosf(C)
         + k * sinf(A) * cosf(C)
         - j * sinf(A) * sinf(B) * sinf(C)
         + k * cosf(A) * sinf(B) * sinf(C)
         - i * cosf(B) * sinf(C);
}

static float calculateZ(float i, float j, float k) {
    return k * cosf(A) * cosf(B)
         - j * sinf(A) * cosf(B)
         + i * sinf(B);
}

static void plot(float cubeX, float cubeY, float cubeZ,
                 float horizontalOffset, float scale, char glyph) {
    const float distanceFromCam = 100.0f;
    const float K1 = 40.0f;

    float x = calculateX(cubeX, cubeY, cubeZ);
    float y = calculateY(cubeX, cubeY, cubeZ);
    float z = calculateZ(cubeX, cubeY, cubeZ) + distanceFromCam;

    if (z <= 1.0f) {
        return;
    }

    float ooz = 1.0f / z;
    int xp = (int)(WIDTH / 2.0f + horizontalOffset + K1 * ooz * x * 2.0f * scale);
    int yp = (int)(HEIGHT / 2.0f + K1 * ooz * y * scale);

    if (xp < 0 || xp >= WIDTH || yp < 0 || yp >= HEIGHT) {
        return;
    }

    int idx = xp + yp * WIDTH;
    if (ooz > zBuffer[idx]) {
        zBuffer[idx] = ooz;
        buffer[idx] = glyph;
    }
}

static void renderCube(float cubeWidth, float horizontalOffset, float scale) {
    const float step = 0.55f;

    for (float cubeX = -cubeWidth; cubeX < cubeWidth; cubeX += step) {
        for (float cubeY = -cubeWidth; cubeY < cubeWidth; cubeY += step) {
            plot(cubeX, cubeY, -cubeWidth, horizontalOffset, scale, '@');
            plot(cubeWidth, cubeY, cubeX, horizontalOffset, scale, '$');
            plot(-cubeWidth, cubeY, -cubeX, horizontalOffset, scale, '~');
            plot(-cubeX, cubeY, cubeWidth, horizontalOffset, scale, '#');
            plot(cubeX, -cubeWidth, -cubeY, horizontalOffset, scale, ';');
            plot(cubeX, cubeWidth, cubeY, horizontalOffset, scale, '+');
        }
    }
}

static void drawFrame(void) {
    printf("\x1b[H");

    for (int i = 0; i < CELLS; ++i) {
        putchar((i % WIDTH == 0) ? '\n' : buffer[i]);
    }

    fflush(stdout);
}

int main(void) {
    /* Clear screen and hide cursor. */
    printf("\x1b[2J\x1b[H\x1b[?25l");
    fflush(stdout);

    while (1) {
        memset(buffer, '.', sizeof(buffer));
        memset(zBuffer, 0, sizeof(zBuffer));

        /* Large cube. */
        renderCube(20.0f, -40.0f, 1.00f);

        /* Medium cube. */
        renderCube(11.0f, 0.0f, 1.15f);

        /* Small cube. */
        renderCube(6.0f, 38.0f, 1.35f);

        drawFrame();

        /* Independent angular velocities create a more dynamic motion. */
        A += 0.035f;
        B += 0.052f;
        C += 0.018f;

        if (A >= 2.0f * PI) A -= 2.0f * PI;
        if (B >= 2.0f * PI) B -= 2.0f * PI;
        if (C >= 2.0f * PI) C -= 2.0f * PI;

        /* Approximately 60 frames per second. */
        usleep(16000);
    }

    /* Unreachable during normal execution, but restores cursor if loop exits. */
    printf("\x1b[?25h");
    return 0;
}
