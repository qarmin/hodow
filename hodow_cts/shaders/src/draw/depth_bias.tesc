#version 450

layout (location = 0) in vec4 inColor[];
layout (location = 0) patch out vec4 tcColor;
layout (vertices = 3) out;

void main(void)
{
  float tessLevel = 2.0;

  gl_TessLevelInner[0] = tessLevel;
  gl_TessLevelInner[1] = tessLevel;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;

  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  tcColor = inColor[gl_InvocationID];
}
