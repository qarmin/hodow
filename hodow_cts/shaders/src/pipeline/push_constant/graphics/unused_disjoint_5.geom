#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex { vec4 gl_Position; } gl_in[];
out gl_PerVertex { vec4 gl_Position; };
void main()
{
  for(int i=0; i<3; i++)
  {
    gl_Position.xyz = gl_in[i].gl_Position.xyz;
    gl_Position.w = gl_in[i].gl_Position.w;
    vtxColor = color[i];
    EmitVertex();
  }
  EndPrimitive();
}
