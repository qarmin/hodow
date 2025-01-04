#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec2 in0 = a_in0.wy;
	highp vec2 res = vec2(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 1.00, 1.00, 0.0);
    v_color = color;
}
