#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp sampler2DArray u_combinedTextureSampler1;
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
        result_color += textureLod(u_combinedTextureSampler0, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec3(float(0.0117188), float(0.0078125), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec3(float(0.363281), float(0.148438), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec3(float(-0.667969), float(1.32031), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec3(float(1.00781), float(0.175781), float(0)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
