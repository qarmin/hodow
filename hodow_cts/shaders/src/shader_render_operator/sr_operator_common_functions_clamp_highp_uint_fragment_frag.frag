#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	highp uint in2 = uint(v_in2.y);
	highp uint res = uint(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.125, 1.0, 1.0, 1.0);
    o_color = color;
}
