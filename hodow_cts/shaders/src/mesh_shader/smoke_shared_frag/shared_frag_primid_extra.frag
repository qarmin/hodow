#version 450

layout (location=0) in float multiplier;
layout (location=0) out vec4 outColor;

vec4 outColors[3] = vec4[](
    vec4(0, 0, 0, 1),
    vec4(1, 0, 1, 1),
    vec4(1, 1, 0, 1)
);

void main ()
{
    const vec4 baseColor = vec4(outColors[2].xy, gl_PrimitiveID, 1.0);
    outColor = baseColor * multiplier;
}
