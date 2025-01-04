#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 6) in mediump vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	mediump float in1 = a_in1.x;
	mediump float in2 = a_in2.y;
	mediump float res = float(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
	color = color * vec4(0.5, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
