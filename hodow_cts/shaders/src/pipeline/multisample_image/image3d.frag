#version 450
layout(location = 0) out vec4 outColor;

layout(push_constant) uniform PushConsts {
    int width;
    int height;
    int numSamples;
} pc;

void main()
{
    int s = gl_SampleID;

    float R = float(int(gl_FragCoord.x) + s) / float(pc.width + pc.numSamples);
    float G = float(int(gl_FragCoord.y) + s) / float(pc.height + pc.numSamples);
    float B = (pc.numSamples > 1) ? float(s) / float(pc.numSamples - 1) : 0.0;
    float A = 1.0f;

    outColor = vec4(R, G, B, A);
}
