#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
vec4 color[16];
} matInst;
void main()
{
    gl_Position = position;
vec4 color = vec4(0.0, 0, 0, 0.0);
for (int i = 0; i < 16; i++)
{
  color = color + matInst.color[i];
}
vtxColor = color * 0.0625;
}
