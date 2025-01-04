#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) in  highp vec4 in_te_attr[];
layout(location = 0) out highp vec4 in_f_color;

void main (void)
{
    highp vec2 xy = gl_TessCoord.x * in_te_attr[0].xy
                  + gl_TessCoord.y * in_te_attr[1].xy
                  + gl_TessCoord.z * in_te_attr[2].xy;
    gl_Position = vec4(xy, 0.0, 1.0);
    in_f_color = vec4(in_te_attr[0].z + in_te_attr[1].w,
                      in_te_attr[2].z + in_te_attr[0].w,
                      in_te_attr[1].z + in_te_attr[2].w,
                      1.0);
}
