#version 450
layout(location = 0) in vec4 position;
layout(location = 0) out highp vec4 vertColor;
layout(constant_id = 0) const float vColor = 0.1;
out gl_PerVertex { vec4 gl_Position; };
void main (void)
{
  vertColor = vec4(vColor * gl_VertexIndex);
  gl_Position = position;
}
