#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 1) in  vec4 in_color;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
    out_color = in_color;
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 o_color;

void main(void)
{
    o_color = vec4(in_color);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec3 o_color;

void main(void)
{
    o_color = vec3(in_color.rgb);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out uint o_color;

void main(void)
{
    o_color = uint(in_color.r * uint(125));
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out ivec2 o_color;

void main(void)
{
    o_color = ivec2(in_color.rg * ivec2(125));
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out uvec4 o_color;

void main(void)
{
    o_color = uvec4(in_color * uvec4(125));
}
