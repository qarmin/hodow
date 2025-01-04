#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uvec3 res = uvec3(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0);
    o_color = color;
}
