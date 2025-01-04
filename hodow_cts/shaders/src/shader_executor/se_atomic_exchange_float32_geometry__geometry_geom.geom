#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable

struct AtomicStruct
{
    float inoutValues[32/2];
    float inputValues[32];
    float compareValues[32];
    float outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicExchange(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
