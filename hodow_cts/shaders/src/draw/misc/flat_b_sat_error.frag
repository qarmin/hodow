#version 430
layout(location = 0) in flat float data_in;
layout(location = 0) out vec4 final_color;
void main() {
  const float epsilon = 0.0009765625; // Makes sure 0.5 is rounded up to 128.
  final_color = vec4(max(0.0, min(max(data_in, 0.0), 1.0) - 0.5) + epsilon, 0.0, 0.0, 1.0);
}
