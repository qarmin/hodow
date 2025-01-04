#version 450

layout (location=0) out vec4 outColor;

vec4 wcolor = vec4(0, 0, 1, 1);
vec4 ccolor = vec4(0, 0, 0, 1);

void main()
{
    uvec2 ucoords    = uvec2(gl_FragCoord);
    ivec2 icoords    = ivec2(ucoords);
    gl_SampleMask[0] = int((ucoords.x << ${bpc}) | ucoords.y);
    outColor         = wcolor;
}
