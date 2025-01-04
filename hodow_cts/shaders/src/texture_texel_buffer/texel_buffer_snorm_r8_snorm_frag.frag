#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) samplerBuffer texels;

void main()
{
    color_out = (texelFetch(texels, int(gl_FragCoord.x) % 39) + vec4(1.0)) / vec4(2.0);
    color_out.g = 0;
    color_out.b = 0;
    color_out.a = 1;

}
