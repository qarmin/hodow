#version 450
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[2].value;
	result1 = block[3].value;
	result2 = block[3].value;
	result3 = block[1].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
