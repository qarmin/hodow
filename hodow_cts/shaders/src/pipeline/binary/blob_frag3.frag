#version 450
layout(location = 0) in highp vec2 texCoord;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
  const float d = length(texCoord - vec2(0.5));
  fragColor = vec4(fract(d * 8.0), texCoord, 1.0);
}
