#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) flat in highp uint vtx_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = vtx_out_outData;
}
