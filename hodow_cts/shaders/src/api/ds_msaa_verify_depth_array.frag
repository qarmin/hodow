#version 450

layout (push_constant, std430) uniform PushConstants {
    int width;
    int height;
    int samples;
};
layout (set=0, binding=0) buffer OriginalValues {
    float outputOriginal[];
};
layout (set=0, binding=1) buffer CopiedValues {
    float outputCopied[];
};
layout (input_attachment_index=0, set=1, binding=0) uniform subpassInputMS attachment0;
layout (input_attachment_index=1, set=1, binding=1) uniform subpassInputMS attachment1;
layout (input_attachment_index=2, set=1, binding=2) uniform subpassInputMS attachment2;
layout (input_attachment_index=3, set=1, binding=3) uniform subpassInputMS attachment3;
layout (input_attachment_index=4, set=1, binding=4) uniform subpassInputMS attachment4;
layout (input_attachment_index=5, set=1, binding=5) uniform subpassInputMS attachment5;

void main() {
    for (int sampleID = 0; sampleID < samples; ++sampleID) {
        ivec3 coords  = ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), sampleID);
        int bufferPos = (coords.y * width + coords.x) * samples + coords.z;
        vec4 orig = subpassLoad(attachment0, sampleID);
        outputOriginal[bufferPos] = orig.r;
        vec4 copy1 = subpassLoad(attachment1, sampleID);
        vec4 copy2 = subpassLoad(attachment2, sampleID);
        vec4 copy3 = subpassLoad(attachment3, sampleID);
        vec4 copy4 = subpassLoad(attachment4, sampleID);
        vec4 copy5 = subpassLoad(attachment5, sampleID);

        outputCopied[bufferPos] = copy4.r; 
        bool equalEmptyLayers = copy1.r == 0.0 && copy2.r == 0.0 && copy3.r == 0.0 && copy5.r == 0.0;
        if (!equalEmptyLayers)
            outputCopied[bufferPos]--; 
    }
}
