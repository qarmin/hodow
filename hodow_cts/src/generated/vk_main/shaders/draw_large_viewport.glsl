#version 450
void main (void)
{
  const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
  const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
  gl_Position = vec4(x, y, 1.0, 1.0);
}
#version 450
layout(location = 0) out vec4 fragColor;

void main() {
    fragColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
