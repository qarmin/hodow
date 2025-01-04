#version 450
layout(location=0) in vec4 inPosition;

void main() {
    gl_Position = inPosition;
}
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
#version 450

layout(push_constant) uniform PushConsts {
    int width;
    int height;
    int numSamples;
} pc;
layout(set=0, binding=0) buffer Results {
    vec4 resultFlags[];
};
layout(set=0, binding=1) buffer Expects {
    vec4 expectedFlags[];
};
layout(input_attachment_index=0, set=1, binding=0) uniform subpassInputMS msImageAtt;

void main() {
    for (int s = 0; s < pc.numSamples; ++s) {
        vec4 resValue = subpassLoad(msImageAtt, s);

        float R = float(int(gl_FragCoord.x) + s) / float(pc.width + pc.numSamples);
        float G = float(int(gl_FragCoord.y) + s) / float(pc.height + pc.numSamples);
        float B = (pc.numSamples > 1) ? float(s) / float(pc.numSamples - 1) : 0.0f;
        float A = 1.0f;
        vec4 expectedValue = vec4(R, G, B, A);

        ivec3 coords  = ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), s);
        int bufferPos = (coords.y * pc.width + coords.x) * pc.numSamples + coords.z;
        expectedFlags[bufferPos] = expectedValue; 
        resultFlags[bufferPos] = resValue; 
    }
}
