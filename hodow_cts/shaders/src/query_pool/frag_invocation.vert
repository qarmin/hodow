#version 460
layout (location=0) in vec4 inPos;
${'layout (location=1) in vec4 inColor;' if vertex_color else ''}
${'layout (location=0) out vec4 outColor;' if vertex_color else ''}
void main() {
    gl_Position = inPos;
${'    outColor = inColor;' if vertex_color else ''}
}
