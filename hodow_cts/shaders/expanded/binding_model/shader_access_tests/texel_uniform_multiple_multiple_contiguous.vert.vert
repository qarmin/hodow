#version 310 es
#extension GL_EXT_texture_buffer : require
layout(set = 0, binding = 0) uniform highp textureBuffer u_texelBuffer0A;
layout(set = 0, binding = 1) uniform highp textureBuffer u_texelBuffer0B;
layout(set = 1, binding = 0) uniform highp textureBuffer u_texelBuffer1A;
layout(set = 1, binding = 1) uniform highp textureBuffer u_texelBuffer1B;
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
        result_color += texelFetch(u_texelBuffer0A, 6);
    else if (quadrant_id == 1)
        result_color += texelFetch(u_texelBuffer0B, 51);
    else if (quadrant_id == 2)
        result_color += texelFetch(u_texelBuffer0A, 42);
    else
        result_color += texelFetch(u_texelBuffer0B, 25);
    if (quadrant_id == 0)
        result_color += texelFetch(u_texelBuffer1A, 6);
    else if (quadrant_id == 1)
        result_color += texelFetch(u_texelBuffer1B, 51);
    else if (quadrant_id == 2)
        result_color += texelFetch(u_texelBuffer1A, 42);
    else
        result_color += texelFetch(u_texelBuffer1B, 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
