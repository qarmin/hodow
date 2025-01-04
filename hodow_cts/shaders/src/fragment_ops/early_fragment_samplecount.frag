#version 450

layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    // This will kill half of the samples.
    gl_SampleMask[0] = 0xAAAAAAAA;
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
