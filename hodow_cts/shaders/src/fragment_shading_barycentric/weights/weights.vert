#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 1) in  vec4 in_color;
layout(location = 0) out vec3 color;
layout(push_constant) uniform PushConstant { mat4 mvp; } pc;

void main()
{
    color        = in_color.xyz;
    gl_Position  = transpose(pc.mvp) * in_position;
    gl_PointSize = 1.0;
}
