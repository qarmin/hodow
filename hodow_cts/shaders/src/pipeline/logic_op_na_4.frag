#version 430
layout(push_constant) uniform quadColor {
    vec4 val;
} QUAD_COLOR;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    fragColor = vec4(QUAD_COLOR.val);
}
