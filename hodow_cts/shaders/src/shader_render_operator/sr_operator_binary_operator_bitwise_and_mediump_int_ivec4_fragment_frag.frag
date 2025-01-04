#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
