#version 450

layout (location = 0) out vec4 fragColor;

layout (location = 1) uniform sampler2D tex2D;

void main()
{
    fragColor = textureProj(tex2D, vec3(0.0));
}
