#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout(depth_greater) out float gl_FragDepth;
void main(void)
{
    gl_FragDepth = pc.depth;
    fragColor = pc.color;
}
