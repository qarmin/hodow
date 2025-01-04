#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uvec2 in1 = uvec2(a_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    v_color = color;
}
