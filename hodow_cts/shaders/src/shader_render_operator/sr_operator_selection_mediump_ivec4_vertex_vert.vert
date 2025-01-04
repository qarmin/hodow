#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	mediump ivec4 in1 = ivec4(a_in1.wzyx);
	mediump ivec4 in2 = ivec4(a_in2.xwzy);
	mediump ivec4 res = ivec4(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
