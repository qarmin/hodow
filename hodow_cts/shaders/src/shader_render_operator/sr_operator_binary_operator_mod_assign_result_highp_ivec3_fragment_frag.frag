#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
