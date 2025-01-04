#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout (binding = 0, rgba8) uniform writeonly image2D outImage;
void main(void)
{
    imageStore(outImage, ivec2(mod(gl_FragCoord.xy, 4.0)), vec4(2.0));
    fragColor = pc.color;
}
