#version 450

layout (location = 3) in vec2 texCoord;

layout (location = 0) out vec4 fColor;

layout (location = 1) uniform sampler2D tex;

void main()
{
    vec2 p = vec2(gl_SampleID);
    vec2 dx = dFdxFine(p);

    interpolateAtCentroid(texCoord);
    fColor = vec4(1.0);
}
