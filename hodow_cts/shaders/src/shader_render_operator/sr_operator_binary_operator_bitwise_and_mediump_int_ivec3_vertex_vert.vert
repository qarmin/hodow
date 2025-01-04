#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
