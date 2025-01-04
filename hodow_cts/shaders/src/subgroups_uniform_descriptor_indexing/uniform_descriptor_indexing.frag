#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_nonuniform_qualifier: enable
layout(location = 0) out highp float fragColor;
layout(${extra_layout}binding = 0) ${declaration} data[];
${extra_declarations}void main (void)
{
  const float noize = fract(9876.54 * cos(654.3267 * gl_FragCoord.x + 1234.5678 * gl_FragCoord.y));
  const uint materialIndex = uint(noize * ${count});
  fragColor.r = 0.0;
  for(;;)
  {
    uint i = subgroupBroadcastFirst(materialIndex);
    if(i == materialIndex)
    {
      fragColor.r = ${access_method};
      break;
    }
  }
}
