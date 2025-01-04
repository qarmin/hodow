#version 450

layout (location = 0) in vec3 inPosition;
layout (location = 1) in vec4 inColor;

layout (location = 0) out vec4 outColor;

void main()
{
  gl_Position = vec4(inPosition, 1.0);
  outColor = inColor;
}
#version 450

layout (location = 0) in vec4 inColor;
layout (location = 0) out vec4 outColor;

void main()
{
  outColor = inColor;
}
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
#version 450

layout (triangles, equal_spacing, cw) in;
layout (location = 0) patch in vec4 patch_color;
layout (location = 0) out vec4 tes_color;

void main(void)
{
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);

  tes_color = patch_color;
}
