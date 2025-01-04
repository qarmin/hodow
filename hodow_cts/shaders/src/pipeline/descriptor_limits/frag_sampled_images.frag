#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = ${binding}) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
