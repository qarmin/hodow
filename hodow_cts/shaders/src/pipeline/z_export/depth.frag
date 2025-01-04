#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    const float alphaValue = ((int(gl_FragCoord.x) < 2) ? 0.0 : 1.0);
    outColor = vec4(0.0, 0.0, 1.0, alphaValue);
    gl_FragDepth = 0.000000;
}
