#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_NV_shader_atomic_fp16_vector : require
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    f16vec2 inoutValues[32/2];
    f16vec2 inputValues[32];
    f16vec2 compareValues[32];
    f16vec2 outputValues[32];
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
	    buf.data.outputValues[idx] = atomicAdd(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	o_outData = outData;
}
