#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uvec4 res = uvec4(0.0);

	res = in0--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1);
    o_color = color;
}
