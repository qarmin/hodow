#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	bool res = bool(0.0);

	res = !in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
