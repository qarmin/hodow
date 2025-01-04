#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
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
