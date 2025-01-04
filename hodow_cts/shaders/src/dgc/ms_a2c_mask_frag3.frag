#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    const bool isTopLeftPixel = (gl_FragCoord.x < 1.0 && gl_FragCoord.y < 1.0);
    gl_SampleMask[0] = (isTopLeftPixel ? 0 : 0xFF);
    outColor = vec4(1.0, 1.0, 1.0, 1.0);
}
