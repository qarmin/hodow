#version 310 es
layout (location = 0) in highp vec4 a_position;
void main()
{
    gl_Position = a_position;
}
#version 310 es
#extension GL_EXT_texture_buffer : enable
layout (set=0, binding=0) uniform highp usamplerBuffer u_buffer;
layout (location = 0) out highp uint o_color;
void main()
{
    o_color = texelFetch(u_buffer, int(gl_FragCoord.x)).x;
}
