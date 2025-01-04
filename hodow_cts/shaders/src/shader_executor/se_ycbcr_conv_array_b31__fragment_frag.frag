#version 450
layout(set=1, binding=31) uniform highp sampler2D u_sampler[4];
layout(location = 0) flat in highp vec2 vtx_out_uv;
layout(location = 0) out highp vec4 o_o_color0;
layout(location = 1) out highp vec4 o_o_color1;
layout(location = 2) out highp vec4 o_o_color2;
layout(location = 3) out highp vec4 o_o_color3;

void main (void)
{
	highp vec2 uv = vtx_out_uv;
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);
	o_o_color0 = o_color0;
	o_o_color1 = o_color1;
	o_o_color2 = o_color2;
	o_o_color3 = o_color3;
}
