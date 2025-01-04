#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
