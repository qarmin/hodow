#version 440
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) writeonly buffer Output
{
    uint result[];
} sb_out;

void main (void)
{
    uint index = gl_GlobalInvocationID.x + (gl_GlobalInvocationID.y + gl_GlobalInvocationID.z*gl_NumWorkGroups.y*gl_WorkGroupSize.y)*gl_NumWorkGroups.x*gl_WorkGroupSize.x;
    if ( index < 256u )
    {
        sb_out.result[index] = index % 1024u;
    }
}
#version 440
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) writeonly buffer Output
{
    uint result[];
} sb_out;

void main (void)
{
    uint index = gl_GlobalInvocationID.x + (gl_GlobalInvocationID.y + gl_GlobalInvocationID.z*gl_NumWorkGroups.y*gl_WorkGroupSize.y)*gl_NumWorkGroups.x*gl_WorkGroupSize.x;
    if ( index < 1024u )
    {
        sb_out.result[index] = index % 1024u;
    }
}
#version 440
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) writeonly buffer Output
{
    uint result[];
} sb_out;

void main (void)
{
    uint index = gl_GlobalInvocationID.x + (gl_GlobalInvocationID.y + gl_GlobalInvocationID.z*gl_NumWorkGroups.y*gl_WorkGroupSize.y)*gl_NumWorkGroups.x*gl_WorkGroupSize.x;
    if ( index < 16384u )
    {
        sb_out.result[index] = index % 1024u;
    }
}
#version 440
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) writeonly buffer Output
{
    uint result[];
} sb_out;

void main (void)
{
    uint index = gl_GlobalInvocationID.x + (gl_GlobalInvocationID.y + gl_GlobalInvocationID.z*gl_NumWorkGroups.y*gl_WorkGroupSize.y)*gl_NumWorkGroups.x*gl_WorkGroupSize.x;
    if ( index < 32768u )
    {
        sb_out.result[index] = index % 1024u;
    }
}
#version 440
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) writeonly buffer Output
{
    uint result[];
} sb_out;

void main (void)
{
    uint index = gl_GlobalInvocationID.x + (gl_GlobalInvocationID.y + gl_GlobalInvocationID.z*gl_NumWorkGroups.y*gl_WorkGroupSize.y)*gl_NumWorkGroups.x*gl_WorkGroupSize.x;
    if ( index < 262144u )
    {
        sb_out.result[index] = index % 1024u;
    }
}
#version 440
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) writeonly buffer Output
{
    uint result[];
} sb_out;

void main (void)
{
    uint index = gl_GlobalInvocationID.x + (gl_GlobalInvocationID.y + gl_GlobalInvocationID.z*gl_NumWorkGroups.y*gl_WorkGroupSize.y)*gl_NumWorkGroups.x*gl_WorkGroupSize.x;
    if ( index < 4194304u )
    {
        sb_out.result[index] = index % 1024u;
    }
}
