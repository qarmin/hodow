#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
layout(location = 4) out highp vec4 o_color4;
layout(location = 5) out highp vec4 o_color5;
layout(location = 6) out highp vec4 o_color6;
layout(location = 7) out highp vec4 o_color7;
layout(location = 8) out highp vec4 o_color8;
layout(location = 9) out highp vec4 o_color9;
layout(location = 10) out highp vec4 o_color10;
layout(location = 11) out highp vec4 o_color11;
layout(location = 12) out highp vec4 o_color12;
layout(location = 13) out highp vec4 o_color13;
layout(location = 14) out highp vec4 o_color14;
void main (void)
{
    gl_Position = a_position;
    o_color0 = vec4(0.0);
    o_color1 = vec4(1.0);
    o_color2 = vec4(2.0);
    o_color3 = vec4(3.0);
    o_color4 = vec4(4.0);
    o_color5 = vec4(5.0);
    o_color6 = vec4(6.0);
    o_color7 = vec4(7.0);
    o_color8 = vec4(8.0);
    o_color9 = vec4(9.0);
    o_color10 = vec4(10.0);
    o_color11 = vec4(11.0);
    o_color12 = vec4(12.0);
    o_color13 = vec4(13.0);
    o_color14 = vec4(14.0);
}
