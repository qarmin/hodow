#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = ${binding}, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
