#version 450

layout (set=0, binding=0, std430) buffer OutputBlock {
    uint flags[];
} ssbo;

void main (void) {
    ssbo.flags[uint(gl_FragCoord.x)] = 1u;
}
