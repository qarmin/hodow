#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	highp ivec2 in1 = ivec2(v_in1.yx);
	highp ivec2 in2 = ivec2(v_in2.zy);
	highp ivec2 res = ivec2(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
