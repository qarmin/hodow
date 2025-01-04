#version 310 es

layout(location = 0) in  highp vec4 in_v_attr;

void main (void)
{
    gl_Position = in_v_attr;
}
