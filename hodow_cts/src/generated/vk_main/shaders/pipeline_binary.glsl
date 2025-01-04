#version 310 es
layout(local_size_x = 8) in;
layout(binding = 0) writeonly buffer Output
{
  uint v[];
} output_data;
void main()
{
  output_data.v[gl_GlobalInvocationID.x] = gl_GlobalInvocationID.x;
}
#version 450
out gl_PerVertex { vec4 gl_Position; };
void main (void)
{
  const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
  const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
  gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
  fragColor = vec4(1.0, 0.0, 1.0, 0.0);
}
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
#version 450
layout(location = 0) in highp vec4 vertColor;
layout(location = 0) out highp vec4 fragColor;
layout(constant_id = 1) const float fColor = 0.1;
void main (void)
{
  fragColor = vertColor + vec4(fColor);
}
#version 450
layout(location = 0) out highp vec4 vertColor;
out gl_PerVertex { vec4 gl_Position; };
void main (void)
{
  const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
  const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
  vertColor = vec4(x, y, 0.0, 1.0);
  gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec2 texCoord;
out gl_PerVertex { vec4 gl_Position; };
void main (void)
{
  texCoord = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
  gl_Position = vec4(texCoord * 2.0 - 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec4 vertColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
  fragColor = vertColor;
}
#version 450
layout(location = 0) in highp vec4 vertColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
  fragColor = vec4(sin(vertColor.x), cos(vertColor.y), dot(vertColor, vertColor), 1.0);
}
#version 450
layout(location = 0) in highp vec2 texCoord;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
  const float d = length(texCoord - vec2(0.5));
  fragColor = vec4(fract(d * 8.0), texCoord, 1.0);
}
