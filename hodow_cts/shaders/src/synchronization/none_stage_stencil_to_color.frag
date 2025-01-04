#version 450
layout(binding = 0) uniform usampler2D u_sampler;
layout(location = 0) in vec2 inUV;
layout(location = 0) out uvec4 fragColor;
void main(void)
{
  fragColor = texture(u_sampler, inUV);
}
