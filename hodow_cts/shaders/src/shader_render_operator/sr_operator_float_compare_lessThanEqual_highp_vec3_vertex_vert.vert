#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp vec3 in1 = a_in1.yzx;
	bvec3 res = bvec3(0.0);

	res = lessThanEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    v_color = color;
}
