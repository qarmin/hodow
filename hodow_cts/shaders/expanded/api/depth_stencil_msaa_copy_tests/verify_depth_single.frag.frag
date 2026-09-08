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

void main() {
    for (int sampleID = 0; sampleID < samples; ++sampleID) {
        ivec3 coords  = ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), sampleID);
        int bufferPos = (coords.y * width + coords.x) * samples + coords.z;
        vec4 orig = subpassLoad(attachment0, sampleID);
        outputOriginal[bufferPos] = orig.r;
        vec4 copy1 = subpassLoad(attachment1, sampleID);

        outputCopied[bufferPos] = copy1.r; 
    }
}
