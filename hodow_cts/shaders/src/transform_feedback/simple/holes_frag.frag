#version 460
layout (location=0) out vec4 outColor;

layout (location = 0) in float goku;
layout (location = 0, component = 1) in float trunks;
layout (location = 0, component = 2) in float vegeta;

void main ()
{
    outColor = ((goku == 10.0 && trunks == 20.0 && vegeta == 30.0)
             ? vec4(0.0, 0.0, 1.0, 1.0)
             : vec4(0.0, 0.0, 0.0, 1.0));
}
