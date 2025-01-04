#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.00781), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.00781), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.00781), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.00781), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.00781), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
    frag_quadrant_id = quadrant_id;
}
#version 440
layout(location = 0) in mediump vec4 frag_color;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    o_color = frag_color;
}
#version 440
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        result_color = vec4(1.0, 1.0, 0.0, 1.0);
    o_color = result_color;
}
#version 440
layout(location = 1) flat out highp int tsc_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
    tsc_quadrant_id = quadrant_id;
}
#version 440
layout(location = 1) flat out highp int geo_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
    geo_quadrant_id = quadrant_id;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.00781), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(vertices=3) out;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 1) flat out highp int tes_quadrant_id[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    tes_quadrant_id[gl_InvocationID] = tsc_quadrant_id[0];

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.00781), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(location = 0) in highp vec4 tes_color[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    frag_color = tes_color[0];
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 3) uniform highp sampler u_separateSamplerB;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler[2];
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.00781), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.00781), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.00781), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.00781), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.00781), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.00781), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.00781), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.00781), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.00781), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.00781), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 3) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.00781), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.00781), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.01562), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.01562), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.01562), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.01562), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.01562), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.01562), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.01562), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 3) uniform highp sampler u_separateSamplerB;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler[2];
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.01562), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.01562), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.01562), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.01562), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.01562), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.01562), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.01562), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSampler[1]), float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.01562), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.01562), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 3) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.01562), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.01562), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.01562), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 3) uniform highp sampler u_separateSamplerB;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler[2];
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 3) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.01562), float(0)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.01562), float(0)), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.01562), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.01562), float(0)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.01562), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 3) uniform highp sampler u_separateSamplerB;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler[2];
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.01562), float(0)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.01562), float(0)), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.01562), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.01562), float(0)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.01562), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.01562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 3) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.01562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0234375), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.726562), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.335938), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.01562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 3) uniform highp sampler u_separateSamplerB;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler[2];
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture, u_separateSampler[1]), vec2(float(1.00781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 3) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0[1]), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[0]), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1[1]), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
