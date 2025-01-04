#version 310 es

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer Output
{
    int result[];
} sb_out;
void main (void)
{
    highp uint ndx = gl_GlobalInvocationID.x;
    sb_out.result[ndx] = int(ndx);
}
#version 310 es

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer Output
{
    int result[];
} sb_out;
void main (void)
{
    for (highp uint ndx = 0u; ndx < 16u; ndx++)
    {
        sb_out.result[ndx] = int(ndx);
    }
}
#version 310 es

layout(local_size_x = 16, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer Output
{
    int result[];
} sb_out;
void main (void)
{
    highp uint ndx = gl_LocalInvocationID.x;
    sb_out.result[ndx] = int(ndx);
}
#version 440

layout(set = 0, binding = 0, std430) buffer Output
{
    int result[];
} sb_out;

void main (void)
{
   sb_out.result[gl_VertexIndex] = int(gl_VertexIndex);
   gl_PointSize = 1.0f;
}
#version 440

layout(set = 0, binding = 0, std430) buffer Output
{
    int result[];
} sb_out;

void main (void)
{
    for (highp uint ndx = 0u; ndx < 16u; ndx++)
    {
        sb_out.result[ndx] = int(ndx);
    }
    gl_PointSize = 1.0f;
}
#version 440

layout(set = 0, binding = 0, std430) buffer Output
{
    int result[];
} sb_out;

void main (void)
{
    for (int ndx = 15; ndx >= 0; ndx--)
    {
        sb_out.result[uint(ndx)] = ndx;
    }
    gl_PointSize = 1.0f;
}
#version 440

layout(location = 0) out vec4 o_color;

void main (void)
{
    o_color = vec4(1.0);
}
