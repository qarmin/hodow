#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
int kind;
} matInst;
void main()
{
    gl_Position = position;
switch (matInst.kind) {
case 0: vtxColor = vec4(0.0, 1.0, 0, 1.0); break;
case 1: vtxColor = vec4(0.0, 0.0, 1.0, 1.0); break;
case 2: vtxColor = vec4(1.0, 0.0, 0, 1.0); break;
default: vtxColor = color; break;}
}
