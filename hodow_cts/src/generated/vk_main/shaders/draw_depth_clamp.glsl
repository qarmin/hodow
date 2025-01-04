#version 450

layout(location = 0) in vec4 in_position;
void main(void)
{
    gl_Position = in_position;
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(invocations = 4) in;
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
void main()
{
  const float depthValues[] = { 0.700000, 1.000000, 0.900000, 0.400000,  0.0 };
  for (int i = 0; i < gl_in.length(); i++)
  {
    gl_ViewportIndex = gl_InvocationID;
    gl_Position      = gl_in[i].gl_Position;
    gl_Position.z    = depthValues[gl_InvocationID];
    EmitVertex();
  }
  EndPrimitive();
}
#version 450
void main(void)
{
}
