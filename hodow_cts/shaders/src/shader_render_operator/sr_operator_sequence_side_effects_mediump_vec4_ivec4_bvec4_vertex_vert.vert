#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in mediump vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec4 in0 = a_in0.yzwx;
	mediump ivec4 in1 = ivec4(a_in1.wzyx);
	bvec4 in2 = greaterThan(a_in2.xwzy, vec4(0.0));
	mediump ivec4 res = ivec4(0.0);

	res = (in0 = in0 + vec4(in2), in1 = in1 + ivec4(in0), in1++);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.5, 0.5, 0.5, 0.5);
    v_color = color;
}
