#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	bvec2 in0 = greaterThan(v_in0.wy, vec2(0.0));
	bvec2 res = bvec2(0.0);

	res = not(in0);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
