#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in mediump vec4 v_in2;

void main()
{
	mediump float in0 = v_in0.z;
	mediump uint in1 = uint(v_in1.x);
	mediump float in2 = v_in2.y;
	mediump uint res = uint(0.0);

	res = (in1++, in0 = float(in1), in1 = uint(in0 + in2));

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.5, 1.0, 1.0, 1.0);
    o_color = color;
}
