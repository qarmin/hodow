#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
