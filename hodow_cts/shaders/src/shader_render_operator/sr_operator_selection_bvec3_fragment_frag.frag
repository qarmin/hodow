#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;
layout(location = 3) in mediump vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	bvec3 in1 = greaterThan(v_in1.yzx, vec3(0.0));
	bvec3 in2 = greaterThan(v_in2.wyz, vec3(0.0));
	bvec3 res = bvec3(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    o_color = color;
}
