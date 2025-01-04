#version 440
${sampler_decl}
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 ${frag_color_decl};
void main (void)
{
${body}}
