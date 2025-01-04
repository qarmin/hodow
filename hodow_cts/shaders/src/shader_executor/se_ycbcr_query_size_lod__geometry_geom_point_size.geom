#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_lod[];
layout(location = 0) flat out highp ivec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int lod = vtx_out_lod[0];
	highp ivec2 result;

	result = textureSize(u_image, lod);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
