#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) patch in mediump vec3 in_te_data0[3];
layout(location = 4) patch in mediump vec3 in_te_data1[3];

void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = true;
    for (int i = 0; i < 3; i++)
    {
         int ref = i + (i + 1) % 3;
         if (in_te_data1[i] != vec3(ref)) ok = false;
    }
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
