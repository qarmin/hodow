#version 310 es

layout(location = 0) in highp vec4 position;
void main()
{
gl_Position = position;
gl_PointSize = 1.0;
}
