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


layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
