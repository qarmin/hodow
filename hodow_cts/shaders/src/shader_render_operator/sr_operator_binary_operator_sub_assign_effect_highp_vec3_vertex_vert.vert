#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp vec3 in1 = a_in1.yzx;
	highp vec3 res = vec3(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    v_color = color;
}
