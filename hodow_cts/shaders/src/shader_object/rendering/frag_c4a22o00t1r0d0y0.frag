#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 5) out uvec4 outColor5;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor5 = uvec4(255);
}
