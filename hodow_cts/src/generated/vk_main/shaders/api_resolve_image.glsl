#version 310 es
layout (location = 0) in highp vec4 a_position;
void main()
{
    gl_Position = a_position;
}
#version 310 es
layout (location = 0) out highp vec4 o_color;
void main()
{
    o_color = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 450

layout (push_constant, std430) uniform PushConstants {
    int width;
    int height;
    int samples;
};
layout (set=0, binding=0) buffer VerificationResults {
    int verificationFlags[];
};
layout (input_attachment_index=0, set=1, binding=0) uniform subpassInputMS attachment0;
layout (input_attachment_index=1, set=1, binding=1) uniform subpassInputMS attachment1;

void main() {
    for (int sampleID = 0; sampleID < samples; ++sampleID) {
        vec4 orig = subpassLoad(attachment0, sampleID);
        vec4 copy1 = subpassLoad(attachment1, sampleID);

        ivec3 coords  = ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), sampleID);
        int bufferPos = (coords.y * width + coords.x) * samples + coords.z;

        verificationFlags[bufferPos] = ((orig == copy1) ? 1 : 0);
    }
}
#version 450

layout (push_constant, std430) uniform PushConstants {
    int width;
    int height;
    int samples;
};
layout (set=0, binding=0) buffer VerificationResults {
    int verificationFlags[];
};
layout (input_attachment_index=0, set=1, binding=0) uniform subpassInputMS attachment0;
layout (input_attachment_index=1, set=1, binding=1) uniform subpassInputMS attachment1;
layout (input_attachment_index=2, set=1, binding=2) uniform subpassInputMS attachment2;
layout (input_attachment_index=3, set=1, binding=3) uniform subpassInputMS attachment3;
layout (input_attachment_index=4, set=1, binding=4) uniform subpassInputMS attachment4;
layout (input_attachment_index=5, set=1, binding=5) uniform subpassInputMS attachment5;

void main() {
    for (int sampleID = 0; sampleID < samples; ++sampleID) {
        vec4 orig = subpassLoad(attachment0, sampleID);
        vec4 copy1 = subpassLoad(attachment1, sampleID);
        vec4 copy2 = subpassLoad(attachment2, sampleID);
        vec4 copy3 = subpassLoad(attachment3, sampleID);
        vec4 copy4 = subpassLoad(attachment4, sampleID);
        vec4 copy5 = subpassLoad(attachment5, sampleID);

        ivec3 coords  = ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), sampleID);
        int bufferPos = (coords.y * width + coords.x) * samples + coords.z;

        verificationFlags[bufferPos] = ((orig == copy1 && orig == copy2 && orig == copy3 && orig == copy4 && orig == copy5) ? 1 : 0);
    }
}
