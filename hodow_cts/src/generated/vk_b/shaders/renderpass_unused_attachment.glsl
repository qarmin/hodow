#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
void main (void)
{
    gl_Position = position;
    vtxColor = color;
}
#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vtxColor;
}
#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput inputColor;void main (void)
{
    fragColor = subpassLoad(inputColor) + vtxColor;
}
