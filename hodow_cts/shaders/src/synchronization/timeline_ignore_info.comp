#version 460
layout (local_size_x=1) in;
layout (push_constant, std430) uniform PCBlock { uint value; } pc;
layout (set=0, binding=0, std430) buffer BufferBlock { uint value; } ssbo;
void main (void) {
    ssbo.value = pc.value;
}
