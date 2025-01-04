#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp sampler2D u_planeView;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_texCoord[];
layout(location = 0) flat out highp vec4 geom_out_result0;
layout(location = 1) flat out highp vec4 geom_out_result1;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp vec2 texCoord = vtx_out_texCoord[0];
	highp vec4 result0;
	highp vec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = vec4(texture(u_planeView, texCoord));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
    EmitVertex();
    EndPrimitive();
}
