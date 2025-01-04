#version 430

layout(location = 0) in vec4 position;
layout(location = 1) out vec4 frag_color;

void main() {
  gl_Position = position;
  frag_color = position * 0.5;
}
