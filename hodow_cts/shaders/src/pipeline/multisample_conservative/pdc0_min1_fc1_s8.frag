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
