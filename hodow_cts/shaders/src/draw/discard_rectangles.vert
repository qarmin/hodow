#version 440

layout(location = 0) in highp vec4 position;
layout(location = 0) out highp vec4 vsColor;

out gl_PerVertex {
   vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
    vsColor     = vec4(0.0f, 1.0f, 0.0f, 1.0f);
}
