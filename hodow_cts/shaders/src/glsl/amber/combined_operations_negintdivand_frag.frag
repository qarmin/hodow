#version 430
layout(location = 0) out vec4 color_out;
layout(location = 1) in vec4 frag_color;
void main() {
  ivec2 iv = ivec2(frag_color.xy * 256);
  if (((iv.y / 2) & 64) == 64)
    color_out = vec4(1, 0, 0, 1);
  else
    color_out = vec4(0, 1, 1, 1);
}
