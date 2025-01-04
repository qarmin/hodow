#version 310 es

layout(location = 0) out highp vec4 color;
layout(set = 0, binding = 0) uniform UboData {
    highp float data;
} ubo;
void main()
{
    highp float c = (gl_FrontFacing ? 1.0 : -1.0) + ubo.data;
    color = vec4(c);
}
