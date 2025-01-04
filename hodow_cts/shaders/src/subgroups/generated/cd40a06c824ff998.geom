#version 450
#extension GL_KHR_shader_subgroup_basic: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  tempRes = gl_SubgroupSize;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
