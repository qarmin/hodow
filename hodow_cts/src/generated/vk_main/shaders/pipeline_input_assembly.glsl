#version 310 es
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
layout(location = 0) out highp vec4 vtxColor;
void main (void)
{
    gl_Position = position;
    vtxColor = color;
}
#version 310 es
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vtxColor;
}
#version 310 es
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
layout(location = 0) out highp vec4 vtxColor;
void main (void)
{
    gl_Position = position;
    gl_PointSize = 3.0;
    vtxColor = color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 0) in highp vec4 vtxColorIn[];
layout(location = 0) out highp vec4 vtxColorOut[];
#define ID gl_InvocationID
void main (void)
{
    vtxColorOut[ID] = vtxColorIn[ID];
    gl_out[ID].gl_Position = gl_in[ID].gl_Position;
    if (ID == 0)
    {
        gl_TessLevelInner[0] = 5.0;
        gl_TessLevelOuter[0] = 4.0;
        gl_TessLevelOuter[1] = 5.0;
        gl_TessLevelOuter[2] = 6.0;
    }
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(location = 0) in vec4 vtxColorIn[];
layout(location = 0) out vec4 vtxColorOut;
void main (void)
{
    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;
    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;
    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;
    gl_Position = p0 + p1 + p2;
    vec4 q0 = gl_TessCoord.x * vtxColorIn[0];
    vec4 q1 = gl_TessCoord.y * vtxColorIn[1];
    vec4 q2 = gl_TessCoord.z * vtxColorIn[2];
    vtxColorOut = q0 + q1 + q2;
}
