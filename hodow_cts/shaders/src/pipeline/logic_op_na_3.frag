#version 430
layout(push_constant) uniform quadColor {
    vec4 val;
} QUAD_COLOR;
layout(location = 0) out vec3 fragColor;
void main (void)
{
    fragColor = vec3(QUAD_COLOR.val.rgb);
}
