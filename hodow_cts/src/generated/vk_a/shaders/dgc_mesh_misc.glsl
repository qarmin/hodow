#version 460
#extension GL_EXT_mesh_shader : enable
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;
layout (set=0, binding=0, std430) buffer OutputBlock { uint values[]; } outputBuffer;
layout (push_constant, std430) uniform PushConstantBlock { uint valueIndex; } pc;
void main (void) {
    atomicAdd(outputBuffer.values[pc.valueIndex], 1u);
    SetMeshOutputsEXT(0, 0);
}
#version 460
#extension GL_EXT_mesh_shader : enable
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer OutputBlock { uint values[]; } outputBuffer;
layout (push_constant, std430) uniform PushConstantBlock { uint valueIndex; } pc;
void main (void) {
    atomicAdd(outputBuffer.values[pc.valueIndex], 1u);
    EmitMeshTasksEXT(0, 0, 0);
}
#version 460
#extension GL_EXT_mesh_shader : enable
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (push_constant, std430) uniform PCBlock { uint prevWGCount; } pc;
layout (set=0, binding=0, std430) buffer OutputBlock { uint values[1024]; } meshBuffer;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;
void main() {
    const uint globalWorkGroupID = pc.prevWGCount + gl_WorkGroupID.x;
    const uint slotIndex = globalWorkGroupID * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint value = 1000000 + globalWorkGroupID * 1000 + gl_LocalInvocationIndex;
    meshBuffer.values[slotIndex] = value;
    SetMeshOutputsEXT(0u, 0u);
}
#version 460
#extension GL_EXT_mesh_shader : enable
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (push_constant, std430) uniform PCBlock { uint prevWGCount; } pc;
layout (set=0, binding=0, std430) buffer OutputBlock { uint values[1024]; } meshBuffer;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;
void main() {
    const uint globalWorkGroupID = pc.prevWGCount + gl_WorkGroupID.x;
    const uint slotIndex = globalWorkGroupID * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint value = 2000000 + globalWorkGroupID * 1000 + gl_LocalInvocationIndex;
    meshBuffer.values[slotIndex] = value;
    SetMeshOutputsEXT(0u, 0u);
}
#version 460
#extension GL_EXT_mesh_shader : enable
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (push_constant, std430) uniform PCBlock { uint prevWGCount; } pc;
layout (set=0, binding=0, std430) buffer OutputBlock { uint values[1024]; } taskBuffer;
struct TaskData {
    uint globalWorkGroupID;
};
taskPayloadSharedEXT TaskData td;
void main() {
    const uint globalWorkGroupID = pc.prevWGCount + gl_WorkGroupID.x;
    const uint slotIndex = globalWorkGroupID * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint value = 1000000 + globalWorkGroupID * 1000 + gl_LocalInvocationIndex;
    taskBuffer.values[slotIndex] = value;
    if (gl_LocalInvocationIndex == 0u) {
        td.globalWorkGroupID = globalWorkGroupID;
    }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 460
#extension GL_EXT_mesh_shader : enable
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
struct TaskData {
    uint globalWorkGroupID;
};
taskPayloadSharedEXT TaskData td;
layout (set=0, binding=1, std430) buffer OutputBlock { uint values[1024]; } meshBuffer;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;
void main() {
    const uint globalWorkGroupID = td.globalWorkGroupID;
    const uint slotIndex = globalWorkGroupID * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint value = 3000000 + globalWorkGroupID * 1000 + gl_LocalInvocationIndex;
    meshBuffer.values[slotIndex] = value;
    SetMeshOutputsEXT(0u, 0u);
}
#version 460
#extension GL_EXT_mesh_shader : enable
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (push_constant, std430) uniform PCBlock { uint prevWGCount; } pc;
layout (set=0, binding=0, std430) buffer OutputBlock { uint values[1024]; } taskBuffer;
struct TaskData {
    uint globalWorkGroupID;
};
taskPayloadSharedEXT TaskData td;
void main() {
    const uint globalWorkGroupID = pc.prevWGCount + gl_WorkGroupID.x;
    const uint slotIndex = globalWorkGroupID * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint value = 2000000 + globalWorkGroupID * 1000 + gl_LocalInvocationIndex;
    taskBuffer.values[slotIndex] = value;
    if (gl_LocalInvocationIndex == 0u) {
        td.globalWorkGroupID = globalWorkGroupID;
    }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 460
#extension GL_EXT_mesh_shader : enable
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
struct TaskData {
    uint globalWorkGroupID;
};
taskPayloadSharedEXT TaskData td;
layout (set=0, binding=1, std430) buffer OutputBlock { uint values[1024]; } meshBuffer;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;
void main() {
    const uint globalWorkGroupID = td.globalWorkGroupID;
    const uint slotIndex = globalWorkGroupID * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    const uint value = 4000000 + globalWorkGroupID * 1000 + gl_LocalInvocationIndex;
    meshBuffer.values[slotIndex] = value;
    SetMeshOutputsEXT(0u, 0u);
}
