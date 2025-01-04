#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
