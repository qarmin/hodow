#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;

layout (set=0, binding=0) buffer OutputBlock { uint values[]; } ov;


void main ()
{
    gl_TaskCountNV = 0;
    ov.values[gl_WorkGroupID.x] = gl_WorkGroupID.x;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;



void main ()
{
    gl_PrimitiveCountNV = 0u;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

layout (set=0, binding=0) buffer OutputBlock { uint values[]; } ov;


void main ()
{
    gl_PrimitiveCountNV = 0u;
    ov.values[gl_WorkGroupID.x] = gl_WorkGroupID.x;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;

layout (set=0, binding=0) buffer OutputBlock { uint values[]; } ov;


void main ()
{
    gl_TaskCountNV = 0;
    ov.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;



void main ()
{
    gl_TaskCountNV = 65535;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

layout (set=0, binding=0) buffer OutputBlock { uint values[]; } ov;


void main ()
{
    gl_PrimitiveCountNV = 0u;
    ov.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;

layout (set=0, binding=0) buffer OutputBlock { uint values[]; } ov;
const uint arrayElements = 4096;
shared uint sharedArray[arrayElements];


void main ()
{
    gl_TaskCountNV = 0;

    if (gl_LocalInvocationID.x == 0u)
    {
        for (uint i = 0; i < arrayElements; ++i)
            sharedArray[i] = 0u;
    }

    memoryBarrierShared();
    barrier();

    for (uint i = 0; i < arrayElements; ++i)
        atomicAdd(sharedArray[i], 1u);

    memoryBarrierShared();
    barrier();

    uint allGood = 1u;
    for (uint i = 0; i < arrayElements; ++i)
    {
        if (sharedArray[i] != 32)
        {
            allGood = 0u;
            break;
        }
    }

    ov.values[gl_LocalInvocationID.x] = ((allGood == 1u) ? gl_LocalInvocationID.x : gl_WorkGroupSize.x);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

layout (set=0, binding=0) buffer OutputBlock { uint values[]; } ov;
const uint arrayElements = 4096;
shared uint sharedArray[arrayElements];


void main ()
{
    gl_PrimitiveCountNV = 0u;

    if (gl_LocalInvocationID.x == 0u)
    {
        for (uint i = 0; i < arrayElements; ++i)
            sharedArray[i] = 0u;
    }

    memoryBarrierShared();
    barrier();

    for (uint i = 0; i < arrayElements; ++i)
        atomicAdd(sharedArray[i], 1u);

    memoryBarrierShared();
    barrier();

    uint allGood = 1u;
    for (uint i = 0; i < arrayElements; ++i)
    {
        if (sharedArray[i] != 32)
        {
            allGood = 0u;
            break;
        }
    }

    ov.values[gl_LocalInvocationID.x] = ((allGood == 1u) ? gl_LocalInvocationID.x : gl_WorkGroupSize.x);
}
