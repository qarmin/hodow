#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    vec4 color = vtxColor;
    fragColor = color;
}
