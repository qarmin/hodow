#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = ${binding}, rgba32f) uniform readonly imageBuffer texelBuffer;

void main (void)
{
    fragColor = imageLoad(texelBuffer, 0);
}
