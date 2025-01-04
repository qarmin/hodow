#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) usamplerBuffer texels;

void main()
{
    color_out = texelFetch(texels, int(gl_FragCoord.x) % 4);
}
