#version 450
layout(binding = 0) uniform sampler2D u_sampler;
layout(location = 0) in vec2 inUV;
void main(void)
{
  gl_FragDepth = texture(u_sampler, inUV).r;
}
