#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) in highp vec4 in_vtxColor[];
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
in gl_PerVertex { vec4 gl_Position; } gl_in[];
void main (void)
{
  for(int ndx=0; ndx<3; ndx++)
  {
    gl_Position = gl_in[ndx].gl_Position;
    vtxColor    = in_vtxColor[ndx] + 0.1;
    EmitVertex();
  }
  EndPrimitive();
}
