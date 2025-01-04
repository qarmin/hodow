#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_x[];
layout(location = 1) flat in highp int vtx_out_y[];
layout(location = 0) flat out highp int geom_out_msb;
layout(location = 1) flat out highp int geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int x = vtx_out_x[0];
	highp int y = vtx_out_y[0];
	highp int msb;
	highp int lsb;

	imulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
