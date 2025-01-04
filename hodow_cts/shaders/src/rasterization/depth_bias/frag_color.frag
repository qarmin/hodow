#version 430

layout(location = 0) in vec4 frag_color;
layout(location = 0) out vec4 final_color;

void main() {
  final_color = frag_color;
}
