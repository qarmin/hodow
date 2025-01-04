#version 430
layout(location = 0) in vec2 data_in;
layout(location = 0) out flat float data_out;
void main() {
  const float count = 5.0;
  gl_PointSize = 1.0;
  gl_Position = vec4((((data_in.x + 0.5) / count) * 2.0) - 1.0, 0.0, 0.0, 1.0);
  data_out = data_in.y;
}
