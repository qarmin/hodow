#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp vec4 in1 = a_in1.wzyx;
	highp vec4 in2 = a_in2.xwzy;
	highp vec4 res = vec4(0.0);

	res = (in0++, in1 = in0 + in2, in2 = in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
	color = color * vec4(0.5, 0.5, 0.5, 0.5);
    v_color = color;
}
