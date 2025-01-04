#version 460
layout (location=0) in vec4 inPos;
layout (location=0) out flat int layerIndex;
void main(void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
    layerIndex = gl_InstanceIndex;
}
#version 460
layout (location=0) out flat uint layerIndex;
void main(void) {
    const float x = float((gl_VertexIndex >> 1) & 1) * 2.0 - 1.0;
    const float y = float((gl_VertexIndex >> 0) & 1) * 2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    gl_PointSize = 1.0;
    layerIndex = uint(gl_InstanceIndex);
}
#version 460
layout (location=0) in flat int layerIndex;
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) in flat uint layerIndex;
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    vec4 values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint pixelsPerLayer = uint(pc.width * pc.height);
    const uint pixelIndex = pixelsPerLayer * layerIndex + uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x));
    const uint sampleIndex = pixelIndex * 1 + uint(gl_SampleID);
    gl_FragDepth = pixels.values[sampleIndex].x;
}
#version 460
layout (location=0) in flat uint layerIndex;
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    vec4 values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint pixelsPerLayer = uint(pc.width * pc.height);
    const uint pixelIndex = pixelsPerLayer * layerIndex + uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x));
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    gl_FragDepth = pixels.values[sampleIndex].x;
}
#version 460
layout (set=0, binding=0) uniform sampler2D tex;
layout (location=0) in flat int layerIndex;
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = texelFetch(tex, ivec2(gl_FragCoord.xy), 0);
}
#version 460
layout (location=0) in flat uint layerIndex;
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    vec4 values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint pixelsPerLayer = uint(pc.width * pc.height);
    const uint pixelIndex = pixelsPerLayer * layerIndex + uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x));
    const uint sampleIndex = pixelIndex * 1 + uint(gl_SampleID);
    outColor = pixels.values[sampleIndex];
}
#version 460
layout (set=0, binding=0) uniform sampler2DMS tex;
layout (location=0) in flat int layerIndex;
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = texelFetch(tex, ivec2(gl_FragCoord.xy), gl_SampleID);
}
#version 460
layout (location=0) in flat uint layerIndex;
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    vec4 values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint pixelsPerLayer = uint(pc.width * pc.height);
    const uint pixelIndex = pixelsPerLayer * layerIndex + uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x));
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    outColor = pixels.values[sampleIndex];
}
#version 460
layout (set=0, binding=0) uniform sampler3D tex;
layout (location=0) in flat int layerIndex;
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = texelFetch(tex, ivec3(gl_FragCoord.xy, layerIndex), 0);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) in vec4 inPos;
layout (location=0) out flat int layerIndex;
void main(void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
    layerIndex = gl_InstanceIndex;
    gl_Layer = gl_InstanceIndex;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out flat uint layerIndex;
void main(void) {
    const float x = float((gl_VertexIndex >> 1) & 1) * 2.0 - 1.0;
    const float y = float((gl_VertexIndex >> 0) & 1) * 2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    gl_PointSize = 1.0;
    layerIndex = uint(gl_InstanceIndex);
    gl_Layer = gl_InstanceIndex;
}
#version 460
layout (set=0, binding=0) uniform sampler2DArray tex;
layout (location=0) in flat int layerIndex;
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = texelFetch(tex, ivec3(gl_FragCoord.xy, layerIndex), 0);
}
#version 460
layout (set=0, binding=0) uniform sampler2DMSArray tex;
layout (location=0) in flat int layerIndex;
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = texelFetch(tex, ivec3(gl_FragCoord.xy, layerIndex), gl_SampleID);
}
