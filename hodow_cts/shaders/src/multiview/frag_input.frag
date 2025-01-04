#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput in_color_attachment;
void main()
{
    out_color = vec4(subpassLoad(in_color_attachment));
}
