#version 450
#extension GL_KHR_memory_scope_semantics: enable

layout(local_size_x = 256, local_size_y = 1, local_size_z = 1) in;

struct S
{
    uint data;
    uint flag;
};

layout(set = 0, binding = 0, std430) buffer Buf0
{
    S arr[];
} buf;

layout(set = 0, binding = 1, std430) buffer Buf1
{
    uint failures;
} bufOut;

uint permute(uint x)
{
    return (x * 419u) & 0xffff;
}

void main()
{
    // Message passing using data and flag pairs. The data is written to an index i, but the flag
    // used for synchronization is from a different index calculated using permute(i).

    uint i0 = gl_GlobalInvocationID.x;
    atomicStore(buf.arr[i0].data, 1u, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);

    // This barrier makes sure the order of the atomic store above and below does not change.
    // This guarantees the data is always written before the flag.
    memoryBarrierBuffer();

    atomicStore(buf.arr[permute(i0)].flag, 1u, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);

    // Read from an index which is presumably written by a different workgroup.
    uint i1 = (i0 * 4099u) & 0xffff;
    uint flag = atomicLoad(buf.arr[permute(i1)].flag, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire);

    // This barrier makes sure the atomic loads keep their execution order. That is, the flag is always read first.
    memoryBarrierBuffer();

    uint data = atomicLoad(buf.arr[i1].data, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire);

    // The flag should never be written before data.
    if (flag > data)
    {
        atomicAdd(bufOut.failures, 1u);
    }
}
#version 450
#extension GL_KHR_memory_scope_semantics: enable

layout(local_size_x = 256, local_size_y = 1, local_size_z = 1) in;

struct S
{
    uint data;
    uint flag;
};

layout(set = 0, binding = 0, std430) buffer Buf0
{
    S arr[];
} buf;

layout(set = 0, binding = 1, std430) buffer Buf1
{
    uint failures;
} bufOut;

uint permute(uint x)
{
    return (x * 419u) & 0xffff;
}

void main()
{
    // Message passing using data and flag pairs. The data is written to an index i, but the flag
    // used for synchronization is from a different index calculated using permute(i).

    uint i0 = gl_GlobalInvocationID.x;
    atomicStore(buf.arr[i0].data, 1u, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
    atomicStore(buf.arr[permute(i0)].flag, 1u, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);

    // Read from an index which is presumably written by a different workgroup.
    uint i1 = (i0 * 4099u) & 0xffff;
    uint flag = atomicLoad(buf.arr[permute(i1)].flag, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire);
    uint data = atomicLoad(buf.arr[i1].data, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire);

    // The flag should never be written before data.
    if (flag > data)
    {
        atomicAdd(bufOut.failures, 1u);
    }
}
#version 450
#extension GL_KHR_memory_scope_semantics: enable

layout(local_size_x = 256, local_size_y = 1, local_size_z = 1) in;

struct S
{
    uint data;
    uint flag;
};

layout(set = 0, binding = 0, std430) buffer Buf0
{
    coherent S arr[];
} buf;

layout(set = 0, binding = 1, std430) buffer Buf1
{
    uint failures;
} bufOut;

uint permute(uint x)
{
    return (x * 419u) & 0xffff;
}

void main()
{
    // Message passing using data and flag pairs. The data is written to an index i, but the flag
    // used for synchronization is from a different index calculated using permute(i).

    uint i0 = gl_GlobalInvocationID.x;
    buf.arr[i0].data = 1u;
    atomicStore(buf.arr[permute(i0)].flag, 1u, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);

    // Read from an index which is presumably written by a different workgroup.
    uint i1 = (i0 * 4099u) & 0xffff;
    uint flag = atomicLoad(buf.arr[permute(i1)].flag, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire);
    uint data = buf.arr[i1].data;

    // The flag should never be written before data.
    if (flag > data)
    {
        atomicAdd(bufOut.failures, 1u);
    }
}
