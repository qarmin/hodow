#version 450

layout(location = 0) in vec4 position;
layout(location = 0) out vec2 textureCoordinates;

void main() {
  gl_Position = position;
  textureCoordinates = vec2(0.0, 0.0);
}
