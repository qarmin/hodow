#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = ${binding_next}) uniform sampler texSampler;
layout(set = 0, binding = ${binding}) uniform texture2D texImage;

void main (void)
{
    fragColor = texture(sampler2D(texImage, texSampler), texcoordFrag);
}
