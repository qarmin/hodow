#version 450

layout(location=0) out vec4 outColor;
layout(push_constant, std430) uniform PushConstantBlock {
    float colorR;
    float colorG;
    float colorB;
    float colorA;
    float depth;
} pc;

layout (set=2, binding=0) uniform sampler globalSampler;
layout (set=2, binding=1) uniform sampler uglobalSampler;
layout (input_attachment_index=0, set=0, binding=0) uniform subpassInput attachment0;
layout (r32f, set=1, binding=0) uniform image2D storage0;

void main () {
    imageStore(storage0, ivec2(gl_FragCoord.xy), subpassLoad(attachment0));
    outColor = vec4(pc.colorR, pc.colorG, pc.colorB, pc.colorA);
}
