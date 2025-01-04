#version 450
layout(location = 0) in highp vec4 vertColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
  fragColor = vertColor;
}
