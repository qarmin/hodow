#version 430

layout(location = 0) out vec4 final_color;

layout(set = 0, binding = 0) readonly buffer block1 {
  vec4 in_color;
};

void main() {
  final_color = in_color;
}
