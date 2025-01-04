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

layout (set=1, binding=0) uniform highp sampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord;
  dEQP_FragColor = texture(u_sampler, texCoord) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler2D u_sampler;
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

  vec4 result = textureGrad(u_sampler, texCoord, dPdx, dPdy) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp sampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.yx;
  dEQP_FragColor = texture(u_sampler, texCoord) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).yx;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).yx;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).yx;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = textureGrad(u_sampler, texCoord, dPdx, dPdy) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp sampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.xx;
  dEQP_FragColor = texture(u_sampler, texCoord) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).xx;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).xx;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).xx;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = textureGrad(u_sampler, texCoord, dPdx, dPdy) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp sampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.yy;
  dEQP_FragColor = texture(u_sampler, texCoord) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).yy;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).yy;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).yy;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = textureGrad(u_sampler, texCoord, dPdx, dPdy) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp sampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord;
  dEQP_FragColor = texture(u_sampler, texCoord, u_bias) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler2D u_sampler;
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

  vec4 result = textureLod(u_sampler, texCoord, log2(max(length(dPdx * vec2(textureSize(u_sampler, 0))), length(dPdy * vec2(textureSize(u_sampler, 0))))) + u_bias) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp sampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.yx;
  dEQP_FragColor = texture(u_sampler, texCoord, u_bias) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).yx;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).yx;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).yx;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = textureLod(u_sampler, texCoord, log2(max(length(dPdx * vec2(textureSize(u_sampler, 0))), length(dPdy * vec2(textureSize(u_sampler, 0))))) + u_bias) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp sampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.xx;
  dEQP_FragColor = texture(u_sampler, texCoord, u_bias) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).xx;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).xx;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).xx;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = textureLod(u_sampler, texCoord, log2(max(length(dPdx * vec2(textureSize(u_sampler, 0))), length(dPdy * vec2(textureSize(u_sampler, 0))))) + u_bias) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp sampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.yy;
  dEQP_FragColor = texture(u_sampler, texCoord, u_bias) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).yy;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).yy;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).yy;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = textureLod(u_sampler, texCoord, log2(max(length(dPdx * vec2(textureSize(u_sampler, 0))), length(dPdy * vec2(textureSize(u_sampler, 0))))) + u_bias) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp isampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp isampler2D u_sampler;
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

  vec4 result = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp isampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.yx;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp isampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).yx;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).yx;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).yx;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp isampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.xx;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp isampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).xx;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).xx;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).xx;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp isampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.yy;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp isampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).yy;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).yy;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).yy;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp usampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp usampler2D u_sampler;
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

  vec4 result = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp usampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.yx;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp usampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).yx;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).yx;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).yx;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp usampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.xx;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp usampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).xx;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).xx;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).xx;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp usampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.yy;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp usampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).yy;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).yy;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).yy;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp sampler2DShadow u_sampler;
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

layout (set=0, binding=1) uniform highp sampler2DShadow u_sampler;
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

  vec4 result = vec4(textureGrad(u_sampler, vec3(texCoord, u_ref), dPdx, dPdy), 0.0, 0.0, 1.0) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp sampler2DShadow u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.yx;
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

layout (set=0, binding=1) uniform highp sampler2DShadow u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).yx;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).yx;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).yx;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(textureGrad(u_sampler, vec3(texCoord, u_ref), dPdx, dPdy), 0.0, 0.0, 1.0) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp sampler2DShadow u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.xx;
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

layout (set=0, binding=1) uniform highp sampler2DShadow u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).xx;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).xx;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).xx;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(textureGrad(u_sampler, vec3(texCoord, u_ref), dPdx, dPdy), 0.0, 0.0, 1.0) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp sampler2DShadow u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.yy;
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

layout (set=0, binding=1) uniform highp sampler2DShadow u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).yy;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).yy;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).yy;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(textureGrad(u_sampler, vec3(texCoord, u_ref), dPdx, dPdy), 0.0, 0.0, 1.0) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_texCoord;
layout(location = 0) out highp vec3 v_texCoord;
out gl_PerVertex { vec4 gl_Position; };

void main (void)
{
    gl_Position = a_position;
    v_texCoord = a_texCoord;
}
#version 450
layout(location = 0) in highp vec3 v_texCoord;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp sampler3D u_sampler;
void main (void)
{
  highp vec3 texCoord = v_texCoord;
  dEQP_FragColor = texture(u_sampler, texCoord) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler3D u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;
layout (set=0, binding=3, std430) readonly buffer Geometry 
{
  vec4 u_texCoords[4];
  vec4 u_positions[4];
};

highp vec3 interpolate(vec2 p, ivec2 size)
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

  vec3 tc = 
      vec3(u_texCoords[0]) * (b0 / w0) +
      vec3(u_texCoords[1]) * (b1 / w1) +
      vec3(u_texCoords[2]) * (b2 / w2) +
      vec3(u_texCoords[3]) * (b3 / w3);

  float invW = 
      (b0 / w0) + (b1 / w1) + (b2 / w2) + (b3 / w3);

  return vec3(tc / invW);
}

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  highp vec3 texCoord = interpolate(vec2(coord), size);
  highp vec3 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size);
  highp vec3 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size);
  highp vec3 dPdx      = texCoordX - texCoord;
  highp vec3 dPdy      = texCoordY - texCoord;

  vec4 result = textureGrad(u_sampler, texCoord, dPdx, dPdy) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 450
layout(location = 0) in highp vec3 v_texCoord;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp sampler3D u_sampler;
void main (void)
{
  highp vec3 texCoord = v_texCoord;
  dEQP_FragColor = texture(u_sampler, texCoord, u_bias) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler3D u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;
layout (set=0, binding=3, std430) readonly buffer Geometry 
{
  vec4 u_texCoords[4];
  vec4 u_positions[4];
};

highp vec3 interpolate(vec2 p, ivec2 size)
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

  vec3 tc = 
      vec3(u_texCoords[0]) * (b0 / w0) +
      vec3(u_texCoords[1]) * (b1 / w1) +
      vec3(u_texCoords[2]) * (b2 / w2) +
      vec3(u_texCoords[3]) * (b3 / w3);

  float invW = 
      (b0 / w0) + (b1 / w1) + (b2 / w2) + (b3 / w3);

  return vec3(tc / invW);
}

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  highp vec3 texCoord = interpolate(vec2(coord), size);
  highp vec3 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size);
  highp vec3 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size);
  highp vec3 dPdx      = texCoordX - texCoord;
  highp vec3 dPdy      = texCoordY - texCoord;

  vec4 result = textureLod(u_sampler, texCoord, log2(max(length(dPdx * vec3(textureSize(u_sampler, 0))), length(dPdy * vec3(textureSize(u_sampler, 0))))) + u_bias) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 450
layout(location = 0) in highp vec3 v_texCoord;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp usampler3D u_sampler;
void main (void)
{
  highp vec3 texCoord = v_texCoord;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp usampler3D u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;
layout (set=0, binding=3, std430) readonly buffer Geometry 
{
  vec4 u_texCoords[4];
  vec4 u_positions[4];
};

highp vec3 interpolate(vec2 p, ivec2 size)
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

  vec3 tc = 
      vec3(u_texCoords[0]) * (b0 / w0) +
      vec3(u_texCoords[1]) * (b1 / w1) +
      vec3(u_texCoords[2]) * (b2 / w2) +
      vec3(u_texCoords[3]) * (b3 / w3);

  float invW = 
      (b0 / w0) + (b1 / w1) + (b2 / w2) + (b3 / w3);

  return vec3(tc / invW);
}

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  highp vec3 texCoord = interpolate(vec2(coord), size);
  highp vec3 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size);
  highp vec3 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size);
  highp vec3 dPdx      = texCoordX - texCoord;
  highp vec3 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 450
layout(location = 0) in highp vec3 v_texCoord;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp sampler2DArray u_sampler;
void main (void)
{
  highp vec3 texCoord = v_texCoord;
  dEQP_FragColor = texture(u_sampler, texCoord) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler2DArray u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;
layout (set=0, binding=3, std430) readonly buffer Geometry 
{
  vec4 u_texCoords[4];
  vec4 u_positions[4];
};

highp vec3 interpolate(vec2 p, ivec2 size)
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

  vec3 tc = 
      vec3(u_texCoords[0]) * (b0 / w0) +
      vec3(u_texCoords[1]) * (b1 / w1) +
      vec3(u_texCoords[2]) * (b2 / w2) +
      vec3(u_texCoords[3]) * (b3 / w3);

  float invW = 
      (b0 / w0) + (b1 / w1) + (b2 / w2) + (b3 / w3);

  return vec3(tc / invW);
}

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  highp vec3 texCoord = interpolate(vec2(coord), size);
  highp vec3 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size);
  highp vec3 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size);
  highp vec3 dPdx      = texCoordX - texCoord;
  highp vec3 dPdy      = texCoordY - texCoord;

  vec4 result = textureGrad(u_sampler, texCoord, dPdx.xy, dPdy.xy) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 450
layout(location = 0) in highp vec3 v_texCoord;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp usampler2DArray u_sampler;
void main (void)
{
  highp vec3 texCoord = v_texCoord;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp usampler2DArray u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;
layout (set=0, binding=3, std430) readonly buffer Geometry 
{
  vec4 u_texCoords[4];
  vec4 u_positions[4];
};

highp vec3 interpolate(vec2 p, ivec2 size)
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

  vec3 tc = 
      vec3(u_texCoords[0]) * (b0 / w0) +
      vec3(u_texCoords[1]) * (b1 / w1) +
      vec3(u_texCoords[2]) * (b2 / w2) +
      vec3(u_texCoords[3]) * (b3 / w3);

  float invW = 
      (b0 / w0) + (b1 / w1) + (b2 / w2) + (b3 / w3);

  return vec3(tc / invW);
}

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  highp vec3 texCoord = interpolate(vec2(coord), size);
  highp vec3 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size);
  highp vec3 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size);
  highp vec3 dPdx      = texCoordX - texCoord;
  highp vec3 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 450
layout(location = 0) in highp vec3 v_texCoord;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp samplerCube u_sampler;
void main (void)
{
  highp vec3 texCoord = v_texCoord;
  dEQP_FragColor = texture(u_sampler, texCoord) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp samplerCube u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;
layout (set=0, binding=3, std430) readonly buffer Geometry 
{
  vec4 u_texCoords[4];
  vec4 u_positions[4];
};

highp vec3 interpolate(vec2 p, ivec2 size)
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

  vec3 tc = 
      vec3(u_texCoords[0]) * (b0 / w0) +
      vec3(u_texCoords[1]) * (b1 / w1) +
      vec3(u_texCoords[2]) * (b2 / w2) +
      vec3(u_texCoords[3]) * (b3 / w3);

  float invW = 
      (b0 / w0) + (b1 / w1) + (b2 / w2) + (b3 / w3);

  return vec3(tc / invW);
}

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  highp vec3 texCoord = interpolate(vec2(coord), size);
  highp vec3 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size);
  highp vec3 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size);
  highp vec3 dPdx      = texCoordX - texCoord;
  highp vec3 dPdy      = texCoordY - texCoord;

  vec4 result = textureGrad(u_sampler, texCoord, dPdx, dPdy) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 450
layout(location = 0) in highp vec3 v_texCoord;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp samplerCube u_sampler;
void main (void)
{
  highp vec3 texCoord = v_texCoord;
  dEQP_FragColor = texture(u_sampler, texCoord, u_bias) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp samplerCube u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;
layout (set=0, binding=3, std430) readonly buffer Geometry 
{
  vec4 u_texCoords[4];
  vec4 u_positions[4];
};

highp vec3 interpolate(vec2 p, ivec2 size)
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

  vec3 tc = 
      vec3(u_texCoords[0]) * (b0 / w0) +
      vec3(u_texCoords[1]) * (b1 / w1) +
      vec3(u_texCoords[2]) * (b2 / w2) +
      vec3(u_texCoords[3]) * (b3 / w3);

  float invW = 
      (b0 / w0) + (b1 / w1) + (b2 / w2) + (b3 / w3);

  return vec3(tc / invW);
}

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  highp vec3 texCoord = interpolate(vec2(coord), size);
  highp vec3 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size);
  highp vec3 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size);
  highp vec3 dPdx      = texCoordX - texCoord;
  highp vec3 dPdy      = texCoordY - texCoord;

  vec4 result = textureLod(u_sampler, texCoord, log2(max(length(dPdx), length(dPdy)) * float(textureSize(u_sampler, 0).x)) + u_bias) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 450
layout(location = 0) in highp vec3 v_texCoord;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp usamplerCube u_sampler;
void main (void)
{
  highp vec3 texCoord = v_texCoord;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp usamplerCube u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;
layout (set=0, binding=3, std430) readonly buffer Geometry 
{
  vec4 u_texCoords[4];
  vec4 u_positions[4];
};

highp vec3 interpolate(vec2 p, ivec2 size)
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

  vec3 tc = 
      vec3(u_texCoords[0]) * (b0 / w0) +
      vec3(u_texCoords[1]) * (b1 / w1) +
      vec3(u_texCoords[2]) * (b2 / w2) +
      vec3(u_texCoords[3]) * (b3 / w3);

  float invW = 
      (b0 / w0) + (b1 / w1) + (b2 / w2) + (b3 / w3);

  return vec3(tc / invW);
}

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  highp vec3 texCoord = interpolate(vec2(coord), size);
  highp vec3 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size);
  highp vec3 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size);
  highp vec3 dPdx      = texCoordX - texCoord;
  highp vec3 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(texture(u_sampler, texCoord)) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 450
layout(location = 0) in highp vec3 v_texCoord;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp sampler2DArrayShadow u_sampler;
void main (void)
{
  highp vec3 texCoord = v_texCoord;
  dEQP_FragColor = vec4(texture(u_sampler, vec4(texCoord, u_ref)), 0.0, 0.0, 1.0) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler2DArrayShadow u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;
layout (set=0, binding=3, std430) readonly buffer Geometry 
{
  vec4 u_texCoords[4];
  vec4 u_positions[4];
};

highp vec3 interpolate(vec2 p, ivec2 size)
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

  vec3 tc = 
      vec3(u_texCoords[0]) * (b0 / w0) +
      vec3(u_texCoords[1]) * (b1 / w1) +
      vec3(u_texCoords[2]) * (b2 / w2) +
      vec3(u_texCoords[3]) * (b3 / w3);

  float invW = 
      (b0 / w0) + (b1 / w1) + (b2 / w2) + (b3 / w3);

  return vec3(tc / invW);
}

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  highp vec3 texCoord = interpolate(vec2(coord), size);
  highp vec3 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size);
  highp vec3 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size);
  highp vec3 dPdx      = texCoordX - texCoord;
  highp vec3 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(textureGrad(u_sampler, vec4(texCoord, u_ref), dPdx.xy, dPdy.xy), 0.0, 0.0, 1.0) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 450
layout(location = 0) in highp vec3 v_texCoord;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp samplerCubeShadow u_sampler;
void main (void)
{
  highp vec3 texCoord = v_texCoord;
  dEQP_FragColor = vec4(texture(u_sampler, vec4(texCoord, u_ref)), 0.0, 0.0, 1.0) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp samplerCubeShadow u_sampler;
layout (set=0, binding=2, rgba8) uniform writeonly image2D u_outputImage;
layout (set=0, binding=3, std430) readonly buffer Geometry 
{
  vec4 u_texCoords[4];
  vec4 u_positions[4];
};

highp vec3 interpolate(vec2 p, ivec2 size)
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

  vec3 tc = 
      vec3(u_texCoords[0]) * (b0 / w0) +
      vec3(u_texCoords[1]) * (b1 / w1) +
      vec3(u_texCoords[2]) * (b2 / w2) +
      vec3(u_texCoords[3]) * (b3 / w3);

  float invW = 
      (b0 / w0) + (b1 / w1) + (b2 / w2) + (b3 / w3);

  return vec3(tc / invW);
}

void main (void)
{
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size  = ivec2(u_viewSize);
  if (coord.x >= size.x || coord.y >= size.y)
    return;

  highp vec3 texCoord = interpolate(vec2(coord), size);
  highp vec3 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size);
  highp vec3 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size);
  highp vec3 dPdx      = texCoordX - texCoord;
  highp vec3 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(textureGrad(u_sampler, vec4(texCoord, u_ref), dPdx, dPdy), 0.0, 0.0, 1.0) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp isampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord, u_bias)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp isampler2D u_sampler;
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

  vec4 result = vec4(textureGrad(u_sampler, texCoord, dPdx * exp2(u_bias), dPdy * exp2(u_bias))) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp isampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.yx;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord, u_bias)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp isampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).yx;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).yx;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).yx;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(textureGrad(u_sampler, texCoord, dPdx * exp2(u_bias), dPdy * exp2(u_bias))) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp isampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.xx;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord, u_bias)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp isampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).xx;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).xx;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).xx;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(textureGrad(u_sampler, texCoord, dPdx * exp2(u_bias), dPdy * exp2(u_bias))) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp isampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord.yy;
  dEQP_FragColor = vec4(texture(u_sampler, texCoord, u_bias)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp isampler2D u_sampler;
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

  highp vec2 texCoord = interpolate(vec2(coord), size).yy;
  highp vec2 texCoordX = interpolate(vec2(coord) + vec2(1.0, 0.0), size).yy;
  highp vec2 texCoordY = interpolate(vec2(coord) + vec2(0.0, 1.0), size).yy;
  highp vec2 dPdx      = texCoordX - texCoord;
  highp vec2 dPdy      = texCoordY - texCoord;

  vec4 result = vec4(textureGrad(u_sampler, texCoord, dPdx * exp2(u_bias), dPdy * exp2(u_bias))) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp sampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord;
  dEQP_FragColor = textureLod(u_sampler, texCoord, 0) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler2D u_sampler;
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

  vec4 result = textureLod(u_sampler, texCoord, 0) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
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

layout (set=1, binding=0) uniform highp usampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord;
  dEQP_FragColor = vec4(textureLod(u_sampler, texCoord, 0)) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp usampler2D u_sampler;
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

  vec4 result = vec4(textureLod(u_sampler, texCoord, 0)) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 450
layout(location = 0) in highp vec2 v_texCoord;
layout(location = 0) out highp vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  highp float u_bias;
  highp float u_ref;
  highp vec4 u_colorScale;
  highp vec4 u_colorBias;
};

layout (set=1, binding=0) uniform highp sampler2D u_sampler;
void main (void)
{
  highp vec2 texCoord = v_texCoord;
  dEQP_FragColor = texture(u_sampler, texCoord) * u_colorScale + u_colorBias;
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

layout (set=0, binding=1) uniform highp sampler2D u_sampler;
layout (set=0, binding=2, rgba32f) uniform writeonly image2D u_outputImage;
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

  vec4 result = textureGrad(u_sampler, texCoord, dPdx, dPdy) * u_colorScale + u_colorBias;
  imageStore(u_outputImage, coord + pc.u_offset, result);
}
#version 430
layout(location = 0) in vec4 position;
void main()
{
    gl_Position = position;
}
#version 430
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler1D tex_sampler;
void main()
{
    vec4 color = texture(tex_sampler, 0.0);
    for (int i = 0; i < 1; i++)
    {
        if (color[i] != -1.0)
        {
            frag_out = vec4(1, 0, 0, 1);
            return;
        }
    }

    frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler1D tex_sampler;
void main()
{
    vec4 color = texture(tex_sampler, 0.0);
    for (int i = 0; i < 2; i++)
    {
        if (color[i] != -1.0)
        {
            frag_out = vec4(1, 0, 0, 1);
            return;
        }
    }

    frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler1D tex_sampler;
void main()
{
    vec4 color = texture(tex_sampler, 0.0);
    for (int i = 0; i < 3; i++)
    {
        if (color[i] != -1.0)
        {
            frag_out = vec4(1, 0, 0, 1);
            return;
        }
    }

    frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler1D tex_sampler;
void main()
{
    vec4 color = texture(tex_sampler, 0.0);
    for (int i = 0; i < 4; i++)
    {
        if (color[i] != -1.0)
        {
            frag_out = vec4(1, 0, 0, 1);
            return;
        }
    }

    frag_out = vec4(0, 1, 0, 1);
}
