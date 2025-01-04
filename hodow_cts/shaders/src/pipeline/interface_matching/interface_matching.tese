#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
${tese_declarations}void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
${tese_operations}}
