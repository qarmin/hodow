#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture2D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 2, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 2, binding = 1) uniform highp texture2D u_separateTexture1;
layout(set = 2, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0A), vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0B), vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0A), vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(sampler2D(u_separateTexture0, u_separateSampler0B), vec2(float(1.01562), float(0.351562)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1A), vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1B), vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1A), vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(sampler2D(u_separateTexture1, u_separateSampler1B), vec2(float(1.01562), float(0.351562)), 0.0);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
