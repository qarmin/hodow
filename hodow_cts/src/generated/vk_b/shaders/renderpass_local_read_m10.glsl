#version 460
vec2 positions[3] = vec2[](
        vec2(-1.0, -1.0),        vec2(3.0, -1.0),        vec2(-1.0, 3.0));
void main() {
        gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}#version 460
layout (location=0) out vec4 outColor0;
layout (set=0, binding=0, std430) readonly buffer ColorBlock0 {
    vec4 values[];
} inputBuffer0;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 pixelCoord = ivec2(gl_FragCoord.xy);
    int pixelIndex = pixelCoord.y * pc.imageSize.x + pixelCoord.x;
    int bufferIndex = pixelIndex * pc.imageSize.w + 0;
    outColor0 = inputBuffer0.values[bufferIndex];
}
#version 460
layout (location=1) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInput srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
#version 460
layout (location=1) out vec4 outColor0;
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    vec4 imageSizeFloat = vec4(pc.imageSize);
    // All samples in a pixel will share color so as not to depend on standard sample locations
    vec2 normalizedCoords = vec2(ivec2(gl_FragCoord.xy)) / imageSizeFloat.xy;
    float gradientValue = (normalizedCoords.x + normalizedCoords.y) / 2.0;
    vec4 gradient0 = vec4(0.0, 0.0, 0.0, 1.0);
    gradient0[0] = gradientValue;
    outColor0 = gradient0;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInput srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    vec4 imageSizeFloat = vec4(pc.imageSize);
    // All samples in a pixel will share color so as not to depend on standard sample locations
    vec2 normalizedCoords = vec2(ivec2(gl_FragCoord.xy)) / imageSizeFloat.xy;
    float gradientValue = (normalizedCoords.x + normalizedCoords.y) / 2.0;
    vec4 gradient0 = vec4(0.0, 0.0, 0.0, 1.0);
    gradient0[0] = gradientValue;
    outColor0 = gradient0;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0, std430) readonly buffer ColorBlock0 {
    vec4 values[];
} inputBuffer0;
layout (set=0, binding=1, std430) readonly buffer ColorBlock1 {
    vec4 values[];
} inputBuffer1;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 pixelCoord = ivec2(gl_FragCoord.xy);
    int pixelIndex = pixelCoord.y * pc.imageSize.x + pixelCoord.x;
    int bufferIndex = pixelIndex * pc.imageSize.w + 0;
    outColor0 = inputBuffer0.values[bufferIndex];
    outColor1 = inputBuffer1.values[bufferIndex];
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInput srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInput srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    vec4 imageSizeFloat = vec4(pc.imageSize);
    // All samples in a pixel will share color so as not to depend on standard sample locations
    vec2 normalizedCoords = vec2(ivec2(gl_FragCoord.xy)) / imageSizeFloat.xy;
    float gradientValue = (normalizedCoords.x + normalizedCoords.y) / 2.0;
    vec4 gradient0 = vec4(0.0, 0.0, 0.0, 1.0);
    gradient0[0] = gradientValue;
    outColor0 = gradient0;
    vec4 gradient1 = vec4(0.0, 0.0, 0.0, 1.0);
    gradient1[1] = gradientValue;
    outColor1 = gradient1;
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInput srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInput srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    vec4 imageSizeFloat = vec4(pc.imageSize);
    // All samples in a pixel will share color so as not to depend on standard sample locations
    vec2 normalizedCoords = vec2(ivec2(gl_FragCoord.xy)) / imageSizeFloat.xy;
    float gradientValue = (normalizedCoords.x + normalizedCoords.y) / 2.0;
    vec4 gradient0 = vec4(0.0, 0.0, 0.0, 1.0);
    gradient0[0] = gradientValue;
    outColor0 = gradient0;
    vec4 gradient1 = vec4(0.0, 0.0, 0.0, 1.0);
    gradient1[1] = gradientValue;
    outColor1 = gradient1;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInput srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInput srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    vec4 imageSizeFloat = vec4(pc.imageSize);
    // All samples in a pixel will share color so as not to depend on standard sample locations
    vec2 normalizedCoords = vec2(ivec2(gl_FragCoord.xy)) / imageSizeFloat.xy;
    float gradientValue = (normalizedCoords.x + normalizedCoords.y) / 2.0;
    vec4 gradient0 = vec4(0.0, 0.0, 0.0, 1.0);
    gradient0[0] = gradientValue;
    outColor0 = gradient0;
    vec4 gradient1 = vec4(0.0, 0.0, 0.0, 1.0);
    gradient1[1] = gradientValue;
    outColor1 = gradient1;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInput srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInput srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    vec4 imageSizeFloat = vec4(pc.imageSize);
    // All samples in a pixel will share color so as not to depend on standard sample locations
    vec2 normalizedCoords = vec2(ivec2(gl_FragCoord.xy)) / imageSizeFloat.xy;
    float gradientValue = (normalizedCoords.x + normalizedCoords.y) / 2.0;
    vec4 gradient0 = vec4(0.0, 0.0, 0.0, 1.0);
    gradient0[0] = gradientValue;
    outColor0 = gradient0;
    vec4 gradient1 = vec4(0.0, 0.0, 0.0, 1.0);
    gradient1[1] = gradientValue;
    outColor1 = gradient1;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (set=0, binding=0, std430) readonly buffer ColorBlock0 {
    vec4 values[];
} inputBuffer0;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 pixelCoord = ivec2(gl_FragCoord.xy);
    int pixelIndex = pixelCoord.y * pc.imageSize.x + pixelCoord.x;
    int bufferIndex = pixelIndex * pc.imageSize.w + gl_SampleID;
    outColor0 = inputBuffer0.values[bufferIndex];
}
#version 460
layout (location=1) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, gl_SampleID) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (set=0, binding=0) uniform sampler2DMS srcColor0;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 expandedPixelCoord = ivec2(gl_FragCoord.xy);
    int sampleID = expandedPixelCoord.x % pc.imageSize.w;
    int xCoordMS = expandedPixelCoord.x / pc.imageSize.w;
    int yCoordMS = expandedPixelCoord.y;
    outColor0 = texelFetch(srcColor0, ivec2(xCoordMS, yCoordMS), sampleID);
}
#version 460
layout (location=1) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 0) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
#version 460
layout (location=1) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 1) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
#version 460
layout (location=1) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 2) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
#version 460
layout (location=1) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 3) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, gl_SampleID) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 0) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 1) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 2) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 3) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0, std430) readonly buffer ColorBlock0 {
    vec4 values[];
} inputBuffer0;
layout (set=0, binding=1, std430) readonly buffer ColorBlock1 {
    vec4 values[];
} inputBuffer1;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 pixelCoord = ivec2(gl_FragCoord.xy);
    int pixelIndex = pixelCoord.y * pc.imageSize.x + pixelCoord.x;
    int bufferIndex = pixelIndex * pc.imageSize.w + gl_SampleID;
    outColor0 = inputBuffer0.values[bufferIndex];
    outColor1 = inputBuffer1.values[bufferIndex];
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, gl_SampleID) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, gl_SampleID) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) uniform sampler2DMS srcColor0;
layout (set=0, binding=1) uniform sampler2DMS srcColor1;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 expandedPixelCoord = ivec2(gl_FragCoord.xy);
    int sampleID = expandedPixelCoord.x % pc.imageSize.w;
    int xCoordMS = expandedPixelCoord.x / pc.imageSize.w;
    int yCoordMS = expandedPixelCoord.y;
    outColor0 = texelFetch(srcColor0, ivec2(xCoordMS, yCoordMS), sampleID);
    outColor1 = texelFetch(srcColor1, ivec2(xCoordMS, yCoordMS), sampleID);
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 0) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 0) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 1) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 1) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 2) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 2) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 3) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 3) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, gl_SampleID) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, gl_SampleID) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 0) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 0) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 1) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 1) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 2) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 2) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=2) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 3) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 3) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, gl_SampleID) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, gl_SampleID) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 0) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 0) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 1) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 1) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 2) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 2) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=3) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 3) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 3) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, gl_SampleID) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, gl_SampleID) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 0) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 0) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 1) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 1) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 2) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 2) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 3) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, 3) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
#version 460
layout (set=0, binding=0, std430) readonly buffer ColorBlock0 {
    vec4 values[];
} inputBuffer0;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 pixelCoord = ivec2(gl_FragCoord.xy);
    int pixelIndex = pixelCoord.y * pc.imageSize.x + pixelCoord.x;
    int bufferIndex = pixelIndex * pc.imageSize.w + 0;
    gl_FragDepth = inputBuffer0.values[bufferIndex].x;
}
#version 460
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInput srcDepth;
void main(void) {
    vec4 depth = subpassLoad(srcDepth) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
}
#version 460
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    vec4 imageSizeFloat = vec4(pc.imageSize);
    // All samples in a pixel will share color so as not to depend on standard sample locations
    vec2 normalizedCoords = vec2(ivec2(gl_FragCoord.xy)) / imageSizeFloat.xy;
    float gradientValue = (normalizedCoords.x + normalizedCoords.y) / 2.0;
    gl_FragDepth = gradientValue;
}
#version 460
layout (set=0, binding=0, std430) readonly buffer ColorBlock0 {
    vec4 values[];
} inputBuffer0;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 pixelCoord = ivec2(gl_FragCoord.xy);
    int pixelIndex = pixelCoord.y * pc.imageSize.x + pixelCoord.x;
    int bufferIndex = pixelIndex * pc.imageSize.w + gl_SampleID;
    gl_FragDepth = inputBuffer0.values[bufferIndex].x;
}
#version 460
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcDepth;
void main(void) {
    vec4 depth = subpassLoad(srcDepth, gl_SampleID) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
}
#version 460
layout (set=0, binding=0) uniform sampler2DMS srcDepth;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 expandedPixelCoord = ivec2(gl_FragCoord.xy);
    int sampleID = expandedPixelCoord.x % pc.imageSize.w;
    int xCoordMS = expandedPixelCoord.x / pc.imageSize.w;
    int yCoordMS = expandedPixelCoord.y;
    gl_FragDepth = texelFetch(srcDepth, ivec2(xCoordMS, yCoordMS), sampleID).x;
}
#version 460
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcDepth;
void main(void) {
    vec4 depth = subpassLoad(srcDepth, 0) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
}
#version 460
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcDepth;
void main(void) {
    vec4 depth = subpassLoad(srcDepth, 1) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
}
#version 460
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcDepth;
void main(void) {
    vec4 depth = subpassLoad(srcDepth, 2) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
}
#version 460
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcDepth;
void main(void) {
    vec4 depth = subpassLoad(srcDepth, 3) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0, std430) readonly buffer ColorBlock0 {
    vec4 values[];
} inputBuffer0;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 pixelCoord = ivec2(gl_FragCoord.xy);
    int pixelIndex = pixelCoord.y * pc.imageSize.x + pixelCoord.x;
    int bufferIndex = pixelIndex * pc.imageSize.w + 0;
    gl_FragStencilRefARB = int(inputBuffer0.values[bufferIndex].y);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform usubpassInput srcStencil;
void main(void) {
    vec4 stencil = vec4(subpassLoad(srcStencil)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    vec4 imageSizeFloat = vec4(pc.imageSize);
    // All samples in a pixel will share color so as not to depend on standard sample locations
    vec2 normalizedCoords = vec2(ivec2(gl_FragCoord.xy)) / imageSizeFloat.xy;
    float gradientValue = (normalizedCoords.x + normalizedCoords.y) / 2.0;
    gl_FragStencilRefARB = int(gradientValue * 255.0);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0, std430) readonly buffer ColorBlock0 {
    vec4 values[];
} inputBuffer0;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 pixelCoord = ivec2(gl_FragCoord.xy);
    int pixelIndex = pixelCoord.y * pc.imageSize.x + pixelCoord.x;
    int bufferIndex = pixelIndex * pc.imageSize.w + gl_SampleID;
    gl_FragStencilRefARB = int(inputBuffer0.values[bufferIndex].y);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform usubpassInputMS srcStencil;
void main(void) {
    vec4 stencil = vec4(subpassLoad(srcStencil, gl_SampleID)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) uniform usampler2DMS srcStencil;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 expandedPixelCoord = ivec2(gl_FragCoord.xy);
    int sampleID = expandedPixelCoord.x % pc.imageSize.w;
    int xCoordMS = expandedPixelCoord.x / pc.imageSize.w;
    int yCoordMS = expandedPixelCoord.y;
    gl_FragStencilRefARB = int(texelFetch(srcStencil, ivec2(xCoordMS, yCoordMS), sampleID).x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform usubpassInputMS srcStencil;
void main(void) {
    vec4 stencil = vec4(subpassLoad(srcStencil, 0)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform usubpassInputMS srcStencil;
void main(void) {
    vec4 stencil = vec4(subpassLoad(srcStencil, 1)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform usubpassInputMS srcStencil;
void main(void) {
    vec4 stencil = vec4(subpassLoad(srcStencil, 2)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform usubpassInputMS srcStencil;
void main(void) {
    vec4 stencil = vec4(subpassLoad(srcStencil, 3)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0, std430) readonly buffer ColorBlock0 {
    vec4 values[];
} inputBuffer0;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 pixelCoord = ivec2(gl_FragCoord.xy);
    int pixelIndex = pixelCoord.y * pc.imageSize.x + pixelCoord.x;
    int bufferIndex = pixelIndex * pc.imageSize.w + 0;
    gl_FragDepth = inputBuffer0.values[bufferIndex].x;
    gl_FragStencilRefARB = int(inputBuffer0.values[bufferIndex].y);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInput srcDepth;
layout (set=0, binding=2, input_attachment_index=1) uniform usubpassInput srcStencil;
void main(void) {
    vec4 depth = subpassLoad(srcDepth) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
    vec4 stencil = vec4(subpassLoad(srcStencil)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    vec4 imageSizeFloat = vec4(pc.imageSize);
    // All samples in a pixel will share color so as not to depend on standard sample locations
    vec2 normalizedCoords = vec2(ivec2(gl_FragCoord.xy)) / imageSizeFloat.xy;
    float gradientValue = (normalizedCoords.x + normalizedCoords.y) / 2.0;
    gl_FragDepth = gradientValue;
    gl_FragStencilRefARB = int(gradientValue * 255.0);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0, std430) readonly buffer ColorBlock0 {
    vec4 values[];
} inputBuffer0;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 pixelCoord = ivec2(gl_FragCoord.xy);
    int pixelIndex = pixelCoord.y * pc.imageSize.x + pixelCoord.x;
    int bufferIndex = pixelIndex * pc.imageSize.w + gl_SampleID;
    gl_FragDepth = inputBuffer0.values[bufferIndex].x;
    gl_FragStencilRefARB = int(inputBuffer0.values[bufferIndex].y);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcDepth;
layout (set=0, binding=2, input_attachment_index=1) uniform usubpassInputMS srcStencil;
void main(void) {
    vec4 depth = subpassLoad(srcDepth, gl_SampleID) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
    vec4 stencil = vec4(subpassLoad(srcStencil, gl_SampleID)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) uniform sampler2DMS srcDepth;
layout (set=0, binding=1) uniform usampler2DMS srcStencil;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 expandedPixelCoord = ivec2(gl_FragCoord.xy);
    int sampleID = expandedPixelCoord.x % pc.imageSize.w;
    int xCoordMS = expandedPixelCoord.x / pc.imageSize.w;
    int yCoordMS = expandedPixelCoord.y;
    gl_FragDepth = texelFetch(srcDepth, ivec2(xCoordMS, yCoordMS), sampleID).x;
    gl_FragStencilRefARB = int(texelFetch(srcStencil, ivec2(xCoordMS, yCoordMS), sampleID).x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcDepth;
layout (set=0, binding=2, input_attachment_index=1) uniform usubpassInputMS srcStencil;
void main(void) {
    vec4 depth = subpassLoad(srcDepth, 0) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
    vec4 stencil = vec4(subpassLoad(srcStencil, 0)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcDepth;
layout (set=0, binding=2, input_attachment_index=1) uniform usubpassInputMS srcStencil;
void main(void) {
    vec4 depth = subpassLoad(srcDepth, 1) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
    vec4 stencil = vec4(subpassLoad(srcStencil, 1)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcDepth;
layout (set=0, binding=2, input_attachment_index=1) uniform usubpassInputMS srcStencil;
void main(void) {
    vec4 depth = subpassLoad(srcDepth, 2) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
    vec4 stencil = vec4(subpassLoad(srcStencil, 2)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcDepth;
layout (set=0, binding=2, input_attachment_index=1) uniform usubpassInputMS srcStencil;
void main(void) {
    vec4 depth = subpassLoad(srcDepth, 3) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
    vec4 stencil = vec4(subpassLoad(srcStencil, 3)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
