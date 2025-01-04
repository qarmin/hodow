#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
