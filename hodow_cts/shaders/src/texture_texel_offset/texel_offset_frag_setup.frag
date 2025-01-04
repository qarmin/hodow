#version 430

layout(location = 0) out vec4 result;

void main() {
  result = vec4(floor(gl_FragCoord.x) / 255.0f, floor(gl_FragCoord.y) / 255.0f, 0, 0);
}
