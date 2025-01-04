#version 440

layout(location = 0) in highp vec4 a_position;
layout(location = 0) out highp vec4 a_color;

void main (void)
{
    gl_Position = a_position;
    if (gl_VertexIndex < 6)
        a_color = vec4(0.75f, 0.75f, 0.75f, 1.0f);
    else
        a_color = vec4(1.00f, 1.00f, 1.00f, 1.0f);
}
#version 440

layout(location = 0) in highp vec4 a_color;
layout(location = 0) out highp vec4 o_color;

void main (void)
{
    o_color = a_color;
}
#version 440

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
}
#version 440

layout(set = 0, binding = 0) uniform sampler2DMS u_ms_image_sampler;
layout(push_constant) uniform PushConstantsBlock {
    highp int sampleID;
} pushConstants;
layout(location = 0) out highp vec4 o_color;

void main (void)
{
    o_color = texelFetch(u_ms_image_sampler, ivec2(gl_FragCoord.xy), pushConstants.sampleID);
}
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
#version 440

layout(location = 0) in highp vec4 a_position;
layout(location = 0) out highp vec4 a_color;

void main (void)
{
    gl_Position = a_position;
    if (gl_VertexIndex < 3)
        a_color = vec4(0.00f, 0.00f, 1.00f, 1.0f);
    else
        a_color = vec4(0.00f, 1.00f, 0.00f, 1.0f);
}
#version 440

layout(location = 0) in highp vec4 a_position;
layout(location = 0) out highp vec4 a_color;

void main (void)
{
    gl_Position = a_position;
    a_color = vec4(0.0f, 0.0f, 1.0f, 1.0f);
}
#version 440

layout(input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput u_colors;
layout(location = 0) out highp vec4 o_color;

void main (void)
{
    o_color = subpassLoad(u_colors);
    o_color.g = 1.0f;
    o_color.a = 1.0f;
}
