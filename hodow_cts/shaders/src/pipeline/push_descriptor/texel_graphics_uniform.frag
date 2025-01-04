#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = ${binding}) uniform textureBuffer texelBuffer;

void main (void)
{
    fragColor = texelFetch(texelBuffer, 0);
}
