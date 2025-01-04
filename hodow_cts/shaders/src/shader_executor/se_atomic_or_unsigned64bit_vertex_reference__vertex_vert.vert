#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


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
	    buf.data.outputValues[idx] = atomicOr(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	vtx_out_outData = outData;
}
