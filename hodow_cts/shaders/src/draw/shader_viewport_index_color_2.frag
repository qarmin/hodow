#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[2];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
