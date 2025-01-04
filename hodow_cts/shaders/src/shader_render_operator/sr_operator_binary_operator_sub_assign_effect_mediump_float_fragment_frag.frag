#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump float in0 = v_in0.z;
	mediump float in1 = v_in1.x;
	mediump float res = float(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
    o_color = color;
}
