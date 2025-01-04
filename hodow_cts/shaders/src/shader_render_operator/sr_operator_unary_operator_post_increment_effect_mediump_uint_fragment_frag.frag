#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uint res = uint(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0);
    o_color = color;
}
