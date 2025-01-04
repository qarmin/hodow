#version 450
precision mediump int; precision highp float;
layout(location = 0) in vec2 v_texCoord;
layout(location = 0) out vec4 dEQP_FragColor;
layout (set=0, binding=0) uniform sampler2D u_sampler;
void main (void)
{
  dEQP_FragColor = vec4(texture(u_sampler, v_texCoord));
}
