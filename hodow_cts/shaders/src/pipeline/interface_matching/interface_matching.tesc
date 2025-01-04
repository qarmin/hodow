#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

${tesc_declarations}void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
${tesc_operations}}
