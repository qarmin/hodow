#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in       highp float in_te_attr[];
layout(location = 1) patch in highp float in_te_patchAttr;

layout(location = 0) out highp float in_f_blue;

void main (void)
{
    highp float x = gl_TessCoord.x*2.0 - 1.0;
    highp float y = gl_TessCoord.y - in_te_attr[int(round(gl_TessCoord.x*float(32-1)))];
    gl_Position = vec4(x, y, 0.0, 1.0);
    in_f_blue = abs(in_te_patchAttr - float(32-1));
}
