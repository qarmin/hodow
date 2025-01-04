#version 310 es
layout (location = 0) in highp vec4 a_position;
void main()
{
    gl_Position = vec4(a_position.xy, 1.0, 1.0);
}
#version 310 es
void main()
{}
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
layout (input_attachment_index=0, set=1, binding=0) uniform usubpassInputMS attachment0;
layout (input_attachment_index=1, set=1, binding=1) uniform usubpassInputMS attachment1;

void main() {
    for (int sampleID = 0; sampleID < samples; ++sampleID) {
        ivec3 coords  = ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), sampleID);
        int bufferPos = (coords.y * width + coords.x) * samples + coords.z;
        uvec4 orig = subpassLoad(attachment0, sampleID);
        outputOriginal[bufferPos] = orig.r;
        uvec4 copy1 = subpassLoad(attachment1, sampleID);

        outputCopied[bufferPos] = copy1.r; 
    }
}
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
layout (input_attachment_index=0, set=1, binding=0) uniform usubpassInputMS attachment0;
layout (input_attachment_index=1, set=1, binding=1) uniform usubpassInputMS attachment1;
layout (input_attachment_index=2, set=1, binding=2) uniform usubpassInputMS attachment2;
layout (input_attachment_index=3, set=1, binding=3) uniform usubpassInputMS attachment3;
layout (input_attachment_index=4, set=1, binding=4) uniform usubpassInputMS attachment4;
layout (input_attachment_index=5, set=1, binding=5) uniform usubpassInputMS attachment5;

void main() {
    for (int sampleID = 0; sampleID < samples; ++sampleID) {
        ivec3 coords  = ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), sampleID);
        int bufferPos = (coords.y * width + coords.x) * samples + coords.z;
        uvec4 orig = subpassLoad(attachment0, sampleID);
        outputOriginal[bufferPos] = orig.r;
        uvec4 copy1 = subpassLoad(attachment1, sampleID);
        uvec4 copy2 = subpassLoad(attachment2, sampleID);
        uvec4 copy3 = subpassLoad(attachment3, sampleID);
        uvec4 copy4 = subpassLoad(attachment4, sampleID);
        uvec4 copy5 = subpassLoad(attachment5, sampleID);

        outputCopied[bufferPos] = copy4.r; 
        bool equalEmptyLayers = copy1.r == 0 && copy2.r == 0 && copy3.r == 0 && copy5.r == 0;
        if (!equalEmptyLayers)
            outputCopied[bufferPos]--; 
    }
}
