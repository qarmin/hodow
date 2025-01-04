#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
void main(void)
{
    if (pc.color.a < 0.01)
        discard;
    fragColor = pc.color;
}
