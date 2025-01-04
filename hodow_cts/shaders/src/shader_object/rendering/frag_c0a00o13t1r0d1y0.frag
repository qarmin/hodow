#version 450
layout (location = 0) out uvec4 outColor0;
void main() {
    outColor0 = uvec4(255);
    gl_FragDepth = 0.5f;
}
