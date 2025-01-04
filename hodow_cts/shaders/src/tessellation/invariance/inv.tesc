#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in highp float in_tc_attr[];

void main (void)
{
    gl_TessLevelInner[0] = in_tc_attr[0];
    gl_TessLevelInner[1] = in_tc_attr[1];

    gl_TessLevelOuter[0] = in_tc_attr[2];
    gl_TessLevelOuter[1] = in_tc_attr[3];
    gl_TessLevelOuter[2] = in_tc_attr[4];
    gl_TessLevelOuter[3] = in_tc_attr[5];
}
