#version 450

layout (location = 0) out vec4 fragColor;

layout (location = 1) uniform sampler2D tex2D;

void main()
{
    fragColor = textureGather(tex2D, vec2(0.0), 0);
}
