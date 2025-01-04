#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	bool in1 = (a_in1.x > 0.0);
	highp vec2 in2 = a_in2.zy;
	highp ivec2 res = ivec2(0.0);

	res = (in0 && in1, in0, ivec2(vec2(in0) + in2));

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.5, 0.5, 1.0);
    v_color = color;
}
