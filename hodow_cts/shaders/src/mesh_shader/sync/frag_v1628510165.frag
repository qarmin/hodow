#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.readVal > 0u) { readVal = imageLoad(si, ivec2(0, 0)).x; }
    outColor = uvec4(readVal, 0, 0, 0);
}
