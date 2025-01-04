#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
layout (location = 9) out uvec4 outColor9;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
    outColor9 = uvec4(255);
    gl_FragDepth = 0.5f;
}
