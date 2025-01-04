#version 450
layout (input_attachment_index = 0, set = 0, binding = 0) uniform usubpassInput i_color0;
layout (input_attachment_index = 1, set = 0, binding = 1) uniform usubpassInput i_color1;
layout (input_attachment_index = 2, set = 0, binding = 2) uniform usubpassInput i_color2;
layout (input_attachment_index = 3, set = 0, binding = 3) uniform usubpassInput i_color3;
layout (input_attachment_index = 4, set = 0, binding = 4) uniform usubpassInput i_color4;
layout (input_attachment_index = 5, set = 0, binding = 5) uniform usubpassInput i_color5;
layout (input_attachment_index = 6, set = 0, binding = 6) uniform usubpassInput i_color6;
layout (input_attachment_index = 7, set = 0, binding = 7) uniform usubpassInput i_color7;
layout (input_attachment_index = 8, set = 0, binding = 8) uniform usubpassInput i_color8;
layout (input_attachment_index = 9, set = 0, binding = 9) uniform usubpassInput i_color9;
layout (input_attachment_index = 10, set = 0, binding = 10) uniform usubpassInput i_color10;
layout (input_attachment_index = 11, set = 0, binding = 11) uniform usubpassInput i_color11;
layout (input_attachment_index = 12, set = 0, binding = 12) uniform usubpassInput i_color12;
layout (input_attachment_index = 13, set = 0, binding = 13) uniform usubpassInput i_color13;
layout (input_attachment_index = 14, set = 0, binding = 14) uniform usubpassInput i_color14;
layout (input_attachment_index = 15, set = 0, binding = 15) uniform usubpassInput i_color15;
layout(location = 0) out uvec4 o_color0;
layout(location = 1) out uvec4 o_color1;
layout(location = 2) out uvec4 o_color2;
layout(location = 3) out uvec4 o_color3;
layout(location = 4) out uvec4 o_color4;
layout(location = 5) out uvec4 o_color5;
layout(location = 6) out uvec4 o_color6;
layout(location = 7) out uvec4 o_color7;
void main (void)
{
	o_color0 = subpassLoad(i_color0) / 2 + subpassLoad(i_color8) / 4;
	o_color1 = subpassLoad(i_color1) / 2 + subpassLoad(i_color9) / 4;
	o_color2 = subpassLoad(i_color2) / 2 + subpassLoad(i_color10) / 4;
	o_color3 = subpassLoad(i_color3) / 2 + subpassLoad(i_color11) / 4;
	o_color4 = subpassLoad(i_color4) / 2 + subpassLoad(i_color12) / 4;
	o_color5 = subpassLoad(i_color5) / 2 + subpassLoad(i_color13) / 4;
	o_color6 = subpassLoad(i_color6) / 2 + subpassLoad(i_color14) / 4;
	o_color7 = subpassLoad(i_color7) / 2 + subpassLoad(i_color15) / 4;
}
