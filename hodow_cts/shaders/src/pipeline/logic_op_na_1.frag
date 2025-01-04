#version 430
layout(push_constant) uniform quadColor {
    vec4 val;
} QUAD_COLOR;
layout(location = 0) out float fragColor;
void main (void)
{
    fragColor = float(QUAD_COLOR.val.r);
}
