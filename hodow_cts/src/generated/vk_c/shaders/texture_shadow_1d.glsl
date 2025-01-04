#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_texCoord;
layout(location = 0) out highp float v_texCoord;
out gl_PerVertex { vec4 gl_Position; };

void main (void)
{
    gl_Position = a_position;
    v_texCoord = a_texCoord;
}
#version 450
layout(location = 0) in highp float v_texCoord;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp sampler1DShadow u_sampler;
void main (void)
{
  highp float texCoord = v_texCoord;
  dEQP_FragColor = vec4(texture(u_sampler, vec3(texCoord, 0.0, u_ref)), 0.0, 0.0, 1.0) * u_colorScale + u_colorBias;
}
#version 450
layout (local_size_x = 16, local_size_y = 16, local_size_z = 1) in;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec2  u_viewSize;
  highp vec4  u_colorScale;
  highp vec4  u_colorBias;
  int u_lod;
};

layout(push_constant) uniform PushConstants {
  ivec2 u_offset;
} pc;

layout (set=0, binding=1) uniform highp sampler1DShadow u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image1D u_outputImage;
layout (set=0, binding=3, std430) readonly buffer Geometry 
{
  vec4 u_texCoords[4];
  vec4 u_positions[4];
};

highp float interpolate(vec2 p, ivec2 size)
{
  vec2 uv = (p + 0.5) / vec2(size);

  float w0 = u_positions[0].w; float w1 = u_positions[1].w;
  float w2 = u_positions[2].w; float w3 = u_positions[3].w;

  float b0, b1, b2, b3;
  if (uv.x + uv.y <= 1.0)
  {
    b0 = 1.0 - uv.x - uv.y;
    b1 = uv.y;
    b2 = uv.x;
    b3 = 0.0;
  }
  else
  {
    b0 = 0.0;
    b1 = 1.0 - uv.x;
    b2 = 1.0 - uv.y;
    b3 = uv.x + uv.y - 1.0;
  }

  float tc = 
      float(u_texCoords[0]) * (b0 / w0) +
      float(u_texCoords[1]) * (b1 / w1) +
      float(u_texCoords[2]) * (b2 / w2) +
      float(u_texCoords[3]) * (b3 / w3);

  float invW = 
      (b0 / w0) + (b1 / w1) + (b2 / w2) + (b3 / w3);

  return float(tc / invW);
}

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  highp float texCoord = interpolate(vec2(coord), size);
  highp float texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size);
  highp float texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size);
  highp float dPdx      = texCoordX - texCoord;
  highp float dPdy      = texCoordY - texCoord;

  vec4 result = vec4(textureGrad(u_sampler, vec3(texCoord, 0.0, u_ref), dPdx, dPdy), 0.0, 0.0, 1.0) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, int(coord.x + pc.u_offset.x), result);
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) out highp vec2 v_texCoord;
out gl_PerVertex { vec4 gl_Position; };

void main (void)
{
    gl_Position = a_position;
    v_texCoord = a_texCoord;
}
#version 450
layout(location = 0) in highp vec2 v_texCoord;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp sampler1DArrayShadow u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord;
  dEQP_FragColor = vec4(texture(u_sampler, vec3(texCoord, u_ref)), 0.0, 0.0, 1.0) * u_colorScale + u_colorBias;
}
#version 450
layout (local_size_x = 16, local_size_y = 16, local_size_z = 1) in;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec2  u_viewSize;
  highp vec4  u_colorScale;
  highp vec4  u_colorBias;
  int u_lod;
};

layout(push_constant) uniform PushConstants {
  ivec2 u_offset;
} pc;

layout (set=0, binding=1) uniform highp sampler1DArrayShadow u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;
layout (set=0, binding=3, std430) readonly buffer Geometry 
{
  vec4 u_texCoords[4];
  vec4 u_positions[4];
};

highp vec2 interpolate(vec2 p, ivec2 size)
{
  vec2 uv = (p + 0.5) / vec2(size);

  float w0 = u_positions[0].w; float w1 = u_positions[1].w;
  float w2 = u_positions[2].w; float w3 = u_positions[3].w;

  float b0, b1, b2, b3;
  if (uv.x + uv.y <= 1.0)
  {
    b0 = 1.0 - uv.x - uv.y;
    b1 = uv.y;
    b2 = uv.x;
    b3 = 0.0;
  }
  else
  {
    b0 = 0.0;
    b1 = 1.0 - uv.x;
    b2 = 1.0 - uv.y;
    b3 = uv.x + uv.y - 1.0;
  }

  vec2 tc = 
      vec2(u_texCoords[0]) * (b0 / w0) +
      vec2(u_texCoords[1]) * (b1 / w1) +
      vec2(u_texCoords[2]) * (b2 / w2) +
      vec2(u_texCoords[3]) * (b3 / w3);

  float invW = 
      (b0 / w0) + (b1 / w1) + (b2 / w2) + (b3 / w3);

  return vec2(tc / invW);
}

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  highp vec2 texCoord = interpolate(vec2(coord), size);
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size);
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size);
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(textureGrad(u_sampler, vec3(texCoord, u_ref), dPdx.x, dPdy.x), 0.0, 0.0, 1.0) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
