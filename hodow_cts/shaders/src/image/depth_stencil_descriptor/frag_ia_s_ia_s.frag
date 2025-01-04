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
layout (set=0, binding=1) uniform texture2D sampledImage1;
layout (r32f, set=1, binding=1) uniform image2D storage1;
layout (input_attachment_index=1, set=0, binding=2) uniform usubpassInput attachment2;
layout (r32ui, set=1, binding=2) uniform uimage2D storage2;
layout (set=0, binding=3) uniform utexture2D sampledImage3;
layout (r32ui, set=1, binding=3) uniform uimage2D storage3;

void main () {
    imageStore(storage0, ivec2(gl_FragCoord.xy), subpassLoad(attachment0));
    imageStore(storage1, ivec2(gl_FragCoord.xy), texture(sampler2D(sampledImage1, globalSampler), gl_FragCoord.xy));
    imageStore(storage2, ivec2(gl_FragCoord.xy), subpassLoad(attachment2));
    imageStore(storage3, ivec2(gl_FragCoord.xy), texture(usampler2D(sampledImage3, uglobalSampler), gl_FragCoord.xy));
    outColor = vec4(pc.colorR, pc.colorG, pc.colorB, pc.colorA);
}
