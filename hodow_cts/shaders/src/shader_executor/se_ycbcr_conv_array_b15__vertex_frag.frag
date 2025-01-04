#version 450
layout(set=1, binding=15) uniform highp sampler2D u_sampler[4];
layout(location = 0) flat in highp vec4 vtx_out_o_color0;
layout(location = 1) flat in highp vec4 vtx_out_o_color1;
layout(location = 2) flat in highp vec4 vtx_out_o_color2;
layout(location = 3) flat in highp vec4 vtx_out_o_color3;
layout(location = 0) out highp vec4 o_o_color0;
layout(location = 1) out highp vec4 o_o_color1;
layout(location = 2) out highp vec4 o_o_color2;
layout(location = 3) out highp vec4 o_o_color3;

void main (void)
{
	o_o_color0 = vtx_out_o_color0;
	o_o_color1 = vtx_out_o_color1;
	o_o_color2 = vtx_out_o_color2;
	o_o_color3 = vtx_out_o_color3;
}
