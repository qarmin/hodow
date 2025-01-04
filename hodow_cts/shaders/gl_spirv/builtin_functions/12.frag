#version 450

layout (location = 0) out vec4 fragColor;

layout (location = 1) uniform sampler2D tex2D;
layout (location = 2) uniform sampler2DMS tex2DMS;

void main()
{
    ivec2 iv2size = textureSize(tex2D, 0);
    vec2 v2lod = textureQueryLod(tex2D, vec2(0.0));
    int ilev = textureQueryLevels(tex2D);
    int isamp = textureSamples(tex2DMS);
    vec4 v4pix = textureLod(tex2D, vec2(0.0), 0.0) +
                 textureOffset(tex2D, vec2(0.0), ivec2(2)) +
                 texelFetch(tex2D, ivec2(2), 0) +
                 texelFetchOffset(tex2D, ivec2(2), 0, ivec2(2)) +
                 textureProjOffset(tex2D, vec3(0.0), ivec2(2)) +
                 textureLodOffset(tex2D, vec2(0.0), 0.0, ivec2(2)) +
                 textureProjLod(tex2D, vec3(0.0), 0.0) +
                 textureProjLodOffset(tex2D, vec3(0.0), 0.0, ivec2(2)) +
                 textureGrad(tex2D, vec2(0.0), vec2(0.2), vec2(0.5)) +
                 textureGradOffset(tex2D, vec2(0.0), vec2(0.2), vec2(0.5), ivec2(2)) +
                 textureProjGrad(tex2D, vec3(0.0), vec2(0.2), vec2(0.5)) +
                 textureProjGradOffset(tex2D, vec3(0.0), vec2(0.2), vec2(0.5), ivec2(2)) +
                 textureGatherOffset(tex2D, vec2(0.0), ivec2(2), 0);
    fragColor = vec4(0.0);
}
