#version 450
#extension GL_KHR_shader_subgroup_basic: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  tempRes = gl_SubgroupSize;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
