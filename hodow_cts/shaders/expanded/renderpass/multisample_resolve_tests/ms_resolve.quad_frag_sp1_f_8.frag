#version 450
layout (input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput i_color0;
layout (input_attachment_index = 1, set = 0, binding = 1) uniform subpassInput i_color1;
layout (input_attachment_index = 2, set = 0, binding = 2) uniform subpassInput i_color2;
layout (input_attachment_index = 3, set = 0, binding = 3) uniform subpassInput i_color3;
layout (input_attachment_index = 4, set = 0, binding = 4) uniform subpassInput i_color4;
layout (input_attachment_index = 5, set = 0, binding = 5) uniform subpassInput i_color5;
layout (input_attachment_index = 6, set = 0, binding = 6) uniform subpassInput i_color6;
layout (input_attachment_index = 7, set = 0, binding = 7) uniform subpassInput i_color7;
layout(location = 0) out vec4 o_color0;
layout(location = 1) out vec4 o_color1;
layout(location = 2) out vec4 o_color2;
layout(location = 3) out vec4 o_color3;
void main (void)
{
	o_color0 = subpassLoad(i_color0)*0.5 + subpassLoad(i_color4)*0.25;
	o_color1 = subpassLoad(i_color1)*0.5 + subpassLoad(i_color5)*0.25;
	o_color2 = subpassLoad(i_color2)*0.5 + subpassLoad(i_color6)*0.25;
	o_color3 = subpassLoad(i_color3)*0.5 + subpassLoad(i_color7)*0.25;
}
