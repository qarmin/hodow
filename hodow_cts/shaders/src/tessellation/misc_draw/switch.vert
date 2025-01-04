#version 460
layout (location=0) in vec4 inPos;
layout (push_constant, std430) uniform PushConstantBlock { vec2 offset; } pc;
out gl_PerVertex
{
  vec4 gl_Position;
};
void main() {
    gl_Position = inPos + vec4(pc.offset, 0.0, 0.0);
}
