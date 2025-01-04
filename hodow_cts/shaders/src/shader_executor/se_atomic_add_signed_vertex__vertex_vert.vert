#version 450

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_outData;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint outData;
	int idx = gl_VertexIndex;
	if (atomicAdd(buf.data.invocationHitCount[idx], 1) == 0)
	{
	    buf.data.outputValues[idx] = atomicAdd(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	vtx_out_outData = outData;
}
