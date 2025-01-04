#version 450

struct Bar {
    uint x;
    uint y;
    uint z[2];
};

layout(set = 0, binding = 0, std430) buffer foo {
    uvec4 a;
    Bar b; // size 16 at offset 16
    uint c;
};

void main() {
    Bar new_bar;
    b = new_bar;
}
