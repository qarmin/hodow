#version 430

layout(location = 0) in vec4 position;
layout(location = 0) out vec4 frag_color;

layout(set = 0, binding = 0) readonly buffer block1 {
  vec4 in_color;
  float depth;
};

void main() {
  gl_Position = vec4(position.xy, depth, 1.0);
  frag_color = in_color;
}
