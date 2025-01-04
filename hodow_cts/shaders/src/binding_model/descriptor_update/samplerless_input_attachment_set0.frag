#version 450
layout(input_attachment_index=0, set=0, binding=0) uniform subpassInput img;
layout(location = 0) out vec4 color_out;
void main()
{
    color_out = subpassLoad(img);
}
