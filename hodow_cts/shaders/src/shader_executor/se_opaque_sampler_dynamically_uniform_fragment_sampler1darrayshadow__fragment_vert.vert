#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
