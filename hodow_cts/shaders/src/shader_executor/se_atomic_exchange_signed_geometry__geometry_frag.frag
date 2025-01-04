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


layout(location = 0) flat in highp uint geom_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = geom_out_outData;
}
