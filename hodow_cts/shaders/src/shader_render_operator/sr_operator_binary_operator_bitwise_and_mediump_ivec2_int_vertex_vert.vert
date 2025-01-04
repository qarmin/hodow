#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump int in1 = int(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
