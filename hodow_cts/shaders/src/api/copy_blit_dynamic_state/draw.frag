#version 450
layout(location = 0) out vec4 outColor;

layout(push_constant) uniform PushConsts {
    int drawCount;
    int width;
    int height;
    int numSamples;
} pc;

void main()
{
    int s = gl_SampleID;
    if (((pc.drawCount == 0) && ((s % 2) == 0)) || ((pc.drawCount != 0) && ((s % 2) != 0))) {

        float R = float(int(gl_FragCoord.x) + s) / float(pc.width + pc.numSamples);
        float G = float(int(gl_FragCoord.y) + s) / float(pc.height + pc.numSamples);
        float B = (pc.numSamples > 1) ? float(s) / float(pc.numSamples - 1) : 0.0f;
        float A = 1.0f;

        outColor = vec4(R, G, B, A);
    }
 else outColor = vec4(0.0f, 0.0f, 0.0f, 0.0f);}
