#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler2D u_combinedTextureSampler0B;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1A;
layout(set = 2, binding = 1) uniform highp sampler2D u_combinedTextureSampler1B;
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
