#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[5];
in float gl_CullDistance[3];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[2], gl_CullDistance[1],  1.0);
}
