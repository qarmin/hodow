#version 450
layout(set = 0, binding = 0, input_attachment_index = 0) uniform subpassInput inputAtt;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    vec4 inputColor = subpassLoad(inputAtt);
    fragColor = inputColor + vec4(0.1, 0.2, 0.0, 0.0);
}
