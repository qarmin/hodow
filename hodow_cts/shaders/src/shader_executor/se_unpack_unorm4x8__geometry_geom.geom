#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_in0[];
layout(location = 0) flat out highp vec4 geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint in0 = vtx_out_in0[0];
	highp vec4 out0;

	out0 = unpackUnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
