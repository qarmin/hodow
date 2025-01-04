#version 460
#extension GL_EXT_multiview : enable

out gl_PerVertex
{
    vec4 gl_Position;
};

layout (location=0) in vec4 inPos;
layout (location=0) out uvec4 outColor;

void main()
{
    gl_Position = inPos;
    const uint storedIndex = uint(gl_DrawID);
    outColor.r = ((storedIndex >> 8u) & 0xFFu);
    outColor.g = ((storedIndex      ) & 0xFFu);
    outColor.b = 255u - uint(gl_InstanceIndex);
    outColor.a = 255u - uint(gl_ViewIndex);
}
