#version 440

layout(location = 0) in highp vec4 position;
layout(location = 0) out highp vec4 vsColor;

out gl_PerVertex {
   vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
    vsColor     = vec4(gl_Position.z * 5.0f, 1.0f, 0.0f, 1.0f);
}
#version 440

layout(location = 0) in highp vec4 vsColor;
layout(location = 0) out highp vec4 fsColor0;
layout(location = 1) out highp vec4 fsColor1;
layout(location = 2) out highp vec4 fsColor2;
layout(location = 3) out highp vec4 fsColor3;

void main (void)
{
    vec4 color   = vsColor;
    color.z      = 0.15f * 0.0f;
    fsColor0     = color;
    color.z      = 0.15f * 1.0f;
    fsColor1     = color;
    color.z      = 0.15f * 2.0f;
    fsColor2     = color;
    color.z      = 0.15f * 3.0f;
    fsColor3     = color;
}
