#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump uvec3 in1 = uvec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
