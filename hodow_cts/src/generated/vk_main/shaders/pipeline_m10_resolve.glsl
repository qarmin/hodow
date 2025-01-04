#version 460
const vec4 vertices[] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4(-1.0,  3.0, 0.0, 1.0),
    vec4( 3.0, -1.0, 0.0, 1.0)
);
void main (void) {
    gl_Position = vertices[gl_VertexIndex % 3];
}
#version 460
layout (location=0) out uvec4 outColor;
struct PixelData {
    uvec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = 0u;
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    outColor = pixels.values[sampleIndex].colorValue;
}
#version 460
layout (location=0) out ivec4 outColor;
struct PixelData {
    ivec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = 0u;
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    outColor = pixels.values[sampleIndex].colorValue;
}
#version 460
layout (location=0) out vec4 outColor;
struct PixelData {
    vec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = 0u;
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    outColor = pixels.values[sampleIndex].colorValue;
}
#version 460
struct PixelData {
    vec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = 0u;
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    gl_FragDepth = pixels.values[sampleIndex].dsValue.x;
}
#version 460
#extension GL_ARB_shader_stencil_export : require
struct PixelData {
    vec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = 0u;
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    gl_FragStencilRefARB = int(pixels.values[sampleIndex].dsValue.y);
}
#version 460
#extension GL_ARB_shader_stencil_export : require
struct PixelData {
    vec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = 0u;
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    gl_FragDepth = pixels.values[sampleIndex].dsValue.x;
    gl_FragStencilRefARB = int(pixels.values[sampleIndex].dsValue.y);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : require
const vec4 vertices[] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4(-1.0,  3.0, 0.0, 1.0),
    vec4( 3.0, -1.0, 0.0, 1.0)
);
void main (void) {
    gl_Position = vertices[gl_VertexIndex % 3];
    gl_Layer = gl_InstanceIndex;
}
#version 460
layout (location=0) out uvec4 outColor;
struct PixelData {
    uvec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = uint(pc.width * pc.height) * uint(gl_Layer);
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    outColor = pixels.values[sampleIndex].colorValue;
}
#version 460
layout (location=0) out ivec4 outColor;
struct PixelData {
    ivec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = uint(pc.width * pc.height) * uint(gl_Layer);
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    outColor = pixels.values[sampleIndex].colorValue;
}
#version 460
layout (location=0) out vec4 outColor;
struct PixelData {
    vec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = uint(pc.width * pc.height) * uint(gl_Layer);
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    outColor = pixels.values[sampleIndex].colorValue;
}
#version 460
struct PixelData {
    vec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = uint(pc.width * pc.height) * uint(gl_Layer);
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    gl_FragDepth = pixels.values[sampleIndex].dsValue.x;
}
#version 460
#extension GL_ARB_shader_stencil_export : require
struct PixelData {
    vec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = uint(pc.width * pc.height) * uint(gl_Layer);
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    gl_FragStencilRefARB = int(pixels.values[sampleIndex].dsValue.y);
}
#version 460
#extension GL_ARB_shader_stencil_export : require
struct PixelData {
    vec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = uint(pc.width * pc.height) * uint(gl_Layer);
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    gl_FragDepth = pixels.values[sampleIndex].dsValue.x;
    gl_FragStencilRefARB = int(pixels.values[sampleIndex].dsValue.y);
}
