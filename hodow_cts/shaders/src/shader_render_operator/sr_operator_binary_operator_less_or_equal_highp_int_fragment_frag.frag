#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp int in1 = int(v_in1.x);
	bool res = bool(0.0);

	res = in0 <= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
