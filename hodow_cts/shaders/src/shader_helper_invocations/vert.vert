#version 450
void main(void)
{
	gl_Position = vec4(float(-0.6 + 0.6 * gl_VertexIndex),
	                   float( 0.8 - 1.5 * (gl_VertexIndex % 2)), 0.0, 1.0);
}
