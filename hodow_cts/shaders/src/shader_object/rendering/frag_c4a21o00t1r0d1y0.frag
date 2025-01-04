#version 450
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
void main() {
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    gl_FragDepth = 0.5f;
}
