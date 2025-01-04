#version 450
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
