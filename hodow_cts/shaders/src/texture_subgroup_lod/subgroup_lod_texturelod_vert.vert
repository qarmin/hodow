#version 430

layout(location = 0) in vec3 position_in;
layout(location = 0) out vec4 color_out;
layout(set = 0, binding = 0) uniform highp sampler2D tex;

void main() {
  gl_Position = vec4(position_in, 1.0);
  // Pick a color from the center of a mipmap. Each corner point gets its own mip level.
  color_out = vec4(textureLod(tex, vec2(0.5), float(gl_VertexIndex % 4)));
}
