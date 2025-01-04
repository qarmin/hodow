#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_x[];
layout(location = 1) flat in highp ivec4 vtx_out_y[];
layout(location = 0) flat out highp ivec4 geom_out_msb;
layout(location = 1) flat out highp ivec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec4 x = vtx_out_x[0];
	highp ivec4 y = vtx_out_y[0];
	highp ivec4 msb;
	highp ivec4 lsb;

	imulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
