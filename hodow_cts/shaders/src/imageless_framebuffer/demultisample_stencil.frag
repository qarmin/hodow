#version 440

layout(binding = 0) uniform usampler2DMS u_ms_image_sampler;
layout(push_constant) uniform PushConstantsBlock {
    highp int sampleID;
} pushConstants;
layout(location = 0) out highp vec4 o_color;

void main (void)
{
    uvec4 uVal = texelFetch(u_ms_image_sampler, ivec2(gl_FragCoord.xy), pushConstants.sampleID);
    float val = float(uVal.x) / 4.0f;
    o_color = vec4(val, val, val, 1.0);
}
