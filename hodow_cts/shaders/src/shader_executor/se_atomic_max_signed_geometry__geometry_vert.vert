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


layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
