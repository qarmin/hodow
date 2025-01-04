#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_in0[];
layout(location = 0) flat out highp vec2 geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint in0 = vtx_out_in0[0];
	highp vec2 out0;

	out0 = unpackUnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
