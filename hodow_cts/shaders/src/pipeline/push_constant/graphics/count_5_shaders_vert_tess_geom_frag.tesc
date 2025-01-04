#version 450
layout (vertices = 3) out;
layout(push_constant) uniform TessLevel {
    layout(offset = 24) int level;
} tessLevel;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor[];
in gl_PerVertex { vec4 gl_Position; } gl_in[gl_MaxPatchVertices];
out gl_PerVertex { vec4 gl_Position; } gl_out[];
void main()
{
  gl_TessLevelInner[0] = tessLevel.level;
  gl_TessLevelOuter[0] = tessLevel.level;
  gl_TessLevelOuter[1] = tessLevel.level;
  gl_TessLevelOuter[2] = tessLevel.level;
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  vtxColor[gl_InvocationID] = color[gl_InvocationID];
}
