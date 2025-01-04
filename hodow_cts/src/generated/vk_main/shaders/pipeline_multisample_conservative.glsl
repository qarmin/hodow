#version 310 es
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
layout(location = 0) out highp vec4 vtxColor;
void main (void)
{
    gl_Position = position;
    vtxColor = color;
}
#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    vec4 color = vtxColor;
    fragColor = color;
}
#version 440
void main (void)
{
    const vec4 positions[4] = vec4[4](
        vec4(-1.0, -1.0, 0.0, 1.0),
        vec4(-1.0,  1.0, 0.0, 1.0),
        vec4( 1.0, -1.0, 0.0, 1.0),
        vec4( 1.0,  1.0, 0.0, 1.0)
    );
    gl_Position = positions[gl_VertexIndex];
}
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
#version 440
#extension GL_NV_conservative_raster_underestimation : enable
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    vec4 color = vtxColor;
    if (!gl_FragFullyCoveredNV) color = vec4(0.0f);
    fragColor = color;
}
#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 2 * coveredSamples);
    fragColor = color;
}
#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 4 * coveredSamples);
    fragColor = color;
}
#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 8 * coveredSamples);
    fragColor = color;
}
#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 16 * coveredSamples);
    fragColor = color;
}
#version 440
#extension GL_NV_conservative_raster_underestimation : enable
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 2 * coveredSamples);
    if (!gl_FragFullyCoveredNV) color = vec4(0.0f);
    fragColor = color;
}
#version 440
#extension GL_NV_conservative_raster_underestimation : enable
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 4 * coveredSamples);
    if (!gl_FragFullyCoveredNV) color = vec4(0.0f);
    fragColor = color;
}
#version 440
#extension GL_NV_conservative_raster_underestimation : enable
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 8 * coveredSamples);
    if (!gl_FragFullyCoveredNV) color = vec4(0.0f);
    fragColor = color;
}
#version 440
#extension GL_NV_conservative_raster_underestimation : enable
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 16 * coveredSamples);
    if (!gl_FragFullyCoveredNV) color = vec4(0.0f);
    fragColor = color;
}
#version 440
#extension GL_ARB_post_depth_coverage : require
layout(early_fragment_tests) in;
layout(post_depth_coverage) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    vec4 color = vtxColor;
    fragColor = color;
}
#version 440
#extension GL_ARB_post_depth_coverage : require
#extension GL_NV_conservative_raster_underestimation : enable
layout(early_fragment_tests) in;
layout(post_depth_coverage) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    vec4 color = vtxColor;
    if (!gl_FragFullyCoveredNV) color = vec4(0.0f);
    fragColor = color;
}
#version 440
#extension GL_ARB_post_depth_coverage : require
layout(early_fragment_tests) in;
layout(post_depth_coverage) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 2 * coveredSamples);
    fragColor = color;
}
#version 440
#extension GL_ARB_post_depth_coverage : require
layout(early_fragment_tests) in;
layout(post_depth_coverage) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 4 * coveredSamples);
    fragColor = color;
}
#version 440
#extension GL_ARB_post_depth_coverage : require
layout(early_fragment_tests) in;
layout(post_depth_coverage) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 8 * coveredSamples);
    fragColor = color;
}
#version 440
#extension GL_ARB_post_depth_coverage : require
layout(early_fragment_tests) in;
layout(post_depth_coverage) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 16 * coveredSamples);
    fragColor = color;
}
#version 440
#extension GL_ARB_post_depth_coverage : require
#extension GL_NV_conservative_raster_underestimation : enable
layout(early_fragment_tests) in;
layout(post_depth_coverage) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 2 * coveredSamples);
    if (!gl_FragFullyCoveredNV) color = vec4(0.0f);
    fragColor = color;
}
#version 440
#extension GL_ARB_post_depth_coverage : require
#extension GL_NV_conservative_raster_underestimation : enable
layout(early_fragment_tests) in;
layout(post_depth_coverage) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 4 * coveredSamples);
    if (!gl_FragFullyCoveredNV) color = vec4(0.0f);
    fragColor = color;
}
#version 440
#extension GL_ARB_post_depth_coverage : require
#extension GL_NV_conservative_raster_underestimation : enable
layout(early_fragment_tests) in;
layout(post_depth_coverage) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 8 * coveredSamples);
    if (!gl_FragFullyCoveredNV) color = vec4(0.0f);
    fragColor = color;
}
#version 440
#extension GL_ARB_post_depth_coverage : require
#extension GL_NV_conservative_raster_underestimation : enable
layout(early_fragment_tests) in;
layout(post_depth_coverage) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    vec4 color = vtxColor * (1.0 / 16 * coveredSamples);
    if (!gl_FragFullyCoveredNV) color = vec4(0.0f);
    fragColor = color;
}
