#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;


void main (void)
{
    highp float x = (gl_TessCoord.x*float(1) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = abs(gl_TessLevelOuter[0] - 7.0) < 0.1f;
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
