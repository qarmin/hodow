#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp int in1 = int(v_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    o_color = color;
}
