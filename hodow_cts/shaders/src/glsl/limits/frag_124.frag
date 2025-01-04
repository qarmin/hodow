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
layout(location = 14) in highp vec4 i_color14;
layout(location = 15) in highp vec4 i_color15;
layout(location = 16) in highp vec4 i_color16;
layout(location = 17) in highp vec4 i_color17;
layout(location = 18) in highp vec4 i_color18;
layout(location = 19) in highp vec4 i_color19;
layout(location = 20) in highp vec4 i_color20;
layout(location = 21) in highp vec4 i_color21;
layout(location = 22) in highp vec4 i_color22;
layout(location = 23) in highp vec4 i_color23;
layout(location = 24) in highp vec4 i_color24;
layout(location = 25) in highp vec4 i_color25;
layout(location = 26) in highp vec4 i_color26;
layout(location = 27) in highp vec4 i_color27;
layout(location = 28) in highp vec4 i_color28;
layout(location = 29) in highp vec4 i_color29;
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
    errorCount += (i_color14 == vec4(14.0)) ? 0 : 1;
    errorCount += (i_color15 == vec4(15.0)) ? 0 : 1;
    errorCount += (i_color16 == vec4(16.0)) ? 0 : 1;
    errorCount += (i_color17 == vec4(17.0)) ? 0 : 1;
    errorCount += (i_color18 == vec4(18.0)) ? 0 : 1;
    errorCount += (i_color19 == vec4(19.0)) ? 0 : 1;
    errorCount += (i_color20 == vec4(20.0)) ? 0 : 1;
    errorCount += (i_color21 == vec4(21.0)) ? 0 : 1;
    errorCount += (i_color22 == vec4(22.0)) ? 0 : 1;
    errorCount += (i_color23 == vec4(23.0)) ? 0 : 1;
    errorCount += (i_color24 == vec4(24.0)) ? 0 : 1;
    errorCount += (i_color25 == vec4(25.0)) ? 0 : 1;
    errorCount += (i_color26 == vec4(26.0)) ? 0 : 1;
    errorCount += (i_color27 == vec4(27.0)) ? 0 : 1;
    errorCount += (i_color28 == vec4(28.0)) ? 0 : 1;
    errorCount += (i_color29 == vec4(29.0)) ? 0 : 1;

    if (errorCount == 0)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
}
