#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout(early_fragment_tests) in;
void main(void)
{
    fragColor = pc.color;
}
