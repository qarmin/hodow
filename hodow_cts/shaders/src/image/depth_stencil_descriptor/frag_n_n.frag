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

void main () {
    outColor = vec4(pc.colorR, pc.colorG, pc.colorB, pc.colorA);
}
