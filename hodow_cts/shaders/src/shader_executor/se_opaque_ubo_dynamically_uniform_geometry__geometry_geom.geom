#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_index0[];
layout(location = 1) flat in highp int vtx_out_index1[];
layout(location = 2) flat in highp int vtx_out_index2[];
layout(location = 3) flat in highp int vtx_out_index3[];
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int index0 = vtx_out_index0[0];
	highp int index1 = vtx_out_index1[0];
	highp int index2 = vtx_out_index2[0];
	highp int index3 = vtx_out_index3[0];
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
