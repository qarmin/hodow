#version 310 es
#extension GL_EXT_geometry_shader : enable
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) in highp vec4 in_vtxColor[];
layout(location = 0) out highp vec4 vtxColor;
void main (void)
{
  for(int ndx=0; ndx<3; ndx++)
  {
    gl_Position = gl_in[ndx].gl_Position;
    vtxColor    = in_vtxColor[ndx];
    EmitVertex();
  }
  EndPrimitive();
}
