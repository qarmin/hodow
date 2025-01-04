#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler1D u_combinedTextureSampler0A;
layout(set = 0, binding = 2) uniform highp sampler1D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1D u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, float(1.00781), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1D u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1D u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, float(1.00781), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1D u_combinedTextureSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, float(1.00781), 0.0);
    result_color /= vec4(2.0);
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
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1D u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, float(1.00781), 0.0);
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
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1D u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, float(1.00781), 0.0);
    result_color /= vec4(2.0);

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
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1D u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, float(1.00781), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler1D u_combinedTextureSampler;
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
        result_color += textureLod(u_combinedTextureSampler, float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, float(-0.335938), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, float(1.01562), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler;
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
        result_color += textureLod(u_combinedTextureSampler, float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, float(-0.335938), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, float(1.01562), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler;
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
        result_color += textureLod(u_combinedTextureSampler, float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, float(-0.335938), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, float(1.01562), 0.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, float(-0.335938), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, float(1.01562), 0.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, float(-0.335938), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, float(1.01562), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler;
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
        result_color += textureLod(u_combinedTextureSampler, float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, float(-0.335938), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, float(1.01562), 0.0);

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
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler;
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
        result_color += textureLod(u_combinedTextureSampler, float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, float(-0.335938), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, float(1.01562), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler;
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
        result_color += textureLod(u_combinedTextureSampler, float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, float(-0.335938), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, float(-0.335938), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, float(-0.335938), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, float(-0.335938), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, float(1.01562), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1;
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
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1;
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
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1;
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
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1;
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
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0)), 0.0);
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
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1;
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
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1;
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
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 2) uniform highp sampler1DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0)), 0.0);
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
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler;
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
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, vec2(float(1.00781), float(0.175781)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, vec2(float(1.00781), float(0.175781)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, vec2(float(1.00781), float(0.175781)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, vec2(float(1.00781), float(0.175781)), 0.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, vec2(float(1.00781), float(0.175781)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
layout(location = 1) flat out highp int frag_quadrant_id;
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
#version 310 es
layout(location = 0) in mediump vec4 frag_color;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    o_color = frag_color;
}
#version 310 es
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
#version 310 es
layout(location = 1) flat out highp int tsc_quadrant_id;
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
#version 310 es
layout(location = 1) flat out highp int geo_quadrant_id;
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, vec2(float(1.00781), float(0.175781)), 0.0);

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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 1) flat out highp int tes_quadrant_id[];
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, vec2(float(1.00781), float(0.175781)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(location = 0) in highp vec4 tes_color[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    frag_color = tes_color[0];
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, vec2(float(1.00781), float(0.175781)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, vec2(float(1.00781), float(0.175781)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, vec2(float(1.00781), float(0.175781)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler, vec2(float(1.00781), float(0.175781)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSamplerB;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.00781), float(0.175781)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.00781), float(0.175781)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.00781), float(0.175781)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.00781), float(0.175781)), 0.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.00781), float(0.175781)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.00781), float(0.175781)), 0.0);

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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.00781), float(0.175781)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.00781), float(0.175781)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.00781), float(0.175781)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.00781), float(0.175781)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.00781), float(0.175781)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1[2];
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(1.00781), float(0.175781)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
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
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0.175781)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 3) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 2) uniform highp sampler2D u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 2) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 2) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 2) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 2) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 2) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 2) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 2) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 2) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 2) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 2) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 2) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 2) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 2) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 2) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 2) uniform highp sampler2D u_combinedTextureSamplerB;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.01562), float(0.351562)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.01562), float(0.351562)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.01562), float(0.351562)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.01562), float(0.351562)), 0.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.01562), float(0.351562)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.01562), float(0.351562)), 0.0);

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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.01562), float(0.351562)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.01562), float(0.351562)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.01562), float(0.351562)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.01562), float(0.351562)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec2(float(1.01562), float(0.351562)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
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
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.01562), float(0.351562)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.01562), float(0.351562)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 32766) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 65534) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 32766) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 65534) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 2) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2D u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2D u_combinedTextureSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 2) uniform highp sampler2DArray u_combinedTextureSamplerB;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.01562), float(0.351562), float(0)), 0.0);

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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.01562), float(0.351562), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 2) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 2) uniform highp sampler2DArray u_combinedTextureSamplerB;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.00781), float(0.175781), float(0)), 0.0);

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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.00781), float(0.175781), float(0)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 2) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler2DArray u_combinedTextureSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler3D u_combinedTextureSampler[2];
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
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(0.0117188), float(0.0078125), float(0.191406)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(0.363281), float(0.148438), float(1.25781)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.667969), float(1.32031), float(0.839844)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1.00781), float(0.175781), float(1.30078)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler[2];
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(0.0117188), float(0.0078125), float(0.191406)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(0.363281), float(0.148438), float(1.25781)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.667969), float(1.32031), float(0.839844)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1.00781), float(0.175781), float(1.30078)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(0.0117188), float(0.0078125), float(0.191406)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(0.363281), float(0.148438), float(1.25781)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.667969), float(1.32031), float(0.839844)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1.00781), float(0.175781), float(1.30078)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(0.0117188), float(0.0078125), float(0.191406)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(0.363281), float(0.148438), float(1.25781)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.667969), float(1.32031), float(0.839844)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1.00781), float(0.175781), float(1.30078)), 0.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(0.0117188), float(0.0078125), float(0.191406)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(0.363281), float(0.148438), float(1.25781)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.667969), float(1.32031), float(0.839844)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1.00781), float(0.175781), float(1.30078)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(0.0117188), float(0.0078125), float(0.191406)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(0.363281), float(0.148438), float(1.25781)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.667969), float(1.32031), float(0.839844)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1.00781), float(0.175781), float(1.30078)), 0.0);

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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(0.0117188), float(0.0078125), float(0.191406)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(0.363281), float(0.148438), float(1.25781)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.667969), float(1.32031), float(0.839844)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1.00781), float(0.175781), float(1.30078)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(0.0117188), float(0.0078125), float(0.191406)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(0.363281), float(0.148438), float(1.25781)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.667969), float(1.32031), float(0.839844)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1.00781), float(0.175781), float(1.30078)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(0.0117188), float(0.0078125), float(0.191406)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(0.363281), float(0.148438), float(1.25781)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.667969), float(1.32031), float(0.839844)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1.00781), float(0.175781), float(1.30078)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(0.0117188), float(0.0078125), float(0.191406)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(0.363281), float(0.148438), float(1.25781)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.667969), float(1.32031), float(0.839844)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1.00781), float(0.175781), float(1.30078)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(0.0117188), float(0.0078125), float(0.191406)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(0.363281), float(0.148438), float(1.25781)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.667969), float(1.32031), float(0.839844)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1.00781), float(0.175781), float(1.30078)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp sampler3D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler3D u_combinedTextureSampler1[2];
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler3D u_combinedTextureSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler3D u_combinedTextureSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler3D u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler3D u_combinedTextureSampler1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler3D u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler3D u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler3D u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp sampler3D u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(0.0234375), float(0.015625), float(0.382812)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(0.726562), float(0.296875), float(1.51562)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec3(float(-0.335938), float(1.64062), float(0.679688)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec3(float(1.01562), float(0.351562), float(1.60156)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp samplerCube u_combinedTextureSampler[2];
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
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.953125), float(-0.96875), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(-0.171875), float(-1), float(0.03125)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-1), float(0.28125), float(-0.328125)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1), float(-0.296875), float(0.234375)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp samplerCube u_combinedTextureSampler[2];
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.953125), float(-0.96875), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(-0.171875), float(-1), float(0.03125)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-1), float(0.28125), float(-0.328125)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1), float(-0.296875), float(0.234375)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp samplerCube u_combinedTextureSampler[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.953125), float(-0.96875), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(-0.171875), float(-1), float(0.03125)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-1), float(0.28125), float(-0.328125)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1), float(-0.296875), float(0.234375)), 0.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp samplerCube u_combinedTextureSampler[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.953125), float(-0.96875), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(-0.171875), float(-1), float(0.03125)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-1), float(0.28125), float(-0.328125)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1), float(-0.296875), float(0.234375)), 0.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0) uniform highp samplerCube u_combinedTextureSampler[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.953125), float(-0.96875), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(-0.171875), float(-1), float(0.03125)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-1), float(0.28125), float(-0.328125)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1), float(-0.296875), float(0.234375)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp samplerCube u_combinedTextureSampler[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.953125), float(-0.96875), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(-0.171875), float(-1), float(0.03125)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-1), float(0.28125), float(-0.328125)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1), float(-0.296875), float(0.234375)), 0.0);

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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp samplerCube u_combinedTextureSampler[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.953125), float(-0.96875), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(-0.171875), float(-1), float(0.03125)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-1), float(0.28125), float(-0.328125)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1), float(-0.296875), float(0.234375)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp samplerCube u_combinedTextureSampler[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.953125), float(-0.96875), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(-0.171875), float(-1), float(0.03125)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-1), float(0.28125), float(-0.328125)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1), float(-0.296875), float(0.234375)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.953125), float(-0.96875), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(-0.171875), float(-1), float(0.03125)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-1), float(0.28125), float(-0.328125)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1), float(-0.296875), float(0.234375)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.953125), float(-0.96875), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(-0.171875), float(-1), float(0.03125)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-1), float(0.28125), float(-0.328125)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1), float(-0.296875), float(0.234375)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.953125), float(-0.96875), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(-0.171875), float(-1), float(0.03125)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-1), float(0.28125), float(-0.328125)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1), float(-0.296875), float(0.234375)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1;
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
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(location = 1) flat out highp int frag_quadrant_id;
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
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(location = 1) flat out highp int tsc_quadrant_id;
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
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(location = 1) flat out highp int geo_quadrant_id;
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSamplerA;
layout(set = 0, binding = 2) uniform highp samplerCubeArray u_combinedTextureSamplerB;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSamplerB;
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    o_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);

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
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
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
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
