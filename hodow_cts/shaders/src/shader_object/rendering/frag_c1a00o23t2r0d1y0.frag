#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    gl_FragDepth = 0.5f;
}
