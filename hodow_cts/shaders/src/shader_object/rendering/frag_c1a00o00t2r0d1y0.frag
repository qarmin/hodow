#version 450
layout (location = 0) out ivec4 outColor0;
void main() {
    outColor0 = ivec4(255);
    gl_FragDepth = 0.5f;
}
