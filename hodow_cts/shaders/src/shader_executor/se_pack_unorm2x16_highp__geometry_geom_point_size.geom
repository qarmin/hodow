#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp vec2 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packUnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
