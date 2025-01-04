#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump int res = int(0.0);

	res = ++in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
