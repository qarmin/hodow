#version 450
layout(vertices = 3) out;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor[];
out gl_PerVertex { vec4 gl_Position; } gl_out[3];
in gl_PerVertex { vec4 gl_Position; } gl_in[gl_MaxPatchVertices];
void main()
{
  gl_TessLevelOuter[0] = 4.0;
  gl_TessLevelOuter[1] = 4.0;
  gl_TessLevelOuter[2] = 4.0;
  gl_TessLevelInner[0] = 4.0;
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  vtxColor[gl_InvocationID] = color[gl_InvocationID];
}
