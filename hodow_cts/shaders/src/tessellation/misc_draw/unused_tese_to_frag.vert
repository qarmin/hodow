#version 460
layout (location=0) in vec4 inPos;
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (location=0, component=0) out float vsA;
layout (location=0, component=1) out float vsB;
layout (location=0, component=2) out vec2  vsCD;
layout (location=1)              out vec4  vsEFGH;
void main() {
    gl_Position = inPos;
    vsA    = 0.125;
    vsB    = 0.375;
    vsCD   = vec2(0.625, 0.875);
    vsEFGH = vec4(0.1, 0.2, 0.3, 0.4);
}
