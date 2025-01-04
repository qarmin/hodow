#version 450
layout(location = 0) out highp vec4 o_color;
layout(location = 0) in highp vec4 i_color0;
layout(location = 1) in highp vec4 i_color1;
layout(location = 2) in highp vec4 i_color2;
layout(location = 3) in highp vec4 i_color3;
layout(location = 4) in highp vec4 i_color4;
layout(location = 5) in highp vec4 i_color5;
layout(location = 6) in highp vec4 i_color6;
layout(location = 7) in highp vec4 i_color7;
layout(location = 8) in highp vec4 i_color8;
layout(location = 9) in highp vec4 i_color9;
layout(location = 10) in highp vec4 i_color10;
layout(location = 11) in highp vec4 i_color11;
layout(location = 12) in highp vec4 i_color12;
layout(location = 13) in highp vec4 i_color13;
void main (void)
{
    int errorCount = 0;
    errorCount += (i_color0 == vec4(0.0)) ? 0 : 1;
    errorCount += (i_color1 == vec4(1.0)) ? 0 : 1;
    errorCount += (i_color2 == vec4(2.0)) ? 0 : 1;
    errorCount += (i_color3 == vec4(3.0)) ? 0 : 1;
    errorCount += (i_color4 == vec4(4.0)) ? 0 : 1;
    errorCount += (i_color5 == vec4(5.0)) ? 0 : 1;
    errorCount += (i_color6 == vec4(6.0)) ? 0 : 1;
    errorCount += (i_color7 == vec4(7.0)) ? 0 : 1;
    errorCount += (i_color8 == vec4(8.0)) ? 0 : 1;
    errorCount += (i_color9 == vec4(9.0)) ? 0 : 1;
    errorCount += (i_color10 == vec4(10.0)) ? 0 : 1;
    errorCount += (i_color11 == vec4(11.0)) ? 0 : 1;
    errorCount += (i_color12 == vec4(12.0)) ? 0 : 1;
    errorCount += (i_color13 == vec4(13.0)) ? 0 : 1;

    if (errorCount == 0)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
}
