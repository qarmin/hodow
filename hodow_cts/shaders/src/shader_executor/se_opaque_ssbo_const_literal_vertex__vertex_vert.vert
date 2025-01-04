#version 450
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[0].value;
	result1 = block[2].value;
	result2 = block[2].value;
	result3 = block[3].value;
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
