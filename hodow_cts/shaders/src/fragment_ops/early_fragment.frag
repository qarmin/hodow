#version 440
${extension}
${layout_qualifier}
layout(location = 0) out highp vec4 fragColor;

layout(binding = 0) coherent buffer Output {
    uint result;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.result, 1u);
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
