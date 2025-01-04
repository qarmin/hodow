#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;
layout(location = 3) in mediump vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	bvec2 in1 = greaterThan(v_in1.yx, vec2(0.0));
	bvec2 in2 = greaterThan(v_in2.zy, vec2(0.0));
	bvec2 res = bvec2(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
