#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 5) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

void main (void)
{
    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID*10/5];

    gl_TessLevelInner[0] = 5.0;
    gl_TessLevelInner[1] = 5.0;

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
