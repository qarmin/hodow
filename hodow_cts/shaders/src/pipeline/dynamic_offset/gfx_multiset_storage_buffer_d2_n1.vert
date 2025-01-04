#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) readonly buffer Block0
{
    vec4 color;
} inputData0;
layout(set = 1, binding = 0) readonly buffer Block1
{
    vec4 color;
} inputData1;
layout(set = 2, binding = 0) readonly buffer Block2
{
    vec4 color;
} inputData2;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputData0.color.rgb;
    vtxColor.rgb += inputData1.color.rgb;
    vtxColor.rgb += inputData2.color.rgb;
}
