#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1D u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image1D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1D u_image1B;
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
        result_color += imageLoad(u_image0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, 42);
    else
        result_color += imageLoad(u_image0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, 42);
    else
        result_color += imageLoad(u_image1B, 25);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1D u_image1B;
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
        result_color += imageLoad(u_image0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, 42);
    else
        result_color += imageLoad(u_image0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, 42);
    else
        result_color += imageLoad(u_image1B, 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1D u_image1B;
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
        result_color += imageLoad(u_image0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, 42);
    else
        result_color += imageLoad(u_image0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, 42);
    else
        result_color += imageLoad(u_image1B, 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1D u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, 42);
    else
        result_color += imageLoad(u_image0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, 42);
    else
        result_color += imageLoad(u_image1B, 25);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1D u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, 42);
    else
        result_color += imageLoad(u_image0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, 42);
    else
        result_color += imageLoad(u_image1B, 25);
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1D u_image1B;
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
        result_color += imageLoad(u_image0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, 42);
    else
        result_color += imageLoad(u_image0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, 42);
    else
        result_color += imageLoad(u_image1B, 25);
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1D u_image1B;
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
        result_color += imageLoad(u_image0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, 42);
    else
        result_color += imageLoad(u_image0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, 42);
    else
        result_color += imageLoad(u_image1B, 25);
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1D u_image1B;
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
        result_color += imageLoad(u_image0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, 42);
    else
        result_color += imageLoad(u_image0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, 42);
    else
        result_color += imageLoad(u_image1B, 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, 42);
    else
        result_color += imageLoad(u_image0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, 42);
    else
        result_color += imageLoad(u_image1B, 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, 42);
    else
        result_color += imageLoad(u_image0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, 42);
    else
        result_color += imageLoad(u_image1B, 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, 42);
    else
        result_color += imageLoad(u_image0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, 42);
    else
        result_color += imageLoad(u_image1B, 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1D u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1[2];
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
        result_color += imageLoad(u_image0[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], 42);
    else
        result_color += imageLoad(u_image0[1], 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], 42);
    else
        result_color += imageLoad(u_image1[1], 25);
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1[2];
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
        result_color += imageLoad(u_image0[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], 42);
    else
        result_color += imageLoad(u_image0[1], 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], 42);
    else
        result_color += imageLoad(u_image1[1], 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1[2];
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
        result_color += imageLoad(u_image0[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], 42);
    else
        result_color += imageLoad(u_image0[1], 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], 42);
    else
        result_color += imageLoad(u_image1[1], 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], 42);
    else
        result_color += imageLoad(u_image0[1], 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], 42);
    else
        result_color += imageLoad(u_image1[1], 25);
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], 42);
    else
        result_color += imageLoad(u_image0[1], 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], 42);
    else
        result_color += imageLoad(u_image1[1], 25);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1[2];
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
        result_color += imageLoad(u_image0[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], 42);
    else
        result_color += imageLoad(u_image0[1], 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], 42);
    else
        result_color += imageLoad(u_image1[1], 25);
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1[2];
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
        result_color += imageLoad(u_image0[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], 42);
    else
        result_color += imageLoad(u_image0[1], 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], 42);
    else
        result_color += imageLoad(u_image1[1], 25);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1[2];
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
        result_color += imageLoad(u_image0[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], 42);
    else
        result_color += imageLoad(u_image0[1], 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], 42);
    else
        result_color += imageLoad(u_image1[1], 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], 42);
    else
        result_color += imageLoad(u_image0[1], 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], 42);
    else
        result_color += imageLoad(u_image1[1], 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], 42);
    else
        result_color += imageLoad(u_image0[1], 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], 42);
    else
        result_color += imageLoad(u_image1[1], 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], 42);
    else
        result_color += imageLoad(u_image0[1], 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], 42);
    else
        result_color += imageLoad(u_image1[1], 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1D u_image;
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
        result_color += imageLoad(u_image, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, 10);
    else
        result_color += imageLoad(u_image, 25);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image;
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
        result_color += imageLoad(u_image, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, 10);
    else
        result_color += imageLoad(u_image, 25);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image;
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
        result_color += imageLoad(u_image, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, 10);
    else
        result_color += imageLoad(u_image, 25);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, 10);
    else
        result_color += imageLoad(u_image, 25);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, 10);
    else
        result_color += imageLoad(u_image, 25);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image;
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
        result_color += imageLoad(u_image, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, 10);
    else
        result_color += imageLoad(u_image, 25);

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image;
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
        result_color += imageLoad(u_image, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, 10);
    else
        result_color += imageLoad(u_image, 25);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image;
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
        result_color += imageLoad(u_image, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, 10);
    else
        result_color += imageLoad(u_image, 25);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, 10);
    else
        result_color += imageLoad(u_image, 25);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, 10);
    else
        result_color += imageLoad(u_image, 25);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, 10);
    else
        result_color += imageLoad(u_image, 25);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1D u_image[2];
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
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 10);
    else
        result_color += imageLoad(u_image[1], 25);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
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
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 10);
    else
        result_color += imageLoad(u_image[1], 25);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
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
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 10);
    else
        result_color += imageLoad(u_image[1], 25);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 10);
    else
        result_color += imageLoad(u_image[1], 25);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 10);
    else
        result_color += imageLoad(u_image[1], 25);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
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
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 10);
    else
        result_color += imageLoad(u_image[1], 25);

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
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
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 10);
    else
        result_color += imageLoad(u_image[1], 25);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
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
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 10);
    else
        result_color += imageLoad(u_image[1], 25);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 10);
    else
        result_color += imageLoad(u_image[1], 25);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 10);
    else
        result_color += imageLoad(u_image[1], 25);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 10);
    else
        result_color += imageLoad(u_image[1], 25);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1D u_image[2];
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
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 42);
    else
        result_color += imageLoad(u_image[1], 25);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
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
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 42);
    else
        result_color += imageLoad(u_image[1], 25);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
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
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 42);
    else
        result_color += imageLoad(u_image[1], 25);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 42);
    else
        result_color += imageLoad(u_image[1], 25);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 42);
    else
        result_color += imageLoad(u_image[1], 25);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
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
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 42);
    else
        result_color += imageLoad(u_image[1], 25);

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
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
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 42);
    else
        result_color += imageLoad(u_image[1], 25);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
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
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 42);
    else
        result_color += imageLoad(u_image[1], 25);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 42);
    else
        result_color += imageLoad(u_image[1], 25);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 42);
    else
        result_color += imageLoad(u_image[1], 25);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 42);
    else
        result_color += imageLoad(u_image[1], 25);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image;
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
        result_color += imageLoad(u_image, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec2(42, 0));
    else
        result_color += imageLoad(u_image, ivec2(25, 1));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image;
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
        result_color += imageLoad(u_image, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec2(42, 0));
    else
        result_color += imageLoad(u_image, ivec2(25, 1));
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image;
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
        result_color += imageLoad(u_image, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec2(42, 0));
    else
        result_color += imageLoad(u_image, ivec2(25, 1));
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec2(42, 0));
    else
        result_color += imageLoad(u_image, ivec2(25, 1));
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec2(42, 0));
    else
        result_color += imageLoad(u_image, ivec2(25, 1));
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image;
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
        result_color += imageLoad(u_image, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec2(42, 0));
    else
        result_color += imageLoad(u_image, ivec2(25, 1));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image;
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
        result_color += imageLoad(u_image, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec2(42, 0));
    else
        result_color += imageLoad(u_image, ivec2(25, 1));

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image;
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
        result_color += imageLoad(u_image, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec2(42, 0));
    else
        result_color += imageLoad(u_image, ivec2(25, 1));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec2(42, 0));
    else
        result_color += imageLoad(u_image, ivec2(25, 1));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec2(42, 0));
    else
        result_color += imageLoad(u_image, ivec2(25, 1));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec2(42, 0));
    else
        result_color += imageLoad(u_image, ivec2(25, 1));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1;
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
        result_color += imageLoad(u_image0, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1, ivec2(25, 1));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1;
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
        result_color += imageLoad(u_image0, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1;
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
        result_color += imageLoad(u_image0, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1, ivec2(25, 1));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1, ivec2(25, 1));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1;
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
        result_color += imageLoad(u_image0, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1, ivec2(25, 1));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1;
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
        result_color += imageLoad(u_image0, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1, ivec2(25, 1));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1;
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
        result_color += imageLoad(u_image0, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 1));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 1));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image1DArray u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 0));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 0));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 0));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 0));
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 0));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 0));
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_imageB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 0));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 0));
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_imageB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 0));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 0));
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 0));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 0));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 0));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 0));

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 0));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 0));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 0));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 0));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 0));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 0));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 0));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 0));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 440
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 0));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 0));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 0));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 0));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 0));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image1DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image1DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 0));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 3, rgba8) readonly uniform highp image2D u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(42, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1;
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
        result_color += imageLoad(u_image0, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1, ivec2(25, 25));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1;
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
        result_color += imageLoad(u_image0, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1;
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
        result_color += imageLoad(u_image0, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1, ivec2(25, 25));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1, ivec2(25, 25));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1, ivec2(25, 25));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1, ivec2(25, 25));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 3, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 2, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 2, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 2, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 2, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 2, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 2, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 2, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 2, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
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
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 3, rgba8) readonly uniform highp image2D u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
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
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_imageB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec2(10, 26));
    else
        result_color += imageLoad(u_imageB, ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
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
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 32766, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 65534, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 32766, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 65534, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(10, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 26));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 26));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 25));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image[2];
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
        result_color += imageLoad(u_image[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 26));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 25));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 26));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 25));
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 26));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 25));
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 26));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 25));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 26));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 25));

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 26));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 26));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 26));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec2(42, 26));
    else
        result_color += imageLoad(u_image[1], ivec2(25, 25));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 1, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2DArray u_imageB;
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
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
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
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
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
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2DArray u_imageB;
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
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(19, 8, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(10, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
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
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(19, 8, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(10, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
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
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(19, 8, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(10, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(19, 8, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(10, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(19, 8, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(10, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(19, 8, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(10, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(19, 8, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(10, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(19, 8, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(10, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(19, 8, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(10, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(19, 8, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(10, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(19, 8, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(10, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1;
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
        result_color += imageLoad(u_image0, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1;
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
        result_color += imageLoad(u_image0, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1;
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
        result_color += imageLoad(u_image0, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 0));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 0));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image2DArray u_image1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 0));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image3D u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image3D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image3D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image3D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 18));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 18));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image3D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image3D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image3D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image3D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 18));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 18));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image3D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image3D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image3D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image3D u_image1B;
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
        result_color += imageLoad(u_image0A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 18));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 18));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image3D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image3D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image3D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image3D u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 18));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 18));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image3D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image3D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image3D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image3D u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 18));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 18));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image3D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image3D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image3D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image3D u_image1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 18));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 18));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp image3D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image3D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image3D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image3D u_image1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 18));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 18));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image3D u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image3D u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image3D u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp image3D u_image1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 18));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 18));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 18));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 18));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 18));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 18));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 18));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 18));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCube u_image[2];
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
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 0));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCube u_image[2];
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
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 0));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCube u_image[2];
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
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 0));
    frag_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCube u_image[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 0));
    o_color = result_color;
}
#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCube u_image[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 0));
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCube u_image[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 0));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCube u_image[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 0));

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCube u_image[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp imageCubeArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image1B;
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
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 6));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 6));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image1B;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 6));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
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
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
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
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
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
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1;
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
        result_color += imageLoad(u_image0, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1;
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
        result_color += imageLoad(u_image0, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1;
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
        result_color += imageLoad(u_image0, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 6));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 6));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 6));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
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
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
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
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
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
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    o_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
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
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image0[1], ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image1[1], ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image;
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
        result_color += imageLoad(u_image, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image, ivec3(25, 25, 0));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image;
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
        result_color += imageLoad(u_image, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image, ivec3(25, 25, 0));
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image;
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
        result_color += imageLoad(u_image, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image, ivec3(25, 25, 0));
    frag_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image, ivec3(25, 25, 0));
    o_color = result_color;
}
#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image, ivec3(25, 25, 0));
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image, ivec3(25, 25, 0));

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
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image, ivec3(25, 25, 0));

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image, ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image, ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image, ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image, ivec3(25, 25, 0));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
