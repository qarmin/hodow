#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputDataDyn[1];
layout(set = 1, binding = 0) uniform Block1
{
    vec4 color;
} inputDataNonDyn[1];

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputDataDyn[0].color.rgb;
    vtxColor.rgb += inputDataNonDyn[0].color.rgb;
}
