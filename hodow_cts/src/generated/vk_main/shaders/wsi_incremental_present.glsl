#version 450
out gl_PerVertex {
	vec4 gl_Position;
};
highp float;
void main (void) {
	gl_Position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -1.0 : 1.0,
	                   ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 1.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint mask;
} pushConstants;
void main (void)
{
	highp uint mask = pushConstants.mask;
	highp uint x = mask ^ uint(gl_FragCoord.x);
	highp uint y = mask ^ uint(gl_FragCoord.y);
	highp uint r = 128u * bitfieldExtract(x, 0, 1)
	             +  64u * bitfieldExtract(y, 1, 1)
	             +  32u * bitfieldExtract(x, 3, 1);
	highp uint g = 128u * bitfieldExtract(y, 0, 1)
	             +  64u * bitfieldExtract(x, 2, 1)
	             +  32u * bitfieldExtract(y, 3, 1);
	highp uint b = 128u * bitfieldExtract(x, 1, 1)
	             +  64u * bitfieldExtract(y, 2, 1)
	             +  32u * bitfieldExtract(x, 4, 1);
	o_color = vec4(float(r) / 255.0, float(g) / 255.0, float(b) / 255.0, 1.0);
}
