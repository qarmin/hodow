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
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    fragColor = vtxColor * (1.0 / 2 * coveredSamples);
}
#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    fragColor = vtxColor * (1.0 / 4 * coveredSamples);
}
#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    fragColor = vtxColor * (1.0 / 7 * coveredSamples);
}
#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    fragColor = vtxColor * (1.0 / 8 * coveredSamples);
}
#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    fragColor = vtxColor * (1.0 / 14 * coveredSamples);
}
#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    fragColor = vtxColor * (1.0 / 16 * coveredSamples);
}
#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    fragColor = vtxColor * (1.0 / 28 * coveredSamples);
}
#version 440
layout(early_fragment_tests) in;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const int coveredSamples = bitCount(gl_SampleMaskIn[0]);
    fragColor = vtxColor * (1.0 / 56 * coveredSamples);
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
    fragColor = vtxColor * (1.0 / 2 * coveredSamples);
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
    fragColor = vtxColor * (1.0 / 4 * coveredSamples);
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
    fragColor = vtxColor * (1.0 / 8 * coveredSamples);
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
    fragColor = vtxColor * (1.0 / 16 * coveredSamples);
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
    fragColor = vtxColor * (1.0 / 32 * coveredSamples);
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
    fragColor = vtxColor * (1.0 / 64 * coveredSamples);
}
