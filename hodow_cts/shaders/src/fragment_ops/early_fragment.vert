#version 440

layout(location = 0) in highp vec4 position;

out gl_PerVertex {
   vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
