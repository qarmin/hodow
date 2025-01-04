#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	bvec2 res = bvec2(0.0);

	res = lessThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    v_color = color;
}
