#version 450
layout(location = 0) in vec4 a_position;
layout(location = 1) in vec2 a_texCoord;
out gl_PerVertex { vec4 gl_Position; };

void main (void)
{
    gl_Position = a_position;
}
#version 450
layout(location = 0) out vec4 outColor;
layout (set=0, binding=0, std140) uniform Block 
{
  float u_bias;
  float u_ref;
  vec4 u_colorScale;
  vec4 u_colorBias;
  int u_lod;
};

layout (set=1, binding=0) uniform sampler2D u_sampler;
void main (void)
{
  ivec2 texCoord = ivec2(0,0);
  outColor = texelFetch(u_sampler, texCoord, u_lod) * u_colorScale + u_colorBias;
}
#version 450
layout (local_size_x = 16, local_size_y = 16, local_size_z = 1) in;
layout (set=0, binding=0, std140) uniform Block 
{
  float u_bias;
  float u_ref;
  vec2  u_viewSize;
  vec4  u_colorScale;
  vec4  u_colorBias;
  int   u_lod;
};

layout(push_constant) uniform PushConstants {
  ivec2 u_offset;
} pc;

layout (set=0, binding=1) uniform sampler2D u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  ivec2 texCoord = ivec2(0,0);
  vec4 result = texelFetch(u_sampler, texCoord, u_lod) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 450
layout(location = 0) in vec4 a_position;
layout(location = 1) in vec3 a_texCoord;
out gl_PerVertex { vec4 gl_Position; };

void main (void)
{
    gl_Position = a_position;
}
#version 450
layout(location = 0) out vec4 outColor;
layout (set=0, binding=0, std140) uniform Block 
{
  float u_bias;
  float u_ref;
  vec4 u_colorScale;
  vec4 u_colorBias;
  int u_lod;
};

layout (set=1, binding=0) uniform sampler3D u_sampler;
void main (void)
{
  ivec3 texCoord = ivec3(0,0,0);
  outColor = texelFetch(u_sampler, texCoord, u_lod) * u_colorScale + u_colorBias;
}
#version 450
layout (local_size_x = 16, local_size_y = 16, local_size_z = 1) in;
layout (set=0, binding=0, std140) uniform Block 
{
  float u_bias;
  float u_ref;
  vec2  u_viewSize;
  vec4  u_colorScale;
  vec4  u_colorBias;
  int   u_lod;
};

layout(push_constant) uniform PushConstants {
  ivec2 u_offset;
} pc;

layout (set=0, binding=1) uniform sampler3D u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  ivec3 texCoord = ivec3(0,0,0);
  vec4 result = texelFetch(u_sampler, texCoord, u_lod) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
