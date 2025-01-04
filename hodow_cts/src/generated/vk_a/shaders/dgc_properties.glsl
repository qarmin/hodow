#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer OutputBlock { uint values[15]; } outputBuffer;
layout (push_constant, std430) uniform PushConstantBlock { uint values[15]; } pc;
void main (void) {
    for (uint i = 0u; i < 15u; ++i) {
        outputBuffer.values[i] = pc.values[i];
    }
}
#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer OutputBlock { uint values[31]; } outputBuffer;
layout (push_constant, std430) uniform PushConstantBlock { uint values[31]; } pc;
void main (void) {
    for (uint i = 0u; i < 31u; ++i) {
        outputBuffer.values[i] = pc.values[i];
    }
}
#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer OutputBlock { uint value; } outputBuffer;
layout (push_constant, std430) uniform PushConstantBlock { uint value; } pc;
void main (void) {
    atomicOr(outputBuffer.value, (pc.value << (8 * gl_WorkGroupID.z)));
}
#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer OutputBlock { uint values[]; } outputBuffer;
layout (push_constant, std430) uniform PushConstantBlock { uint index; uint value; } pc;
void main (void) { outputBuffer.values[pc.index] = pc.value; }
