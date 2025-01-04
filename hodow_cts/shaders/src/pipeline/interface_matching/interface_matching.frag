#version 450
layout(location = 0) out vec4 fragColor;
${frag_declarations}void main(void)
{
${frag_operations}  fragColor = vec4(result);
}
