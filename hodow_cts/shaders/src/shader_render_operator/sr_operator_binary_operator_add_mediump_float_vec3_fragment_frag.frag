#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump float in0 = v_in0.z;
	mediump vec3 in1 = v_in1.yzx;
	mediump vec3 res = vec3(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
