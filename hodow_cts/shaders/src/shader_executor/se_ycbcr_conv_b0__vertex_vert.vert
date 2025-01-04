#version 450
layout(set=1, binding=0) uniform highp sampler2D u_sampler;
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec4 vtx_out_o_color;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 uv = a_uv;
	highp vec4 o_color;
	o_color = texture(u_sampler, uv);
	vtx_out_o_color = o_color;
}
