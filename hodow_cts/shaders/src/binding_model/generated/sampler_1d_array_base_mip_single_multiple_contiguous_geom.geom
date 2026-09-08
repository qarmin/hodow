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
