#version 450
precision mediump int; precision highp float;
layout(location = 0) out vec2 v_texCoord;

void main (void)
{
  vec4 a_position = vec4(float(gl_VertexIndex & 1) * 2.0 - 1.0, float(gl_VertexIndex >> 1) * 2.0 - 1.0, 0.0, 1.0);
  v_texCoord = a_position.xy * 0.5 + 0.5;
  gl_Position = a_position;
}
