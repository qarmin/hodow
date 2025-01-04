#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = ${binding}) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
