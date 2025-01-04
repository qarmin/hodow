#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = ${binding}, rgba8) uniform readonly image2D storageImage;

void main (void)
{
    fragColor = imageLoad(storageImage, ivec2(0));
}
