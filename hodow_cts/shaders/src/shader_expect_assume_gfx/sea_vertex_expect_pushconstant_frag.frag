#version 460
precision highp float;
precision highp int;
layout(location = 0) in flat uint value;
layout(location = 0) out uvec2 out_color;
void main()
{
    out_color.r = uint(gl_FragCoord.x);
    out_color.g = value;
}
