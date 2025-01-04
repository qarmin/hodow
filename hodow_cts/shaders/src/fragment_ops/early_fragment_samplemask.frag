#version 440

${layout_qualifier}
layout(location = 0) out highp vec4 fragColor;

layout(binding = 0) coherent buffer Output {
    uint result;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.result, 1u);
    gl_SampleMask[0] = 0x0;
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
    discard;
}
