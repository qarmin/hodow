#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler;
layout(location = 0) flat in highp vec2 vtx_out_uv;
layout(location = 0) out highp vec4 o_o_color;

void main (void)
{
	highp vec2 uv = vtx_out_uv;
	highp vec4 o_color;
	o_color = texture(u_sampler, uv);
	o_o_color = o_color;
}
