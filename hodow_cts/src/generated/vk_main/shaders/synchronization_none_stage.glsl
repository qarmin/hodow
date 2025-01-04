#version 450
layout(location = 0) in  vec4 inPosition;
layout(location = 0) out vec2 outUV;
void main(void)
{
  outUV = vec2(inPosition.x * 0.5 + 0.5, inPosition.y * 0.5 + 0.5);
  gl_Position = inPosition;
}
#version 450
layout(binding = 0) uniform sampler2D u_sampler;
layout(location = 0) in vec2 inUV;
layout(location = 0) out vec4 fragColor;
void main(void)
{
  fragColor = texture(u_sampler, inUV);
}
#version 450
layout(binding = 0) uniform sampler2D u_sampler;
layout(location = 0) in vec2 inUV;
void main(void)
{
  gl_FragDepth = texture(u_sampler, inUV).r;
}
#version 450
void main(void)
{
}
#version 450
layout(binding = 0) uniform usampler2D u_sampler;
layout(location = 0) in vec2 inUV;
layout(location = 0) out uvec4 fragColor;
void main(void)
{
  fragColor = texture(u_sampler, inUV);
}
#version 450
layout (input_attachment_index = 0, binding = 0) uniform subpassInput depthOrStencilInput;
layout(location = 0) in vec2 inUV;
layout(location = 0) out float fragColor;
void main (void)
{
  fragColor = subpassLoad(depthOrStencilInput).x;
}
#version 450
layout (input_attachment_index = 0, binding = 0) uniform usubpassInput depthOrStencilInput;
layout(location = 0) in vec2 inUV;
layout(location = 0) out uint fragColor;
void main (void)
{
  fragColor = subpassLoad(depthOrStencilInput).x;
}
