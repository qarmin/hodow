#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_x[];
layout(location = 1) flat in highp ivec2 vtx_out_y[];
layout(location = 0) flat out highp ivec2 geom_out_msb;
layout(location = 1) flat out highp ivec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec2 x = vtx_out_x[0];
	highp ivec2 y = vtx_out_y[0];
	highp ivec2 msb;
	highp ivec2 lsb;

	imulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
