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
