#version 450

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicAdd(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
