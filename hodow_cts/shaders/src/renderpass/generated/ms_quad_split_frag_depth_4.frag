#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp subpassInputMS i_depth;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp float o_color0;
layout(location = 1) out highp float o_color1;
layout(location = 2) out highp float o_color2;
layout(location = 3) out highp float o_color3;
void main (void)
{
	highp float depth0 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 0u)).x;
	o_color0 = float(depth0);
	highp float depth1 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 1u)).x;
	o_color1 = float(depth1);
	highp float depth2 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 2u)).x;
	o_color2 = float(depth2);
	highp float depth3 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 3u)).x;
	o_color3 = float(depth3);
}
