#version 310 es
layout(local_size_x = 1u, local_size_y = 1u, local_size_z = 1u) in;
layout(set = 0, binding = 0, std140) buffer Out
{
    coherent uint count;
};
void main(void)
{
    atomicAdd(count, 1u);
}
