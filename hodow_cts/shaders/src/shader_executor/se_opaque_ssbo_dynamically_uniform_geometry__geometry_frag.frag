#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
