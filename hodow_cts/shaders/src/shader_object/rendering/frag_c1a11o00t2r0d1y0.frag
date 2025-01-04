#version 450
layout (location = 1) out ivec4 outColor1;
void main() {
    outColor1 = ivec4(255);
    gl_FragDepth = 0.5f;
}
