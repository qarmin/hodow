#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump vec4 res = vec4(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
	color = color * vec4(0.5, 0.5, 0.5, 0.5) + vec4(1.00, 1.00, 1.00, 1.00);
    o_color = color;
}
