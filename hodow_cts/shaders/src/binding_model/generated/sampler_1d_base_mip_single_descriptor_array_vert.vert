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
