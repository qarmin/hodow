#version 450
layout(location = 0) in highp vec4 vertColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
  fragColor = vec4(sin(vertColor.x), cos(vertColor.y), dot(vertColor, vertColor), 1.0);
}
