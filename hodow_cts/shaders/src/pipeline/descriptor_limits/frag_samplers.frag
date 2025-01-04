#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = ${binding}) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
