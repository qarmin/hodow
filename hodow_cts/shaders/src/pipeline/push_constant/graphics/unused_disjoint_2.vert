#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
vec4 color;
} matInst;
layout(std140, binding = 0) uniform UniformBuf {
vec4 element;
} uniformBuf;
void main()
{
    gl_Position = position;
vtxColor = (matInst.color + uniformBuf.element) * 0.5;
}
