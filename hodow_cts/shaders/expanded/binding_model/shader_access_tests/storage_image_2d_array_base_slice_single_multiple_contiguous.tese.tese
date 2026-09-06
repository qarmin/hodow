#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp image2DArray u_imageB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 0));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 0));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
