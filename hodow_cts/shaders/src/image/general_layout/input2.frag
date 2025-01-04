#version 450
layout(input_attachment_index = 0, set = 0, binding = 1) uniform subpassInput inputAttachment;
layout(location = 0) out vec4 out_color;
void main()
{
    out_color = vec4(1.0f) - subpassLoad(inputAttachment);
}
