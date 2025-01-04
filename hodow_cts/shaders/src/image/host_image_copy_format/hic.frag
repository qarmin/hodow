#version 450
layout (location=0) out vec4 out_color;
layout (location=0) in vec2 texCoord;
layout (set=0, binding=0) uniform sampler2D combinedSampler;
void main()
{
${output}}
