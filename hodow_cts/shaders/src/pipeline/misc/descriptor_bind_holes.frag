#version 450
layout (location=0) out vec4 outColor;
layout(set = 0, binding = 0) uniform Output0 {    uint data;} buf0;
layout(set = 3, binding = 0) uniform Output3 {    uint data;} buf3;
void main ()
{
    const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    outColor = ((buf0.data == 0) && (buf3.data == 3)) ? green : red;
}
