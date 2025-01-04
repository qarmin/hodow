#version 440

layout(location = 0) in highp vec4 position;

out gl_PerVertex {
   vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
#version 440

layout(early_fragment_tests) in;
layout(location = 0) out highp vec4 fragColor;

layout(binding = 0) coherent buffer Output {
    uint result;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.result, 1u);
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 440


layout(location = 0) out highp vec4 fragColor;

layout(binding = 0) coherent buffer Output {
    uint result;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.result, 1u);
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 440
#extension GL_AMD_shader_early_and_late_fragment_tests : require
layout(early_and_late_fragment_tests_amd) in;
layout(location = 0) out highp vec4 fragColor;

layout(binding = 0) coherent buffer Output {
    uint result;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.result, 1u);
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 440

layout(early_fragment_tests) in;

layout(location = 0) out highp vec4 fragColor;

layout(binding = 0) coherent buffer Output {
    uint result;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.result, 1u);
    gl_FragDepth = 0.75f;
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
    discard;
}
#version 440



layout(location = 0) out highp vec4 fragColor;

layout(binding = 0) coherent buffer Output {
    uint result;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.result, 1u);
    gl_FragDepth = 0.75f;
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
    discard;
}
#version 440
#extension GL_AMD_shader_early_and_late_fragment_tests : require
layout(early_and_late_fragment_tests_amd) in;
layout(depth_greater) out float gl_FragDepth;
layout(location = 0) out highp vec4 fragColor;

layout(binding = 0) coherent buffer Output {
    uint result;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.result, 1u);
    gl_FragDepth = 0.75f;
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
    discard;
}
