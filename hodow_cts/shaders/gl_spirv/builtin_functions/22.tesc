#version 450

layout (vertices = 3) out;

void main()
{
    barrier();

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
