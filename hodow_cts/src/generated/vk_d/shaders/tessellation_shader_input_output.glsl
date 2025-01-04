#version 310 es

layout(location = 0) in  highp float in_v_attr;
layout(location = 0) out highp float in_tc_attr;

void main (void)
{
    in_tc_attr = in_v_attr;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 10) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

void main (void)
{
    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID*5/10];

    gl_TessLevelInner[0] = 5.0;
    gl_TessLevelInner[1] = 5.0;

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

void main (void)
{
    highp float x = gl_TessCoord.x*2.0 - 1.0;
    highp float y = gl_TessCoord.y - in_te_attr[int(round(gl_TessCoord.x*float(10-1)))];
    gl_Position = vec4(x, y, 0.0, 1.0);
    in_f_color = vec4(1.0);
}
#version 310 es

layout(location = 0) in  mediump vec4 in_f_color;
layout(location = 0) out mediump vec4 o_color;

void main (void)
{
    o_color = in_f_color;
}
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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

void main (void)
{
    highp float x = gl_TessCoord.x*2.0 - 1.0;
    highp float y = gl_TessCoord.y - in_te_attr[int(round(gl_TessCoord.x*float(5-1)))];
    gl_Position = vec4(x, y, 0.0, 1.0);
    in_f_color = vec4(1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 5) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) patch out mediump int in_te_primitiveIDFromTCS;

void main (void)
{
    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];
    in_te_primitiveIDFromTCS = gl_PrimitiveID;

    gl_TessLevelInner[0] = 9.0;
    gl_TessLevelInner[1] = 8.0;

    gl_TessLevelOuter[0] = 7.0;
    gl_TessLevelOuter[1] = 6.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 4.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) patch in mediump int in_te_primitiveIDFromTCS;

void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = in_te_primitiveIDFromTCS == 3;
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 5) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];


void main (void)
{
    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 9.0;
    gl_TessLevelInner[1] = 8.0;

    gl_TessLevelOuter[0] = 7.0;
    gl_TessLevelOuter[1] = 6.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 4.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;


void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = gl_PrimitiveID == 3;
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 5) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) patch out mediump int in_te_patchVerticesInFromTCS;

void main (void)
{
    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];
    in_te_patchVerticesInFromTCS = gl_PatchVerticesIn;

    gl_TessLevelInner[0] = 9.0;
    gl_TessLevelInner[1] = 8.0;

    gl_TessLevelOuter[0] = 7.0;
    gl_TessLevelOuter[1] = 6.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 4.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) patch in mediump int in_te_patchVerticesInFromTCS;

void main (void)
{
    highp float x = (gl_TessCoord.x*float(1) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = in_te_patchVerticesInFromTCS == 10;
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
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
    bool ok = gl_PatchVerticesIn == 5;
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
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
    bool ok = abs(gl_TessLevelInner[0] - 9.0) < 0.1f;
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
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
    bool ok = abs(gl_TessLevelInner[1] - 8.0) < 0.1f;
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
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
    bool ok = abs(gl_TessLevelOuter[1] - 6.0) < 0.1f;
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
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
    bool ok = abs(gl_TessLevelOuter[2] - 5.0) < 0.1f;
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
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
    bool ok = abs(gl_TessLevelOuter[3] - 4.0) < 0.1f;
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
#version 310 es

layout(location = 0) in  highp vec4 in_v_attr;

void main (void)
{
    gl_Position = in_v_attr;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) out highp vec4 in_te_attr[];

void main (void)
{
    in_te_attr[gl_InvocationID] = gl_in[gl_InvocationID].gl_Position;

    gl_TessLevelInner[0] = 2.0;
    gl_TessLevelInner[1] = 3.0;

    gl_TessLevelOuter[0] = 4.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 7.0;
}
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
#version 310 es

layout(location = 0) in  highp   vec4 in_f_color;
layout(location = 0) out mediump vec4 o_color;

void main (void)
{
    o_color = in_f_color;
}
#version 310 es

layout(location = 0) in  highp vec4 in_v_attr;
layout(location = 0) out highp vec4 in_tc_attr;

void main (void)
{
    in_tc_attr = in_v_attr;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp vec4 in_tc_attr[];

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 2.0;
    gl_TessLevelInner[1] = 3.0;

    gl_TessLevelOuter[0] = 4.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 7.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) out highp vec4 in_f_color;

void main (void)
{
    highp vec2 xy = gl_TessCoord.x * gl_in[0].gl_Position.xy
                  + gl_TessCoord.y * gl_in[1].gl_Position.xy
                  + gl_TessCoord.z * gl_in[2].gl_Position.xy;
    gl_Position = vec4(xy, 0.0, 1.0);
    in_f_color = vec4(gl_in[0].gl_Position.z + gl_in[1].gl_Position.w,
                      gl_in[2].gl_Position.z + gl_in[0].gl_Position.w,
                      gl_in[1].gl_Position.z + gl_in[2].gl_Position.w,
                      1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;


void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    gl_TessLevelInner[0] = 2.0;
    gl_TessLevelInner[1] = 3.0;

    gl_TessLevelOuter[0] = 4.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 7.0;
}
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
#version 310 es

layout(location = 0) in  highp   float in_f_blue;
layout(location = 0) out mediump vec4  o_color;

void main (void)
{
    o_color = vec4(1.0, 0.0, in_f_blue, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) out mediump int in_te_data0[];
layout(location = 2) out mediump int in_te_data1[];

void main (void)
{
    int d = int(gl_InvocationID);
    in_te_data0[gl_InvocationID] = d;
    barrier();
    in_te_data1[gl_InvocationID] = d + in_te_data0[(gl_InvocationID + 1) % 3];

    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) in mediump int in_te_data0[];
layout(location = 2) in mediump int in_te_data1[];

void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = true;
    for (int i = 0; i < 3; i++)
    {
         int ref = i + (i + 1) % 3;
         if (in_te_data1[i] != int(ref)) ok = false;
    }
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) out mediump uint in_te_data0[];
layout(location = 2) out mediump uint in_te_data1[];

void main (void)
{
    uint d = uint(gl_InvocationID);
    in_te_data0[gl_InvocationID] = d;
    barrier();
    in_te_data1[gl_InvocationID] = d + in_te_data0[(gl_InvocationID + 1) % 3];

    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) in mediump uint in_te_data0[];
layout(location = 2) in mediump uint in_te_data1[];

void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = true;
    for (int i = 0; i < 3; i++)
    {
         int ref = i + (i + 1) % 3;
         if (in_te_data1[i] != uint(ref)) ok = false;
    }
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) out mediump float in_te_data0[];
layout(location = 2) out mediump float in_te_data1[];

void main (void)
{
    float d = float(gl_InvocationID);
    in_te_data0[gl_InvocationID] = d;
    barrier();
    in_te_data1[gl_InvocationID] = d + in_te_data0[(gl_InvocationID + 1) % 3];

    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) in mediump float in_te_data0[];
layout(location = 2) in mediump float in_te_data1[];

void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = true;
    for (int i = 0; i < 3; i++)
    {
         int ref = i + (i + 1) % 3;
         if (in_te_data1[i] != float(ref)) ok = false;
    }
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) out mediump vec3 in_te_data0[];
layout(location = 2) out mediump vec3 in_te_data1[];

void main (void)
{
    vec3 d = vec3(gl_InvocationID);
    in_te_data0[gl_InvocationID] = d;
    barrier();
    in_te_data1[gl_InvocationID] = d + in_te_data0[(gl_InvocationID + 1) % 3];

    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) in mediump vec3 in_te_data0[];
layout(location = 2) in mediump vec3 in_te_data1[];

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) out mediump vec4 in_te_data0[];
layout(location = 2) out mediump vec4 in_te_data1[];

void main (void)
{
    vec4 d = vec4(gl_InvocationID);
    in_te_data0[gl_InvocationID] = d;
    barrier();
    in_te_data1[gl_InvocationID] = d + in_te_data0[(gl_InvocationID + 1) % 3];

    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) in mediump vec4 in_te_data0[];
layout(location = 2) in mediump vec4 in_te_data1[];

void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = true;
    for (int i = 0; i < 3; i++)
    {
         int ref = i + (i + 1) % 3;
         if (in_te_data1[i] != vec4(ref)) ok = false;
    }
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) out mediump mat4x3 in_te_data0[];
layout(location = 5) out mediump mat4x3 in_te_data1[];

void main (void)
{
    mat4x3 d = mat4x3(gl_InvocationID);
    in_te_data0[gl_InvocationID] = d;
    barrier();
    in_te_data1[gl_InvocationID] = d + in_te_data0[(gl_InvocationID + 1) % 3];

    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) in mediump mat4x3 in_te_data0[];
layout(location = 5) in mediump mat4x3 in_te_data1[];

void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = true;
    for (int i = 0; i < 3; i++)
    {
         int ref = i + (i + 1) % 3;
         if (in_te_data1[i] != mat4x3(ref)) ok = false;
    }
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) patch out mediump int in_te_data0[3];
layout(location = 4) patch out mediump int in_te_data1[3];

void main (void)
{
    int d = int(gl_InvocationID);
    in_te_data0[gl_InvocationID] = d;
    barrier();
    in_te_data1[gl_InvocationID] = d + in_te_data0[(gl_InvocationID + 1) % 3];

    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) patch in mediump int in_te_data0[3];
layout(location = 4) patch in mediump int in_te_data1[3];

void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = true;
    for (int i = 0; i < 3; i++)
    {
         int ref = i + (i + 1) % 3;
         if (in_te_data1[i] != int(ref)) ok = false;
    }
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) patch out mediump uint in_te_data0[3];
layout(location = 4) patch out mediump uint in_te_data1[3];

void main (void)
{
    uint d = uint(gl_InvocationID);
    in_te_data0[gl_InvocationID] = d;
    barrier();
    in_te_data1[gl_InvocationID] = d + in_te_data0[(gl_InvocationID + 1) % 3];

    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) patch in mediump uint in_te_data0[3];
layout(location = 4) patch in mediump uint in_te_data1[3];

void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = true;
    for (int i = 0; i < 3; i++)
    {
         int ref = i + (i + 1) % 3;
         if (in_te_data1[i] != uint(ref)) ok = false;
    }
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) patch out mediump float in_te_data0[3];
layout(location = 4) patch out mediump float in_te_data1[3];

void main (void)
{
    float d = float(gl_InvocationID);
    in_te_data0[gl_InvocationID] = d;
    barrier();
    in_te_data1[gl_InvocationID] = d + in_te_data0[(gl_InvocationID + 1) % 3];

    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) patch in mediump float in_te_data0[3];
layout(location = 4) patch in mediump float in_te_data1[3];

void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = true;
    for (int i = 0; i < 3; i++)
    {
         int ref = i + (i + 1) % 3;
         if (in_te_data1[i] != float(ref)) ok = false;
    }
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) patch out mediump vec3 in_te_data0[3];
layout(location = 4) patch out mediump vec3 in_te_data1[3];

void main (void)
{
    vec3 d = vec3(gl_InvocationID);
    in_te_data0[gl_InvocationID] = d;
    barrier();
    in_te_data1[gl_InvocationID] = d + in_te_data0[(gl_InvocationID + 1) % 3];

    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) patch out mediump vec4 in_te_data0[3];
layout(location = 4) patch out mediump vec4 in_te_data1[3];

void main (void)
{
    vec4 d = vec4(gl_InvocationID);
    in_te_data0[gl_InvocationID] = d;
    barrier();
    in_te_data1[gl_InvocationID] = d + in_te_data0[(gl_InvocationID + 1) % 3];

    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) patch in mediump vec4 in_te_data0[3];
layout(location = 4) patch in mediump vec4 in_te_data1[3];

void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = true;
    for (int i = 0; i < 3; i++)
    {
         int ref = i + (i + 1) % 3;
         if (in_te_data1[i] != vec4(ref)) ok = false;
    }
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in  highp float in_tc_attr[];
layout(location = 0) out highp float in_te_attr[];

layout(location = 1) patch out mediump mat4x3 in_te_data0[3];
layout(location = 13) patch out mediump mat4x3 in_te_data1[3];

void main (void)
{
    mat4x3 d = mat4x3(gl_InvocationID);
    in_te_data0[gl_InvocationID] = d;
    barrier();
    in_te_data1[gl_InvocationID] = d + in_te_data0[(gl_InvocationID + 1) % 3];

    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) in  highp   float in_te_attr[];
layout(location = 0) out mediump vec4  in_f_color;

layout(location = 1) patch in mediump mat4x3 in_te_data0[3];
layout(location = 13) patch in mediump mat4x3 in_te_data1[3];

void main (void)
{
    highp float x = (gl_TessCoord.x*float(0.125) + in_te_attr[0]) * 2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    bool ok = true;
    for (int i = 0; i < 3; i++)
    {
         int ref = i + (i + 1) % 3;
         if (in_te_data1[i] != mat4x3(ref)) ok = false;
    }
    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);
}
