#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = ${binding}) ${buffer_type} Block
{
    vec4 color;
} inputData;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = inputData.color;
}
