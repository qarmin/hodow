#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;
layout(location = 3) in mediump vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	mediump vec2 in1 = v_in1.yx;
	mediump vec2 in2 = v_in2.zy;
	mediump vec2 res = vec2(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
