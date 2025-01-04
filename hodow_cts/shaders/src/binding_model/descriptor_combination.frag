#version 460
layout(binding = 0) uniform texture2D tex;
layout(binding = 1) uniform sampler samplerA;
layout(binding = 2) uniform sampler samplerB;
layout(binding = 3) uniform sampler samplerC;
layout(location = 0) out vec4 outColor;
void main()
{
    vec2 uv = vec2(2.0, 2.0);
    vec4 colorA = texture(sampler2D(tex, samplerA), uv);
    vec4 colorB = texture(sampler2D(tex, samplerB), uv);
    vec4 colorC = texture(sampler2D(tex, samplerC), uv);
    outColor = mix(mix(colorA, colorB, 0.25), colorC, 0.7);
}
