#version 460
#extension GL_KHR_memory_scope_semantics : enable
layout (set=0, binding=0, std430) buffer AtomicCountersBlock {
    uint value[256];
} atomicCounters;
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
void main ()
{
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    atomicAdd(atomicCounters.value[workGroupIndex], 1u, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, (gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable | gl_SemanticsMakeVisible));
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
struct VkDispatchIndirectCommand {
    uint x;
    uint y;
    uint z;
};
const uint sequenceCount = 4u;
layout (set=0, binding=0, std430) readonly buffer HostBufferCommands {
    VkDispatchIndirectCommand commands[sequenceCount];
} hostBuffer;
layout (set=0, binding=1, std430) buffer IndirectCommandsBlock {
    VkDispatchIndirectCommand commands[sequenceCount];
} cmdBuffer;
void main (void) {
    const uint commandsPerInv = 1;
    const uint firstCommand = gl_LocalInvocationIndex * commandsPerInv;
    for (uint i = 0u; i < commandsPerInv; ++i) {
        const uint cmdIndex = firstCommand + i;
        if (cmdIndex < sequenceCount) {
            cmdBuffer.commands[cmdIndex] = hostBuffer.commands[cmdIndex];
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
struct VkDispatchIndirectCommand {
    uint x;
    uint y;
    uint z;
};
const uint sequenceCount = 1024u;
layout (set=0, binding=0, std430) readonly buffer HostBufferCommands {
    VkDispatchIndirectCommand commands[sequenceCount];
} hostBuffer;
layout (set=0, binding=1, std430) buffer IndirectCommandsBlock {
    VkDispatchIndirectCommand commands[sequenceCount];
} cmdBuffer;
void main (void) {
    const uint commandsPerInv = 16;
    const uint firstCommand = gl_LocalInvocationIndex * commandsPerInv;
    for (uint i = 0u; i < commandsPerInv; ++i) {
        const uint cmdIndex = firstCommand + i;
        if (cmdIndex < sequenceCount) {
            cmdBuffer.commands[cmdIndex] = hostBuffer.commands[cmdIndex];
        }
    }
}
