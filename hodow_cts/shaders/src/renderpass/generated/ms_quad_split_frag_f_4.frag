#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp subpassInputMS i_color;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void)
{
	o_color0 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 0u));
	o_color1 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 1u));
	o_color2 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 2u));
	o_color3 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 3u));
}
