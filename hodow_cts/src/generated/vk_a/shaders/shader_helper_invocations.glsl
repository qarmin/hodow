#version 450
void main(void)
{
	gl_Position = vec4(float(-0.6 + 0.6 * gl_VertexIndex),
	                   float( 0.8 - 1.5 * (gl_VertexIndex % 2)), 0.0, 1.0);
}
#version 450
layout(location = 0) out uint outColor;
void main (void)
{
	outColor = 84;
}
#version 450
layout(location = 0) out uint outColor;
layout(std430, binding=0) readonly buffer Input { uint v[]; };
void main (void)
{
	uint i = uint(gl_FragCoord.y)*32+uint(gl_FragCoord.x);
	outColor = uint(fwidth(v[i]));
}
#version 450
#extension GL_EXT_buffer_reference : require
layout(location = 0) out uint outColor;
layout(std430, buffer_reference, buffer_reference_align = 4) readonly buffer Data
{ uint v[]; };
layout(std430, push_constant) uniform Input { Data data; };
void main (void)
{
	uint i = uint(gl_FragCoord.y)*32+uint(gl_FragCoord.x);
	outColor = uint(fwidth(data.v[i]));
}
#version 450
layout(location = 0) out uint outColor;
layout(binding=0) uniform Input { uvec4 v[32*8]; };
void main (void)
{
	uint i = uint(gl_FragCoord.y)*8+uint(gl_FragCoord.x) / 4;
	uvec4 color = v[i];
	outColor = uint(fwidth(color[uint(gl_FragCoord.x) % 4]));
}
#version 450
layout(location = 0) out uint outColor;
layout(binding=0, r32ui) readonly uniform uimage2D image;
void main (void)
{
	uint c = imageLoad(image, ivec2(uint(gl_FragCoord.x), uint(gl_FragCoord.y))).x;
	outColor = uint(fwidth(c));
}
#version 450
layout(location = 0) out uint outColor;
layout(binding=0) uniform usampler2D samp;
void main (void)
{
	vec2 uv = vec2(gl_FragCoord.x, gl_FragCoord.y) / 32;
	float c = texture(samp, uv).r;
	outColor = uint(fwidth(c));
}
#version 450
layout(location = 0) out uint outColor;
void main (void)
{
	outColor = 84;
	outColor = uint(gl_FragCoord.y)*32+uint(gl_FragCoord.x);
}
#version 450
layout(location = 0) out uint outColor;
layout(input_attachment_index=0, binding=0) uniform usubpassInput image;
void main (void)
{
	uint c = subpassLoad(image).x;
	outColor = c + uint(gl_FragCoord.y) * uint(gl_FragCoord.x);
}
