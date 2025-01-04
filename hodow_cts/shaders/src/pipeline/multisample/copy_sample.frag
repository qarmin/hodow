#version 440
precision highp float;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 0, input_attachment_index = 0) uniform subpassInputMS imageMS;
layout(push_constant) uniform PushConstantsBlock
{
    int sampleId;
} pushConstants;
void main (void)
{
    fragColor = subpassLoad(imageMS, pushConstants.sampleId);
}
