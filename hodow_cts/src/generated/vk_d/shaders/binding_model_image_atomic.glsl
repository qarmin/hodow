#version 450
#extension GL_EXT_nonuniform_qualifier : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(r32ui, set = 0, binding = 0) uniform uimage2D images[];

void main()
{
    const uint index = gl_GlobalInvocationID.x;
    const uint value = 0x89abcedfu;
    imageAtomicOr(images[nonuniformEXT(index)], ivec2(0), value);
}
