#version 450
layout (location = 0) in vec2 texCoord;
#if ${input_attachment} == 1
layout(input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput inputAttachment;
#else
layout(set = 0, binding = 0) uniform sampler2D image;
#endif
layout(location = 0) out vec4 out_color;
void main()
{
#if ${input_attachment} == 1
    out_color = subpassLoad(inputAttachment) / 2.0f;
#else
    out_color = texture(image, texCoord) / 2.0f;
#endif
}
