#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer StorageBlock { uint values[]; } storageBuffer;
layout (push_constant, std430) uniform PushConstantBlock {
    uint dispatchOffset;
    uint skipIndex;
    uint valueOffset;
} pc;
void main (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    const uint valueIndex = pc.dispatchOffset + workGroupIndex * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint storageValue = pc.valueOffset + (workGroupIndex << 10) + gl_LocalInvocationIndex
        ;
    if (pc.skipIndex != gl_LocalInvocationIndex) {
        storageBuffer.values[valueIndex] = storageValue;
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer StorageBlock { uint values[]; } storageBuffer;
layout (push_constant, std430) uniform PushConstantBlock {
    uint dispatchOffset;
    uint skipIndex;
    uint valueOffset;
    uint valueOffset2;
} pc;
void main (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    const uint valueIndex = pc.dispatchOffset + workGroupIndex * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint storageValue = pc.valueOffset + (workGroupIndex << 10) + gl_LocalInvocationIndex
        + pc.valueOffset2
        ;
    if (pc.skipIndex != gl_LocalInvocationIndex) {
        storageBuffer.values[valueIndex] = storageValue;
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer StorageBlock { uint values[]; } storageBuffer;
layout (push_constant, std430) uniform PushConstantBlock {
    uint dispatchOffset;
    uint skipIndex;
    uint valueOffset;
    uint valueOffset2;
    uint sequenceIndex;
} pc;
void main (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    const uint valueIndex = pc.dispatchOffset + workGroupIndex * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint storageValue = pc.valueOffset + (workGroupIndex << 10) + gl_LocalInvocationIndex
        + pc.valueOffset2
        + pc.sequenceIndex
        ;
    if (pc.skipIndex != gl_LocalInvocationIndex) {
        storageBuffer.values[valueIndex] = storageValue;
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer StorageBlock { uint values[]; } storageBuffer;
layout (constant_id=0) const uint pc_dispatchOffset = 0u;
layout (constant_id=1) const uint pc_skipIndex = 0u;
layout (constant_id=2) const uint pc_valueOffset = 0u;
void main (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    const uint valueIndex = pc_dispatchOffset + workGroupIndex * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint storageValue = pc_valueOffset + (workGroupIndex << 10) + gl_LocalInvocationIndex
        ;
    if (pc_skipIndex != gl_LocalInvocationIndex) {
        storageBuffer.values[valueIndex] = storageValue;
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer StorageBlock { uint values[]; } storageBuffer;
layout (push_constant, std430) uniform PushConstantBlock {
    uint dispatchOffset;
    uint skipIndex;
} pc;
layout (constant_id=2) const uint pc_valueOffset = 0u;
void main (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    const uint valueIndex = pc.dispatchOffset + workGroupIndex * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint storageValue = pc_valueOffset + (workGroupIndex << 10) + gl_LocalInvocationIndex
        ;
    if (pc.skipIndex != gl_LocalInvocationIndex) {
        storageBuffer.values[valueIndex] = storageValue;
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer StorageBlock { uint values[]; } storageBuffer;
layout (push_constant, std430) uniform PushConstantBlock {
    uint dispatchOffset;
    uint skipIndex;
    uint sequenceIndex;
} pc;
layout (constant_id=2) const uint pc_valueOffset = 0u;
void main (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    const uint valueIndex = pc.dispatchOffset + workGroupIndex * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint storageValue = pc_valueOffset + (workGroupIndex << 10) + gl_LocalInvocationIndex
        + pc.sequenceIndex
        ;
    if (pc.skipIndex != gl_LocalInvocationIndex) {
        storageBuffer.values[valueIndex] = storageValue;
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer StorageBlock { uint values[]; } storageBuffer;
layout (push_constant, std430) uniform PushConstantBlock {
    uint valueOffset2;
    uint dispatchOffset;
    uint skipIndex;
} pc;
layout (constant_id=2) const uint pc_valueOffset = 0u;
void main (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    const uint valueIndex = pc.dispatchOffset + workGroupIndex * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint storageValue = pc_valueOffset + (workGroupIndex << 10) + gl_LocalInvocationIndex
        + pc.valueOffset2
        ;
    if (pc.skipIndex != gl_LocalInvocationIndex) {
        storageBuffer.values[valueIndex] = storageValue;
    }
}
