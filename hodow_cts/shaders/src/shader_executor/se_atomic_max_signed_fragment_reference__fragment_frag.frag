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


layout(location = 0) out highp uint o_outData;

void main (void)
{
	highp uint outData;
	if (!gl_HelperInvocation) {
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicMax(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	o_outData = outData;
}
