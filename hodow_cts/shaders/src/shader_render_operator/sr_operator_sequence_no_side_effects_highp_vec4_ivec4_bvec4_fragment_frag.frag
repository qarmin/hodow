#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in mediump vec4 v_in2;

void main()
{
	highp vec4 in0 = v_in0.yzwx;
	highp ivec4 in1 = ivec4(v_in1.wzyx);
	bvec4 in2 = greaterThan(v_in2.xwzy, vec4(0.0));
	highp ivec4 res = ivec4(0.0);

	res = (in0 + vec4(in1), in2, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.5, 0.5, 0.5, 0.5);
    o_color = color;
}
