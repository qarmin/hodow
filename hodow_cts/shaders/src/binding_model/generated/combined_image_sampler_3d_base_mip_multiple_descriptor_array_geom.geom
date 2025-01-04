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
