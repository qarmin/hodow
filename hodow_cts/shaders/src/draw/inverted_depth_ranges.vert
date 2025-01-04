#version 450

layout(location = 0) in highp vec4 in_position;

out gl_PerVertex {
    highp vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
}
