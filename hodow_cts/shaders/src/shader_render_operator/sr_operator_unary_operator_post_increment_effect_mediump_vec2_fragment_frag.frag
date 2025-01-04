#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump vec2 res = vec2(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0);
    o_color = color;
}
