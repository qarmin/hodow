#version 450
layout (location=0) out vec4 outColor;

void main ()
{
    const uint primId = uint(gl_PrimitiveID);
    // Pixel color rotates every 3 pixels.
    const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    const vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);
    const vec4 colorPalette[3] = vec4[](red, green, blue);
    const uint colorIdx = primId % 3u;
    outColor = colorPalette[colorIdx];
}
