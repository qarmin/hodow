#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    o_color = color;
}
