#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp float in1 = v_in1.x;
	highp vec2 res = vec2(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
