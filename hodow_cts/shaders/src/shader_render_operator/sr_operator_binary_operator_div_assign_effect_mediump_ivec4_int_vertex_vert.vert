#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump int in1 = int(a_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.04, 0.04, 0.04, 0.04) + vec4(1.00, 1.00, 1.00, 1.00);
    v_color = color;
}
