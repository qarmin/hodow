#version 440
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 texCoords;
layout(location = 0) out highp vec4 vtxTexCoords;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = position;
    vtxTexCoords = texCoords;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1D texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler1D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.x) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1D texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler1D texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.x) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1D texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler1D texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.x) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture1D texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(sampler1D(texImage, texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture1D texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(sampler1D(texImage, texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture1D texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(sampler1D(texImages[i], texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture1D texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(sampler1D(texImages[i], texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture1D texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(sampler1D(texImages[i], texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture1D texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(sampler1D(texImages[i], texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1DArray texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler1DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xy) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1DArray texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler1DArray texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1DArray texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler1DArray texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture1DArray texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(sampler1DArray(texImage, texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture1DArray texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(sampler1DArray(texImage, texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture1DArray texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(sampler1DArray(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture1DArray texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(sampler1DArray(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture1DArray texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(sampler1DArray(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture1DArray texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(sampler1DArray(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler2D texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xy) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler2D texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler2D texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler2D texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler2D texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture2D texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(sampler2D(texImage, texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture2D texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(sampler2D(texImage, texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture2D texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(sampler2D(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture2D texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(sampler2D(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture2D texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(sampler2D(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture2D texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(sampler2D(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler2DArray texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler2DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler2DArray texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler2DArray texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler2DArray texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler2DArray texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture2DArray texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(sampler2DArray(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture2DArray texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(sampler2DArray(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture2DArray texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(sampler2DArray(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture2DArray texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(sampler2DArray(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture2DArray texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(sampler2DArray(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture2DArray texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(sampler2DArray(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler3D texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler3D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler3D texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler3D texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler3D texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler3D texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture3D texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(sampler3D(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture3D texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(sampler3D(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture3D texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(sampler3D(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture3D texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(sampler3D(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture3D texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(sampler3D(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp texture3D texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(sampler3D(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp samplerCube texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp samplerCube texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp samplerCube texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp samplerCube texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp samplerCube texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp samplerCube texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp textureCube texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(samplerCube(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp textureCube texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(samplerCube(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp textureCube texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(samplerCube(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp textureCube texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(samplerCube(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp textureCube texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(samplerCube(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp textureCube texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(samplerCube(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp samplerCubeArray texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp samplerCubeArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xyzw) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp samplerCubeArray texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp samplerCubeArray texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyzw) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp samplerCubeArray texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp samplerCubeArray texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyzw) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp textureCubeArray texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(samplerCubeArray(texImage, texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp textureCubeArray texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(samplerCubeArray(texImage, texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp textureCubeArray texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(samplerCubeArray(texImages[i], texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp textureCubeArray texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(samplerCubeArray(texImages[i], texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp textureCubeArray texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(samplerCubeArray(texImages[i], texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp textureCubeArray texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(samplerCubeArray(texImages[i], texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler1D texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler1D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.x) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler1D texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler1D texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.x) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler1D texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler1D texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.x) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture1D texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(isampler1D(texImage, texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture1D texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(isampler1D(texImage, texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture1D texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(isampler1D(texImages[i], texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture1D texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(isampler1D(texImages[i], texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture1D texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(isampler1D(texImages[i], texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture1D texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(isampler1D(texImages[i], texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler1DArray texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler1DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xy) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler1DArray texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler1DArray texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler1DArray texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler1DArray texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture1DArray texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(isampler1DArray(texImage, texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture1DArray texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(isampler1DArray(texImage, texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture1DArray texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(isampler1DArray(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture1DArray texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(isampler1DArray(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture1DArray texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(isampler1DArray(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture1DArray texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(isampler1DArray(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler2D texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xy) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler2D texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler2D texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler2D texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler2D texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture2D texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(isampler2D(texImage, texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture2D texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(isampler2D(texImage, texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture2D texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(isampler2D(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture2D texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(isampler2D(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture2D texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(isampler2D(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture2D texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(isampler2D(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler2DArray texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler2DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler2DArray texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler2DArray texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler2DArray texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler2DArray texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture2DArray texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(isampler2DArray(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture2DArray texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(isampler2DArray(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture2DArray texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(isampler2DArray(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture2DArray texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(isampler2DArray(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture2DArray texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(isampler2DArray(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture2DArray texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(isampler2DArray(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler3D texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler3D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler3D texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler3D texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isampler3D texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler3D texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture3D texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(isampler3D(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture3D texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(isampler3D(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture3D texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(isampler3D(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture3D texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(isampler3D(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture3D texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(isampler3D(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itexture3D texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(isampler3D(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isamplerCube texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isamplerCube texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp isamplerCube texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isamplerCube texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isamplerCube texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isamplerCube texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itextureCube texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(isamplerCube(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itextureCube texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(isamplerCube(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itextureCube texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(isamplerCube(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itextureCube texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(isamplerCube(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itextureCube texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(isamplerCube(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itextureCube texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(isamplerCube(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isamplerCubeArray texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isamplerCubeArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xyzw) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp isamplerCubeArray texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isamplerCubeArray texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyzw) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp isamplerCubeArray texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isamplerCubeArray texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyzw) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itextureCubeArray texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(isamplerCubeArray(texImage, texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itextureCubeArray texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(isamplerCubeArray(texImage, texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itextureCubeArray texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(isamplerCubeArray(texImages[i], texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itextureCubeArray texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(isamplerCubeArray(texImages[i], texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itextureCubeArray texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(isamplerCubeArray(texImages[i], texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp itextureCubeArray texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(isamplerCubeArray(texImages[i], texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler1D texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler1D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.x) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler1D texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler1D texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.x) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler1D texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler1D texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.x) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture1D texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(usampler1D(texImage, texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture1D texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(usampler1D(texImage, texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture1D texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(usampler1D(texImages[i], texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture1D texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(usampler1D(texImages[i], texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture1D texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(usampler1D(texImages[i], texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture1D texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(usampler1D(texImages[i], texSampler), vtxTexCoords.x) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler1DArray texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler1DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xy) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler1DArray texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler1DArray texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler1DArray texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler1DArray texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture1DArray texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(usampler1DArray(texImage, texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture1DArray texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(usampler1DArray(texImage, texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture1DArray texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(usampler1DArray(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture1DArray texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(usampler1DArray(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture1DArray texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(usampler1DArray(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture1DArray texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(usampler1DArray(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler2D texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xy) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler2D texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler2D texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler2D texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler2D texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture2D texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(usampler2D(texImage, texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture2D texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(usampler2D(texImage, texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture2D texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(usampler2D(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture2D texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(usampler2D(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture2D texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(usampler2D(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture2D texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(usampler2D(texImages[i], texSampler), vtxTexCoords.xy) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler2DArray texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler2DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler2DArray texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler2DArray texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler2DArray texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler2DArray texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture2DArray texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(usampler2DArray(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture2DArray texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(usampler2DArray(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture2DArray texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(usampler2DArray(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture2DArray texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(usampler2DArray(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture2DArray texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(usampler2DArray(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture2DArray texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(usampler2DArray(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler3D texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler3D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler3D texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler3D texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usampler3D texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler3D texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture3D texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(usampler3D(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture3D texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(usampler3D(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture3D texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(usampler3D(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture3D texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(usampler3D(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture3D texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(usampler3D(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utexture3D texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(usampler3D(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usamplerCube texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usamplerCube texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp usamplerCube texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usamplerCube texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usamplerCube texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usamplerCube texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utextureCube texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(usamplerCube(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utextureCube texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(usamplerCube(texImage, texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utextureCube texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(usamplerCube(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utextureCube texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(usamplerCube(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utextureCube texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(usamplerCube(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utextureCube texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(usamplerCube(texImages[i], texSampler), vtxTexCoords.xyz) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usamplerCubeArray texSampler;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(texSampler, vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usamplerCubeArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(texSampler, vtxTexCoords.xyzw) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp usamplerCubeArray texSamplers[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usamplerCubeArray texSamplers[4];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyzw) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp usamplerCubeArray texSamplers[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(texSamplers[i], vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usamplerCubeArray texSamplers[8];
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 2) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(texSamplers[i], vtxTexCoords.xyzw) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utextureCubeArray texImage;
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = (texture(usamplerCubeArray(texImage, texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utextureCubeArray texImage;
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[1];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    vec4 color = (texture(usamplerCubeArray(texImage, texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
    imageStore(outImages[0], ivec2(gl_GlobalInvocationID.xy), color);
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utextureCubeArray texImages[4];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[4];
void main (void)
{
    for (uint i = 0; i < 4; ++i)
        fragColors[i] = (texture(usamplerCubeArray(texImages[i], texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utextureCubeArray texImages[4];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[4];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 4; ++i) {
        vec4 color = (texture(usamplerCubeArray(texImages[i], texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utextureCubeArray texImages[8];
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
layout(location = 0) in highp vec4 vtxTexCoords;
layout(location = 0) out highp vec4 fragColors[8];
void main (void)
{
    for (uint i = 0; i < 8; ++i)
        fragColors[i] = (texture(usamplerCubeArray(texImages[i], texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler texSampler;
layout(set = 0, binding = 1) uniform highp utextureCubeArray texImages[8];
layout(set = 0, binding = 2, rgba8) uniform writeonly highp image2D outImages[8];
struct Vertex {
    vec4 position;
    vec4 texCoord;
};
layout(std430, set = 0, binding = 3) readonly buffer Vertices {
    Vertex v[];
};
layout(push_constant, std430) uniform PushConstants
{
    vec4 scale;
    vec4 bias;
    float lod;
} pc;
vec4 interpolateTexCoord(vec2 ndc) {
    for (int i = 0; i < v.length(); i += 3) {
        vec2 p0 = v[i].position.xy;
        vec2 p1 = v[i+1].position.xy;
        vec2 p2 = v[i+2].position.xy;
        float area = (p1.x - p0.x) * (p2.y - p0.y) - (p1.y - p0.y) * (p2.x - p0.x);
        if (abs(area) < 1e-5) continue;
        float l0 = ((p2.x - p1.x) * (ndc.y - p1.y) - (p2.y - p1.y) * (ndc.x - p1.x)) / area;
        float l1 = ((p0.x - p2.x) * (ndc.y - p2.y) - (p0.y - p2.y) * (ndc.x - p2.x)) / area;
        float l2 = 1.0 - l0 - l1;
        if (l0 >= -1e-5 && l1 >= -1e-5 && l2 >= -1e-5) {
            return v[i].texCoord * l0 + v[i+1].texCoord * l1 + v[i+2].texCoord * l2;
        }
    }
    return v[0].texCoord;
}
void main (void)
{
    vec2 pixelCenter = vec2(gl_GlobalInvocationID.xy) + vec2(0.5);
    vec2 ndc = (pixelCenter / vec2(gl_NumWorkGroups.xy)) * 2.0 - 1.0;
    vec4 vtxTexCoords = interpolateTexCoord(ndc);
    for (uint i = 0; i < 8; ++i) {
        vec4 color = (texture(usamplerCubeArray(texImages[i], texSampler), vtxTexCoords.xyzw) * pc.scale) + pc.bias;
        imageStore(outImages[i], ivec2(gl_GlobalInvocationID.xy), color);
    }
}
