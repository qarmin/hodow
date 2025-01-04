#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uint in1 = uint(a_in1.x);
	highp uint in2 = uint(a_in2.y);
	highp uvec4 res = uvec4(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.125, 0.125, 0.125, 0.125);
    v_color = color;
}
