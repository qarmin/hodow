#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, r32ui) uniform uimageBuffer u_buf;
void main() {
    imageAtomicAdd(u_buf, 65536, 1u);
}
