#version 430

layout(location = 0) in vec3 position_in;
layout(location = 0) out vec4 color_out;
layout(set = 0, binding = 0) uniform highp sampler2D tex;

void main() {
  gl_Position = vec4(position_in, 1.0);
  // Vary dPdx and dPdy based on vertex index to force
  // LOD 0 or LOD 1.
  vec2 v = vec2(0);
  if (gl_VertexIndex % 2 != 0)
      v = vec2(1);

  color_out = vec4(textureGrad(tex, vec2(0.5), v, v));
}
