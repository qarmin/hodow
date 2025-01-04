#version 450
layout (location = 1) out vec4 outColor1;
void main() {
    outColor1 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
