#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
