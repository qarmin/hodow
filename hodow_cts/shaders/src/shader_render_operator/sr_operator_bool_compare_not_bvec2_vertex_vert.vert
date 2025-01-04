#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bvec2 in0 = greaterThan(a_in0.wy, vec2(0.0));
	bvec2 res = bvec2(0.0);

	res = not(in0);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    v_color = color;
}
