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



layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicExchange(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
