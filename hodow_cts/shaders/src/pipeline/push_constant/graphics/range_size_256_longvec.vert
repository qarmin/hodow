#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
vector<float, 64> color;
} matInst;
void main()
{
    gl_Position = position;
vec4 color = vec4(0.0, 0, 0, 0.0);
for (int i = 0; i < 16; i++)
{
  color = color + vec4(matInst.color[i*4], matInst.color[i*4+1], matInst.color[i*4+2], matInst.color[i*4+3]);
}
vtxColor = color * 0.0625;
}
