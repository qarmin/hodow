#version 450
layout(location = 0) in vec4 inPos;
void main() {
    gl_Position = vec4((inPos.xy - 0.5f) * 1.5f, inPos.zw);
}
