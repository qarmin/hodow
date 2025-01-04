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
    fragColor = texture(texSampler, vtxTexCoords.x) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler1D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.x);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.x, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler1D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.x, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xy) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler1DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xy);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xy, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler1DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xy, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xy) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xy);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xy, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xy, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xyz) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler2DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xyz);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xyz, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler2DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xyz, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xyz) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler3D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xyz);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xyz, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp sampler3D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xyz, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xyz) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp samplerCube texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xyz);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xyz, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp samplerCube texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xyz, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xyzw) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp samplerCubeArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xyzw);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xyzw, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp samplerCubeArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xyzw, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.x) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler1D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.x);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.x, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler1D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.x, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xy) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler1DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xy);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xy, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler1DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xy, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xy) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xy);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xy, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xy, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xyz) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler2DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xyz);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xyz, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler2DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xyz, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xyz) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler3D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xyz);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xyz, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isampler3D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xyz, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xyz) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isamplerCube texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xyz);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xyz, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isamplerCube texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xyz, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xyzw) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isamplerCubeArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xyzw);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xyzw, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp isamplerCubeArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xyzw, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.x) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler1D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.x);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.x, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler1D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.x, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xy) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler1DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xy);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xy, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler1DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xy, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xy) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xy);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xy, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xy, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xyz) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler2DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xyz);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xyz, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler2DArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xyz, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xyz) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler3D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xyz);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xyz, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usampler3D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xyz, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xyz) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usamplerCube texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xyz);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xyz, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usamplerCube texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xyz, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = texture(texSampler, vtxTexCoords.xyzw) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usamplerCubeArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = texture(texSampler, vtxTexCoords.xyzw);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
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
    fragColor = textureLod(texSampler, vtxTexCoords.xyzw, pc.lod) * pc.scale + pc.bias;
}
#version 440
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform highp usamplerCubeArray texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly highp image2D outImage;
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
    vec4 color;
    color = textureLod(texSampler, vtxTexCoords.xyzw, pc.lod);
    color = color * pc.scale + pc.bias;
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
}
