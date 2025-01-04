#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	highp vec3 in1 = v_in1.yzx;
	highp vec3 in2 = v_in2.wyz;
	highp vec3 res = vec3(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
	color = color * vec4(0.5, 0.5, 0.5, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
