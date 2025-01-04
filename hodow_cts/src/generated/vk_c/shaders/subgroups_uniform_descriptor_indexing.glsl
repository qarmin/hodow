#version 450
void main (void)
{
  const float x = -1.0 + 4.0 * ((gl_VertexIndex & 2)>>1);
  const float y = -1.0 + 4.0 * (gl_VertexIndex % 2);
  gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_nonuniform_qualifier: enable
layout(location = 0) out highp float fragColor;
layout(binding = 0) buffer Data { float c; } data[];
void main (void)
{
  const float noize = fract(9876.54 * cos(654.3267 * gl_FragCoord.x + 1234.5678 * gl_FragCoord.y));
  const uint materialIndex = uint(noize * 4);
  fragColor.r = 0.0;
  for(;;)
  {
    uint i = subgroupBroadcastFirst(materialIndex);
    if(i == materialIndex)
    {
      fragColor.r = data[i].c;
      break;
    }
  }
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_nonuniform_qualifier: enable
layout(location = 0) out highp float fragColor;
layout(r8,binding = 0) uniform imageBuffer data[];
void main (void)
{
  const float noize = fract(9876.54 * cos(654.3267 * gl_FragCoord.x + 1234.5678 * gl_FragCoord.y));
  const uint materialIndex = uint(noize * 16);
  fragColor.r = 0.0;
  for(;;)
  {
    uint i = subgroupBroadcastFirst(materialIndex);
    if(i == materialIndex)
    {
      fragColor.r = imageLoad(data[i], 0).r;
      break;
    }
  }
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_nonuniform_qualifier: enable
layout(location = 0) out highp float fragColor;
layout(binding = 0) uniform samplerBuffer data[];
void main (void)
{
  const float noize = fract(9876.54 * cos(654.3267 * gl_FragCoord.x + 1234.5678 * gl_FragCoord.y));
  const uint materialIndex = uint(noize * 16);
  fragColor.r = 0.0;
  for(;;)
  {
    uint i = subgroupBroadcastFirst(materialIndex);
    if(i == materialIndex)
    {
      fragColor.r = texelFetch(data[i], 0).r;
      break;
    }
  }
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_nonuniform_qualifier: enable
layout(location = 0) out highp float fragColor;
layout(r8,binding = 0) uniform image2D data[];
void main (void)
{
  const float noize = fract(9876.54 * cos(654.3267 * gl_FragCoord.x + 1234.5678 * gl_FragCoord.y));
  const uint materialIndex = uint(noize * 4);
  fragColor.r = 0.0;
  for(;;)
  {
    uint i = subgroupBroadcastFirst(materialIndex);
    if(i == materialIndex)
    {
      fragColor.r = imageLoad(data[i], ivec2(0)).r;
      break;
    }
  }
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_nonuniform_qualifier: enable
layout(location = 0) out highp float fragColor;
layout(binding = 0) uniform sampler data[];
layout(binding = 4) uniform texture2D tex;
void main (void)
{
  const float noize = fract(9876.54 * cos(654.3267 * gl_FragCoord.x + 1234.5678 * gl_FragCoord.y));
  const uint materialIndex = uint(noize * 4);
  fragColor.r = 0.0;
  for(;;)
  {
    uint i = subgroupBroadcastFirst(materialIndex);
    if(i == materialIndex)
    {
      fragColor.r = texture(sampler2D(tex, data[i]), vec2(1.5)).r;
      break;
    }
  }
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_nonuniform_qualifier: enable
layout(location = 0) out highp float fragColor;
layout(binding = 0) uniform texture2D data[];
layout(binding = 16) uniform sampler samp;
void main (void)
{
  const float noize = fract(9876.54 * cos(654.3267 * gl_FragCoord.x + 1234.5678 * gl_FragCoord.y));
  const uint materialIndex = uint(noize * 16);
  fragColor.r = 0.0;
  for(;;)
  {
    uint i = subgroupBroadcastFirst(materialIndex);
    if(i == materialIndex)
    {
      fragColor.r = texture(sampler2D(data[i], samp), vec2(0.5)).r;
      break;
    }
  }
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_nonuniform_qualifier: enable
layout(location = 0) out highp float fragColor;
layout(binding = 0) uniform sampler2D data[];
void main (void)
{
  const float noize = fract(9876.54 * cos(654.3267 * gl_FragCoord.x + 1234.5678 * gl_FragCoord.y));
  const uint materialIndex = uint(noize * 4);
  fragColor.r = 0.0;
  for(;;)
  {
    uint i = subgroupBroadcastFirst(materialIndex);
    if(i == materialIndex)
    {
      fragColor.r = texture(data[i], uvec2(0.5)).r;
      break;
    }
  }
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_nonuniform_qualifier: enable
layout(location = 0) out highp float fragColor;
layout(binding = 0) uniform Data { float c; } data[];
void main (void)
{
  const float noize = fract(9876.54 * cos(654.3267 * gl_FragCoord.x + 1234.5678 * gl_FragCoord.y));
  const uint materialIndex = uint(noize * 12);
  fragColor.r = 0.0;
  for(;;)
  {
    uint i = subgroupBroadcastFirst(materialIndex);
    if(i == materialIndex)
    {
      fragColor.r = data[i].c;
      break;
    }
  }
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_nonuniform_qualifier: enable
layout(location = 0) out highp float fragColor;
layout(input_attachment_index=0,binding = 0) uniform subpassInput data[];
void main (void)
{
  const float noize = fract(9876.54 * cos(654.3267 * gl_FragCoord.x + 1234.5678 * gl_FragCoord.y));
  const uint materialIndex = uint(noize * 4);
  fragColor.r = 0.0;
  for(;;)
  {
    uint i = subgroupBroadcastFirst(materialIndex);
    if(i == materialIndex)
    {
      fragColor.r = subpassLoad(data[i]).r;
      break;
    }
  }
}
