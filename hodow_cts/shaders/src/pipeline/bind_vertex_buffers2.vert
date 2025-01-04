#version 450
layout(location = 0) in vec3 in_color;
${''.join(['layout(location = %d) in vec2 pos%d;\n' % (i, i) for i in [1, 2, 3, 4, 5, 6, 7, 8][:count - 1]])}layout(location = 0) out vec3 out_color;
void main() {
  gl_Position = vec4(${'+'.join(['pos%d' % i for i in [1, 2, 3, 4, 5, 6, 7, 8][:count - 1]])}, 0.0, 1.0);
  out_color = in_color;
}
