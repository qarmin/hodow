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


layout(location = 0) flat in highp uint geom_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = geom_out_outData;
}
