#version 450
#extension GL_KHR_shader_subgroup_basic: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out vec4 out_color;
void main (void)
{
  out_color = vec4(gl_SubgroupSize, gl_SubgroupInvocationID + 1024, 0.0f, 0.0f);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
