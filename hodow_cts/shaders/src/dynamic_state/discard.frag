#version 450

layout (set=0, binding=0, std140) uniform InputBlock {
    int discard_all;
} unif;

layout (location = 0) in vec4 in_color;

layout (location = 0) out vec4 color;

void main ()
{
    if (unif.discard_all == 0) {
        discard;
    }
    color = in_color;
}
