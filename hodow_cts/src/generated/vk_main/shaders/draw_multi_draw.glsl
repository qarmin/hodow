#version 460

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
    outColor.a = 255u;
}
#version 460

out gl_PerVertex
{
    vec4 gl_Position;
};

layout (location=0) in vec4 inPos;
layout (location=0) out uvec4 outColor;

void main()
{
    gl_Position = inPos;
    const uint storedIndex = uint(gl_VertexIndex / 3);
    outColor.r = ((storedIndex >> 8u) & 0xFFu);
    outColor.g = ((storedIndex      ) & 0xFFu);
    outColor.b = 255u - uint(gl_InstanceIndex);
    outColor.a = 255u;
}
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
    const uint storedIndex = uint(gl_VertexIndex / 3);
    outColor.r = ((storedIndex >> 8u) & 0xFFu);
    outColor.g = ((storedIndex      ) & 0xFFu);
    outColor.b = 255u - uint(gl_InstanceIndex);
    outColor.a = 255u - uint(gl_ViewIndex);
}
#version 460

layout (location=0) flat in uvec4 inColor;
layout (location=0) out uvec4 outColor;

void main ()
{
    outColor = inColor;
}
#version 460

layout (vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];

layout (location=0) in uvec4 inColor[gl_MaxPatchVertices];
layout (location=0) out uvec4 outColor[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    outColor[gl_InvocationID] = inColor[gl_InvocationID];
}
#version 460

layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
};

layout (location=0) in uvec4 inColor[gl_MaxPatchVertices];
layout (location=0) out uvec4 outColor;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    outColor = inColor[0];
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
};

layout (location=0) in uvec4 inColor[3];
layout (location=0) out uvec4 outColor;

void main ()
{
    gl_Position = gl_in[0].gl_Position; outColor = inColor[0]; EmitVertex();
    gl_Position = gl_in[1].gl_Position; outColor = inColor[1]; EmitVertex();
    gl_Position = gl_in[2].gl_Position; outColor = inColor[2]; EmitVertex();
}
