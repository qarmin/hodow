#version 460
layout (early_fragment_tests) in;
layout (location=0) out vec4 outColor;
void main(void) {
    gl_FragDepth = 0.25;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
