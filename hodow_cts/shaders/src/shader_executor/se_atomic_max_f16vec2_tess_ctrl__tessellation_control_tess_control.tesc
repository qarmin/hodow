#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_NV_shader_atomic_fp16_vector : require

struct AtomicStruct
{
    f16vec2 inoutValues[32/2];
    f16vec2 inputValues[32];
    f16vec2 compareValues[32];
    f16vec2 outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;



layout(vertices = 1) out;

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
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;

	highp uint invocationId = uint(gl_PrimitiveID);
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicMax(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
