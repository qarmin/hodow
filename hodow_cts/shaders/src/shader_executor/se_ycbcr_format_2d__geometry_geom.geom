#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_texCoord[];
layout(location = 0) flat out highp vec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp vec2 texCoord = vtx_out_texCoord[0];
	highp vec4 result;

	result = texture(u_image, texCoord);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
