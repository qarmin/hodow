#version 450
layout(location = 0) out highp vec2 vtxTexCoords;
highp float;
void main (void)
{
    vec4 position;    position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -1.0 : 1.0,
                    ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 1.0, 0.0, 1.0);
    gl_Position = position;
    vtxTexCoords = position.xy / 2.0 + vec2(0.5);}
#version 450
layout(location = 0) in highp vec2 vtxTexCoords;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    if (gl_FragCoord.x <= 32 && gl_FragCoord.y <= 32)
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
    else if (gl_FragCoord.x > 32 && gl_FragCoord.y <= 32)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else if (gl_FragCoord.x <= 32 && gl_FragCoord.y > 32)
        o_color = vec4(0.0, 0.0, 1.0, 1.0);
    else
        o_color = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 450
layout(binding = 0) uniform highp sampler2D previousPass;
layout(location = 0) in highp vec2 vtxTexCoords;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    vec2 step = vec2(1.0 / 64, 1.0 / 64);
    vec2 minCoord = vec2(0.0, 0.0);
    vec2 maxCoord = vec2(1.0, 1.0);
    vec4 blurColor = vec4(0.0);
    for(int sampleNdx = 0; sampleNdx < 13; sampleNdx++)
    {
        vec2 sampleCoord = vec2(vtxTexCoords.x, (vtxTexCoords.y - 6 * step.y) + step.y * sampleNdx);
        blurColor += 0.12 * texture(previousPass, clamp(sampleCoord, minCoord, maxCoord));
    }
    o_color = blurColor;
}
#version 450
layout(binding = 0) uniform sampler2D previousPass;
layout(location = 0) in highp vec2 vtxTexCoords;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    vec2 step = vec2(1.0 / 64, 1.0 / 64);
    vec2 minCoord = vec2(0.0, 0.0);
    vec2 maxCoord = vec2(1.0, 1.0);
    vec4 blurColor = vec4(0.0);
    for(int sampleNdx = 0; sampleNdx < 13; sampleNdx++)
    {
        vec2 sampleCoord = vec2((vtxTexCoords.x - 6 * step.x) + step.x * sampleNdx, vtxTexCoords.y);
        blurColor += 0.12 * texture(previousPass, clamp(sampleCoord, minCoord, maxCoord));
    }
    o_color = blurColor;
}
#version 450
layout(location = 0) in highp vec2 vtxTexCoords;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    if (gl_FragCoord.x <= 64 && gl_FragCoord.y <= 64)
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
    else if (gl_FragCoord.x > 64 && gl_FragCoord.y <= 64)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else if (gl_FragCoord.x <= 64 && gl_FragCoord.y > 64)
        o_color = vec4(0.0, 0.0, 1.0, 1.0);
    else
        o_color = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 450
layout(binding = 0) uniform highp sampler2D previousPass;
layout(location = 0) in highp vec2 vtxTexCoords;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    vec2 step = vec2(1.0 / 128, 1.0 / 128);
    vec2 minCoord = vec2(0.0, 0.0);
    vec2 maxCoord = vec2(1.0, 1.0);
    vec4 blurColor = vec4(0.0);
    for(int sampleNdx = 0; sampleNdx < 13; sampleNdx++)
    {
        vec2 sampleCoord = vec2(vtxTexCoords.x, (vtxTexCoords.y - 6 * step.y) + step.y * sampleNdx);
        blurColor += 0.12 * texture(previousPass, clamp(sampleCoord, minCoord, maxCoord));
    }
    o_color = blurColor;
}
#version 450
layout(binding = 0) uniform sampler2D previousPass;
layout(location = 0) in highp vec2 vtxTexCoords;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    vec2 step = vec2(1.0 / 128, 1.0 / 128);
    vec2 minCoord = vec2(0.0, 0.0);
    vec2 maxCoord = vec2(1.0, 1.0);
    vec4 blurColor = vec4(0.0);
    for(int sampleNdx = 0; sampleNdx < 13; sampleNdx++)
    {
        vec2 sampleCoord = vec2((vtxTexCoords.x - 6 * step.x) + step.x * sampleNdx, vtxTexCoords.y);
        blurColor += 0.12 * texture(previousPass, clamp(sampleCoord, minCoord, maxCoord));
    }
    o_color = blurColor;
}
#version 450
layout(location = 0) in highp vec2 vtxTexCoords;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    if (gl_FragCoord.x <= 256 && gl_FragCoord.y <= 256)
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
    else if (gl_FragCoord.x > 256 && gl_FragCoord.y <= 256)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else if (gl_FragCoord.x <= 256 && gl_FragCoord.y > 256)
        o_color = vec4(0.0, 0.0, 1.0, 1.0);
    else
        o_color = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 450
layout(binding = 0) uniform highp sampler2D previousPass;
layout(location = 0) in highp vec2 vtxTexCoords;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    vec2 step = vec2(1.0 / 512, 1.0 / 512);
    vec2 minCoord = vec2(0.0, 0.0);
    vec2 maxCoord = vec2(1.0, 1.0);
    vec4 blurColor = vec4(0.0);
    for(int sampleNdx = 0; sampleNdx < 13; sampleNdx++)
    {
        vec2 sampleCoord = vec2(vtxTexCoords.x, (vtxTexCoords.y - 6 * step.y) + step.y * sampleNdx);
        blurColor += 0.12 * texture(previousPass, clamp(sampleCoord, minCoord, maxCoord));
    }
    o_color = blurColor;
}
#version 450
layout(binding = 0) uniform sampler2D previousPass;
layout(location = 0) in highp vec2 vtxTexCoords;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    vec2 step = vec2(1.0 / 512, 1.0 / 512);
    vec2 minCoord = vec2(0.0, 0.0);
    vec2 maxCoord = vec2(1.0, 1.0);
    vec4 blurColor = vec4(0.0);
    for(int sampleNdx = 0; sampleNdx < 13; sampleNdx++)
    {
        vec2 sampleCoord = vec2((vtxTexCoords.x - 6 * step.x) + step.x * sampleNdx, vtxTexCoords.y);
        blurColor += 0.12 * texture(previousPass, clamp(sampleCoord, minCoord, maxCoord));
    }
    o_color = blurColor;
}
