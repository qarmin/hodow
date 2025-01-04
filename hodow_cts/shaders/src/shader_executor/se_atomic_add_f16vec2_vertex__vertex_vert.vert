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
