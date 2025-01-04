#version 430

layout(binding = 0) uniform sampler2D tex;

layout(location = 0) out vec4 result;

void main() {
  vec2 base = floor(gl_FragCoord.xy) / 255.0f;
  uint mask = 0;
  mask |= textureOffset(tex, base, ivec2(0, -1)).g < base.y ? 1 : 0;
  mask |= textureOffset(tex, base, ivec2(0, 1)).g > base.y ? 2 : 0;
  mask |= textureOffset(tex, base, ivec2(-1, 0)).r < base.x ? 4 : 0;
  mask |= textureOffset(tex, base, ivec2(1, 0)).r > base.x ? 8 : 0;
  result = vec4(mask/255.0f, 0, 0, 0);
}
