#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	highp ivec4 in1 = ivec4(v_in1.wzyx);
	highp ivec4 in2 = ivec4(v_in2.xwzy);
	highp ivec4 res = ivec4(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
