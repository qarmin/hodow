#version 450

layout(input_attachment_index = 0, binding = 0) uniform ${input_type} inputValue;

layout(location = 0) out vec4 fragColor;

void main (void)
{
    fragColor = ${load_expr};
}
