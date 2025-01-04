#version 450
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 uv;
layout(location = 0) out vec4 outUV;
void main (void)
{
    gl_Position = position;
    outUV = uv;
}
