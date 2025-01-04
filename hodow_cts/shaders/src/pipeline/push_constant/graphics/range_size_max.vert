#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout (constant_id = 0) const uint MaxPushConstantSize = 128;
layout(push_constant) uniform Material {
vec4 color[(MaxPushConstantSize + 12) / 16];
} matInst;
void main()
{
    gl_Position = position;
vec4 color = vec4(0.0, 0, 0, 0.0);
for (int i = 0; i < (MaxPushConstantSize / 16); i++)
{
  color = color + matInst.color[i];
}
for (int i = 0; i < ((MaxPushConstantSize % 16) / 4); i++)
{
  switch (i) {
  case 0: if (matInst.color[(MaxPushConstantSize + 12) / 16 - 1].x != 1.0) color = vec4(0.0); break;
  case 1: if (matInst.color[(MaxPushConstantSize + 12) / 16 - 1].y != 0.0) color = vec4(0.0); break;
  case 2: if (matInst.color[(MaxPushConstantSize + 12) / 16 - 1].z != 0.0) color = vec4(0.0); break;
  default: break;}
}
vtxColor = color / (MaxPushConstantSize / 16);
}
