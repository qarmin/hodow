#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bvec3 in0 = greaterThan(a_in0.zxy, vec3(0.0));
	bvec3 in1 = greaterThan(a_in1.yzx, vec3(0.0));
	bvec3 res = bvec3(0.0);

	res = notEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    v_color = color;
}
