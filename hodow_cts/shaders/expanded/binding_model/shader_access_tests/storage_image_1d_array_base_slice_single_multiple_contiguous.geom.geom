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
