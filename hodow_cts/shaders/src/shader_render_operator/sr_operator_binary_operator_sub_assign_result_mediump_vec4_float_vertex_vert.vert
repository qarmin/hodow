#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec4 in0 = a_in0.yzwx;
	mediump float in1 = a_in1.x;
	mediump vec4 res = vec4(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
