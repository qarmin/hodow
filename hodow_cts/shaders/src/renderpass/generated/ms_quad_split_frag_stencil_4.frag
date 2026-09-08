#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_stencil;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp float o_color0;
layout(location = 1) out highp float o_color1;
layout(location = 2) out highp float o_color2;
layout(location = 3) out highp float o_color3;
void main (void)
{
	highp uint stencil0 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 0u)).x;
	o_color0 = float(stencil0);
	highp uint stencil1 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 1u)).x;
	o_color1 = float(stencil1);
	highp uint stencil2 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 2u)).x;
	o_color2 = float(stencil2);
	highp uint stencil3 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 3u)).x;
	o_color3 = float(stencil3);
}
