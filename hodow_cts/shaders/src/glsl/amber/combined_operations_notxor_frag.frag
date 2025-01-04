#version 450
layout(push_constant, std430) uniform PushConstants {
	uint op1;
	uint op2;
} pushConstants;
layout(location=0) out vec4 out_color;
void main()
{
	out_color = vec4(~(pushConstants.op1^pushConstants.op2));
}
