#version 440
layout(set = 0, binding = 0) uniform highp ${sampler_type} texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = ${lookup} * pc.scale + pc.bias;
}
