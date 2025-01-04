#version 450

layout (location = 0) out vec4 fragColor;
layout (location = 1) in vec2 texCoord;

void main()
{
    vec2 p = vec2(0.0);
    vec2 dx = dFdx(p);
    vec2 dy = dFdy(p);
    dx = dFdxFine(p);
    dy = dFdyFine(p);
    dx = dFdxCoarse(p);
    dy = dFdyCoarse(p);
    vec2 fw = fwidth(p);
    fw = fwidthFine(p);
    fw = fwidthCoarse(p);
    vec2 interp = interpolateAtCentroid(texCoord) +
                  interpolateAtSample(texCoord, 0) +
                  interpolateAtOffset(texCoord, vec2(0.0));
    fragColor = vec4(1.0);
}
