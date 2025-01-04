#version 430
layout(push_constant) uniform quadColor {
    uvec4 val;
} QUAD_COLOR;
layout(location = 0) out uvec4 fragColor;
void main (void)
{
    fragColor = QUAD_COLOR.val;
}
