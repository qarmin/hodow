#version 440
layout (local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) readonly buffer Input
{
    uint data[];
} sb_in;

layout(set = 0, binding = 1, std430) writeonly buffer Output
{
    uint result[];
} sb_out;

layout (push_constant, std430) uniform PushConstants
{
    uint bufferSize;
} pc;
void main (void)
{
    uint index = gl_GlobalInvocationID.y * gl_WorkGroupSize.x * 32 + gl_GlobalInvocationID.x;
    if (index < (pc.bufferSize / 4))
        sb_out.result[index] = sb_in.data[index];
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) readonly buffer Input
{
    volatile uint data[];
} sbIn;

layout(set = 0, binding = 1, std430) writeonly buffer Output
{
    bool result;
} sbOut;

layout (push_constant, std430) uniform PushConstants
{
    uint bufferSize;
    uint blockSize;
} pc;

void main (void)
{
    bool ok = true;
    uint bufferSizeInt = pc.bufferSize /4;
    uint blockSizeInt = pc.blockSize /4;
    for (uint offset = 0; offset < bufferSizeInt; offset += blockSizeInt)
    {
        uint val = sbIn.data[offset] & 0xFF;
;            ok = ok && (val == 0);
    }

    sbOut.result = ok;
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) readonly buffer Input
{
    volatile uint data[];
} sbIn;

layout(set = 0, binding = 1, std430) writeonly buffer Output
{
    bool result;
} sbOut;

layout (push_constant, std430) uniform PushConstants
{
    uint bufferSize;
    uint blockSize;
} pc;

void main (void)
{
    bool ok = true;
    uint bufferSizeInt = pc.bufferSize /4;
    uint blockSizeInt = pc.blockSize /4;
    for (uint offset = 0; offset < bufferSizeInt; offset += blockSizeInt)
    {
        uint val = sbIn.data[offset] & 0xFF;
;        uint idx = offset / blockSizeInt;
        if (mod(idx, 2) == 0)
            ok = ok && (val != 0);
        else
            ok = ok && (val == 0);
    }

    sbOut.result = ok;
}
