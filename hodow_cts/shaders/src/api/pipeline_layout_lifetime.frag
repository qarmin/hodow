#version 450

layout(location=0) out vec4 x;
layout(set=0) layout(binding=0) uniform foo { int x; int y; } bar;
void main (void)
{
   x = vec4(bar.y);
}
