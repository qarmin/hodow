#version 450
#extension GL_EXT_buffer_reference : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430, buffer_reference) buffer T1 {
    int a;
};

struct Foo {
    T1 b;
};

layout(set = 0, binding = 0, std430) buffer storage_buffer {
    uint index;
    // offset 4..7 is std430 padding
    Foo f[];  // each item is 8 bytes: one buffer reference
} foo;

void main() {
    Foo new_foo = foo.f[foo.index];
    new_foo.b.a = 2;
}
