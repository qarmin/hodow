#version 450
layout(location = 0) in highp vec4 vertColor;
layout(location = 0) out highp vec4 fragColor;
layout(constant_id = 1) const float fColor = 0.1;
void main (void)
{
  fragColor = vertColor + vec4(fColor);
}
