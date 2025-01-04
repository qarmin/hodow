#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    v_color = color;
}
