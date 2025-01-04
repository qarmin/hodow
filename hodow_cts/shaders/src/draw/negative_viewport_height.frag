#version 450

layout(location = 0) out vec4 out_color;

void main(void)
{
    if (gl_FrontFacing)
        out_color = vec4(1.0);
    else
        out_color = vec4(vec3(0.5), 1.0);
}
