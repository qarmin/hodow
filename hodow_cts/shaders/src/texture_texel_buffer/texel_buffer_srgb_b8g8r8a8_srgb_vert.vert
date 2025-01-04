#version 430
layout(location = 0) in vec4 position;
layout(location = 1) in vec2 texCoordsIn;
layout(location = 0) out vec2 texCoordsOut;
void main() {
  gl_Position = position;
  texCoordsOut = texCoordsIn;
}
