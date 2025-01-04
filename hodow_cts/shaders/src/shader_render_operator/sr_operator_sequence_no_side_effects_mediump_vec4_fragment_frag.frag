#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;
layout(location = 3) in mediump vec4 v_in2;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump vec4 in1 = v_in1.wzyx;
	mediump vec4 in2 = v_in2.xwzy;
	mediump vec4 res = vec4(0.0);

	res = (in0, in2 + in1, in1 + in0);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
	color = color * vec4(0.5, 0.5, 0.5, 0.5);
    o_color = color;
}
