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
