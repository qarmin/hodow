#version 450
layout(location = 0) in highp vec4 position;
void main (void)
{
    gl_Position = position;
}
#version 450
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vec4(0.1, 0.2, 0.0, 1.0);
}
#version 450
layout(set = 0, binding = 0, input_attachment_index = 0) uniform subpassInput inputAtt;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    vec4 inputColor = subpassLoad(inputAtt);
    fragColor = inputColor + vec4(0.1, 0.2, 0.0, 0.0);
}
#version 450
layout(set = 0, binding = 0) uniform highp sampler2D tex;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    vec2 uv = vec2(gl_FragCoord) / 255.0;
    vec4 inputColor = texture(tex, uv);
    fragColor = inputColor + vec4(0.1, 0.2, 0.0, 0.0);
}
#version 450
layout(set = 0, binding = 0, input_attachment_index = 0) uniform subpassInput inputAtt;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    vec4 inputColor = subpassLoad(inputAtt);
    fragColor = vec4(1, 1, inputColor.r + inputColor.g, 1);
}
#version 450
highp float;
layout(location = 0) in highp vec4 position;
void main (void)
{
    gl_Position = position;
}
#version 450
void main (void)
{
}
#version 450
highp float;
void main (void)
{
    vec4 position;    position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -1.0 : 1.0,
                    ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 1.0, 0.0, 1.0);
    gl_Position = position;
}
#version 450
layout (input_attachment_index = 0, binding = 0) uniform subpassInput depthStencil;
void main (void)
{
    float inputDepth = subpassLoad(depthStencil).x;
    gl_FragDepth = inputDepth - 0.02;
}
#version 450
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vec4(1);
}
