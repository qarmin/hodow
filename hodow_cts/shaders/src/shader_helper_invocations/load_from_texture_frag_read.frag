#version 450
layout(location = 0) out uint outColor;
layout(binding=0) uniform usampler2D samp;
void main (void)
{
	vec2 uv = vec2(gl_FragCoord.x, gl_FragCoord.y) / 32;
	float c = texture(samp, uv).r;
	outColor = uint(fwidth(c));
}
