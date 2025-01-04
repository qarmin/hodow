#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 32) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) patch out highp float in_te_patchAttr;

void main (void)
{
    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];
    in_te_patchAttr = 0.0f;

    barrier();

    if (gl_InvocationID == 5)
        in_te_patchAttr = float(gl_InvocationID)*0.1;

    barrier();

    highp float temp = in_te_patchAttr + in_te_attr[gl_InvocationID];

    barrier();

    if (gl_InvocationID == 32-1)
        in_te_patchAttr = float(gl_InvocationID);

    barrier();

    in_te_attr[gl_InvocationID] = temp;

    barrier();

    temp = temp + in_te_attr[(gl_InvocationID+1) % 32];

    barrier();

    in_te_attr[gl_InvocationID] = 0.25*temp;

    gl_TessLevelInner[0] = 32.0;
    gl_TessLevelInner[1] = 32.0;

    gl_TessLevelOuter[0] = 32.0;
    gl_TessLevelOuter[1] = 32.0;
    gl_TessLevelOuter[2] = 32.0;
    gl_TessLevelOuter[3] = 32.0;
}
