#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int res = int(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
