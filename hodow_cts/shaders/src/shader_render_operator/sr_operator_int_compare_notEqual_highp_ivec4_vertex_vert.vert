#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	bvec4 res = bvec4(0.0);

	res = notEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    v_color = color;
}
