#version 450
layout (input_attachment_index = 0, set = 0, binding = 0) uniform isubpassInput i_color0;
layout (input_attachment_index = 1, set = 0, binding = 1) uniform isubpassInput i_color1;
layout (input_attachment_index = 2, set = 0, binding = 2) uniform isubpassInput i_color2;
layout (input_attachment_index = 3, set = 0, binding = 3) uniform isubpassInput i_color3;
layout(location = 0) out ivec4 o_color0;
layout(location = 1) out ivec4 o_color1;
void main (void)
{
	o_color0 = subpassLoad(i_color0) / 2 + subpassLoad(i_color2) / 4;
	o_color1 = subpassLoad(i_color1) / 2 + subpassLoad(i_color3) / 4;
}
