#version 310 es
#extension GL_EXT_texture_buffer : enable
layout (set=0, binding=0) uniform highp utextureBuffer u_buffer;
layout (location = 0) out highp uint o_color;
void main()
{
    o_color = texelFetch(u_buffer, int(gl_FragCoord.x)).x;
}
