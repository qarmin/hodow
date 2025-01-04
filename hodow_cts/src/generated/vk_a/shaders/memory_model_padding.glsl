#version 450
#pragma use_vulkan_memory_model

struct A {
    int a;
};

struct B {
    int a, b;
};

struct C {
    int a, b, c;
};

struct BufferStructure {
    A subA[3];
    B subB[3];
    C subC[3];
};

layout (set=0, binding=0, std140) uniform InputBlock
{
    BufferStructure inBlock;
};

layout (set=0, binding=1, std140) buffer OutputBlock
{
    BufferStructure outBlock;
};

void main()
{
    const uint idx = gl_GlobalInvocationID.x;
    outBlock.subA[idx] = inBlock.subA[idx];
    outBlock.subB[idx] = inBlock.subB[idx];
    outBlock.subC[idx] = inBlock.subC[idx];
}
