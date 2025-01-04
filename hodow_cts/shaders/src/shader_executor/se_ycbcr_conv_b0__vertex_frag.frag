#version 450
layout(set=1, binding=0) uniform highp sampler2D u_sampler;
layout(location = 0) flat in highp vec4 vtx_out_o_color;
layout(location = 0) out highp vec4 o_o_color;

void main (void)
{
	o_o_color = vtx_out_o_color;
}
