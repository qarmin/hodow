#version 460
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0) buffer OutputBlock { uint value; } outBuffer;
void main (void)
{
    outBuffer.value += 1048576u;
}
