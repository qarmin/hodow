#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler[4];
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec4 vtx_out_o_color0;
layout(location = 1) flat out highp vec4 vtx_out_o_color1;
layout(location = 2) flat out highp vec4 vtx_out_o_color2;
layout(location = 3) flat out highp vec4 vtx_out_o_color3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 uv = a_uv;
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);
	vtx_out_o_color0 = o_color0;
	vtx_out_o_color1 = o_color1;
	vtx_out_o_color2 = o_color2;
	vtx_out_o_color3 = o_color3;
}
