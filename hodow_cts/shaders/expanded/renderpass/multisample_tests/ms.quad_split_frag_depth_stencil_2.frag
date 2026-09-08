#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp subpassInputMS i_depth;
layout(input_attachment_index = 0, set = 0, binding = 1) uniform highp usubpassInputMS i_stencil;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp vec2 o_color0;
layout(location = 1) out highp vec2 o_color1;
void main (void)
{
	highp float depth0 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 0u)).x;
	highp uint stencil0 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 0u)).x;
	o_color0 = vec2(depth0, float(stencil0));
	highp float depth1 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 1u)).x;
	highp uint stencil1 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 1u)).x;
	o_color1 = vec2(depth1, float(stencil1));
}
