#version 440

layout(binding = 0) uniform sampler2DMS u_ms_image_sampler;
layout(push_constant) uniform PushConstantsBlock {
    highp int sampleID;
} pushConstants;
layout(location = 0) out highp vec4 o_color;

void main (void)
{
    vec4 val = texelFetch(u_ms_image_sampler, ivec2(gl_FragCoord.xy), pushConstants.sampleID);
    o_color = vec4(val.x, val.x, val.x, 1.0);
}
