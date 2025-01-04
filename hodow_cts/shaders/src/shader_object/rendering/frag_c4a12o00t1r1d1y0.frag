#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
