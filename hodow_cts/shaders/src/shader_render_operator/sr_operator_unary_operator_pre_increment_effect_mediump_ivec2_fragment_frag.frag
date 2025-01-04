#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	++res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
