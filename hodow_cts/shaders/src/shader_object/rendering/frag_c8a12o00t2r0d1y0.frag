#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
    gl_FragDepth = 0.5f;
}
