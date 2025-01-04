#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout(depth_less) out float gl_FragDepth;
void main(void)
{
    gl_FragDepth = 1.0 - pc.depth;
    fragColor = pc.color;
}
