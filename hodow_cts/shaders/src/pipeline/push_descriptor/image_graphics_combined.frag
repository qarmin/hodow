#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = ${binding}) uniform sampler2D combinedSampler;

void main (void)
{
    fragColor = texture(combinedSampler, texcoordFrag);
}
