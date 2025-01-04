#version 450
layout(binding = 0) uniform sampler2D previousPass;
layout(location = 0) in highp vec2 vtxTexCoords;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    vec2 step = vec2(1.0 / ${w}, 1.0 / ${h});
    vec2 minCoord = vec2(0.0, 0.0);
    vec2 maxCoord = vec2(1.0, 1.0);
    vec4 blurColor = vec4(0.0);
    for(int sampleNdx = 0; sampleNdx < ${taps}; sampleNdx++)
    {
        vec2 sampleCoord = vec2((vtxTexCoords.x - ${half_k} * step.x) + step.x * sampleNdx, vtxTexCoords.y);
        blurColor += 0.12 * texture(previousPass, clamp(sampleCoord, minCoord, maxCoord));
    }
    o_color = blurColor;
}
