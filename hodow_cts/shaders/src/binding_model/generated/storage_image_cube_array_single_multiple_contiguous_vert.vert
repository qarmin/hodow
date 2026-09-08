#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_imageB;
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
        result_color += imageLoad(u_imageB, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 6));
    frag_color = result_color;
}
