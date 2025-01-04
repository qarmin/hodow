#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump float in0 = v_in0.z;
	mediump vec2 in1 = v_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
