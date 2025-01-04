#version 450
layout(location = 0) in vec4 inUV;
layout(binding = 0, rg32ui) uniform uimage2D resultImage;
layout(binding = 1, input_attachment_index = 3) uniform subpassInput attach1;
layout(binding = 2, input_attachment_index = 5) uniform subpassInput attach2;
layout(binding = 3, input_attachment_index = 8) uniform subpassInput attach3;
layout(binding = 4, input_attachment_index = 15) uniform subpassInput attach4;
layout(binding = 5, input_attachment_index = 16) uniform subpassInput attach5;
layout(binding = 6, input_attachment_index = 17) uniform subpassInput attach6;
layout(binding = 7, input_attachment_index = 18) uniform subpassInput attach7;
layout(binding = 8, input_attachment_index = 19) uniform subpassInput attach8;
layout(binding = 9, input_attachment_index = 23) uniform subpassInput attach9;
layout(binding = 10, input_attachment_index = 26) uniform subpassInput attach10;
layout(binding = 11, input_attachment_index = 29) uniform subpassInput attach11;
layout(binding = 12, input_attachment_index = 30) uniform subpassInput attach12;
layout(binding = 13, input_attachment_index = 31) uniform subpassInput attach13;
layout(binding = 14, input_attachment_index = 33) uniform subpassInput attach14;
layout(binding = 15, input_attachment_index = 41) uniform subpassInput attach15;
layout(binding = 16, input_attachment_index = 42) uniform subpassInput attach16;
layout(binding = 17, input_attachment_index = 44) uniform subpassInput attach17;
layout(binding = 18, input_attachment_index = 46) uniform subpassInput attach18;
layout(binding = 19, input_attachment_index = 49) uniform subpassInput attach19;
layout(binding = 20, input_attachment_index = 51) uniform subpassInput attach20;
layout(binding = 21, input_attachment_index = 54) uniform subpassInput attach21;
layout(binding = 22, input_attachment_index = 56) uniform subpassInput attach22;
layout(binding = 23, input_attachment_index = 58) uniform subpassInput attach23;
layout(binding = 24, input_attachment_index = 60) uniform subpassInput attach24;
layout(binding = 25, input_attachment_index = 63) uniform subpassInput attach25;
layout(binding = 26, input_attachment_index = 65) uniform subpassInput attach26;
layout(binding = 27, input_attachment_index = 67) uniform subpassInput attach27;
layout(binding = 28, input_attachment_index = 69) uniform subpassInput attach28;
layout(binding = 29, input_attachment_index = 72) uniform subpassInput attach29;
layout(binding = 30, input_attachment_index = 74) uniform subpassInput attach30;
layout(binding = 31, input_attachment_index = 75) uniform subpassInput attach31;
layout(binding = 32, input_attachment_index = 76) uniform subpassInput attach32;
layout(binding = 33, input_attachment_index = 77) uniform subpassInput attach33;
layout(binding = 34, input_attachment_index = 78) uniform subpassInput attach34;
layout(binding = 35, input_attachment_index = 79) uniform subpassInput attach35;
layout(binding = 36, input_attachment_index = 81) uniform subpassInput attach36;
layout(binding = 37, input_attachment_index = 83) uniform subpassInput attach37;
layout(binding = 38, input_attachment_index = 85) uniform subpassInput attach38;
layout(binding = 39, input_attachment_index = 86) uniform subpassInput attach39;
layout(binding = 40, input_attachment_index = 87) uniform subpassInput attach40;
layout(binding = 41, input_attachment_index = 89) uniform subpassInput attach41;
layout(binding = 42, input_attachment_index = 90) uniform subpassInput attach42;
layout(binding = 43, input_attachment_index = 91) uniform subpassInput attach43;
layout(binding = 44, input_attachment_index = 93) uniform subpassInput attach44;
layout(binding = 45, input_attachment_index = 94) uniform subpassInput attach45;
layout(binding = 46, input_attachment_index = 96) uniform subpassInput attach46;
layout(binding = 47, input_attachment_index = 98) uniform subpassInput attach47;
layout(binding = 48, input_attachment_index = 102) uniform subpassInput attach48;
layout(binding = 49, input_attachment_index = 110) uniform subpassInput attach49;
layout(binding = 50, input_attachment_index = 111) uniform subpassInput attach50;
layout(binding = 51, input_attachment_index = 116) uniform subpassInput attach51;
layout(binding = 52, input_attachment_index = 117) uniform subpassInput attach52;
layout(binding = 53, input_attachment_index = 118) uniform subpassInput attach53;
layout(binding = 54, input_attachment_index = 121) uniform subpassInput attach54;
layout(binding = 55, input_attachment_index = 122) uniform subpassInput attach55;
layout(binding = 56, input_attachment_index = 125) uniform subpassInput attach56;
layout(binding = 57, input_attachment_index = 126) uniform subpassInput attach57;
layout(binding = 58, input_attachment_index = 127) uniform subpassInput attach58;
layout(binding = 59, input_attachment_index = 128) uniform subpassInput attach59;
layout(binding = 60, input_attachment_index = 129) uniform subpassInput attach60;
layout(binding = 61, input_attachment_index = 130) uniform subpassInput attach61;
layout(binding = 62, input_attachment_index = 131) uniform subpassInput attach62;
layout(binding = 63, input_attachment_index = 134) uniform subpassInput attach63;
layout(binding = 64, input_attachment_index = 135) uniform subpassInput attach64;
layout(binding = 65, input_attachment_index = 137) uniform subpassInput attach65;
layout(binding = 66, input_attachment_index = 138) uniform subpassInput attach66;
layout(binding = 67, input_attachment_index = 140) uniform subpassInput attach67;
layout(binding = 68, input_attachment_index = 144) uniform subpassInput attach68;
layout(binding = 69, input_attachment_index = 146) uniform subpassInput attach69;
layout(binding = 70, input_attachment_index = 147) uniform subpassInput attach70;
layout(binding = 71, input_attachment_index = 148) uniform subpassInput attach71;
layout(binding = 72, input_attachment_index = 151) uniform subpassInput attach72;
layout(binding = 73, input_attachment_index = 152) uniform subpassInput attach73;
layout(binding = 74, input_attachment_index = 155) uniform subpassInput attach74;
layout(binding = 75, input_attachment_index = 156) uniform subpassInput attach75;
layout(binding = 76, input_attachment_index = 158) uniform subpassInput attach76;
layout(binding = 77, input_attachment_index = 159) uniform subpassInput attach77;
layout(binding = 78, input_attachment_index = 161) uniform subpassInput attach78;
layout(binding = 79, input_attachment_index = 164) uniform subpassInput attach79;
layout(binding = 80, input_attachment_index = 167) uniform subpassInput attach80;
layout(binding = 81, input_attachment_index = 169) uniform subpassInput attach81;
layout(binding = 82, input_attachment_index = 170) uniform subpassInput attach82;
layout(binding = 83, input_attachment_index = 172) uniform subpassInput attach83;
layout(binding = 84, input_attachment_index = 173) uniform subpassInput attach84;
layout(binding = 85, input_attachment_index = 174) uniform subpassInput attach85;
layout(binding = 86, input_attachment_index = 175) uniform subpassInput attach86;
layout(binding = 87, input_attachment_index = 177) uniform subpassInput attach87;
layout(binding = 88, input_attachment_index = 178) uniform subpassInput attach88;
layout(binding = 89, input_attachment_index = 180) uniform subpassInput attach89;
layout(binding = 90, input_attachment_index = 181) uniform subpassInput attach90;
layout(binding = 91, input_attachment_index = 182) uniform subpassInput attach91;
layout(binding = 92, input_attachment_index = 183) uniform subpassInput attach92;
layout(binding = 93, input_attachment_index = 184) uniform subpassInput attach93;
layout(binding = 94, input_attachment_index = 187) uniform subpassInput attach94;
layout(binding = 95, input_attachment_index = 188) uniform subpassInput attach95;
layout(binding = 96, input_attachment_index = 189) uniform subpassInput attach96;
layout(binding = 97, input_attachment_index = 190) uniform subpassInput attach97;
layout(binding = 98, input_attachment_index = 192) uniform subpassInput attach98;
layout(binding = 99, input_attachment_index = 195) uniform subpassInput attach99;
layout(binding = 100, input_attachment_index = 199) uniform subpassInput attach100;
layout(binding = 101, input_attachment_index = 205) uniform subpassInput attach101;
layout(binding = 102, input_attachment_index = 206) uniform subpassInput attach102;
layout(binding = 103, input_attachment_index = 207) uniform subpassInput attach103;
layout(binding = 104, input_attachment_index = 208) uniform subpassInput attach104;
layout(binding = 105, input_attachment_index = 209) uniform subpassInput attach105;
layout(binding = 106, input_attachment_index = 211) uniform subpassInput attach106;
layout(binding = 107, input_attachment_index = 212) uniform subpassInput attach107;
layout(binding = 108, input_attachment_index = 213) uniform subpassInput attach108;
layout(binding = 109, input_attachment_index = 214) uniform subpassInput attach109;
layout(binding = 110, input_attachment_index = 216) uniform subpassInput attach110;
layout(binding = 111, input_attachment_index = 219) uniform subpassInput attach111;
layout(binding = 112, input_attachment_index = 221) uniform subpassInput attach112;
layout(binding = 113, input_attachment_index = 222) uniform subpassInput attach113;
layout(binding = 114, input_attachment_index = 224) uniform subpassInput attach114;
layout(binding = 115, input_attachment_index = 225) uniform subpassInput attach115;
layout(binding = 116, input_attachment_index = 226) uniform subpassInput attach116;
layout(binding = 117, input_attachment_index = 227) uniform subpassInput attach117;
layout(binding = 118, input_attachment_index = 231) uniform subpassInput attach118;
layout(binding = 119, input_attachment_index = 232) uniform subpassInput attach119;
layout(binding = 120, input_attachment_index = 233) uniform subpassInput attach120;
layout(binding = 121, input_attachment_index = 237) uniform subpassInput attach121;
layout(binding = 122, input_attachment_index = 241) uniform subpassInput attach122;
layout(binding = 123, input_attachment_index = 247) uniform subpassInput attach123;
layout(binding = 124, input_attachment_index = 249) uniform subpassInput attach124;
layout(binding = 125, input_attachment_index = 250) uniform subpassInput attach125;
layout(binding = 126, input_attachment_index = 251) uniform subpassInput attach126;
layout(binding = 127, input_attachment_index = 252) uniform subpassInput attach127;
void main (void)
{
    uvec4 result = uvec4(0);
    result.x = result.x + 1;
    if(subpassLoad(attach1).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach2).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach3).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach4).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach5).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach6).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach7).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach8).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach9).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach10).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach11).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach12).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach13).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach14).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach15).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach16).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach17).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach18).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach19).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach20).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach21).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach22).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach23).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach24).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach25).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach26).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach27).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach28).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach29).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach30).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach31).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach32).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach33).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach34).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach35).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach36).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach37).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach38).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach39).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach40).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach41).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach42).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach43).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach44).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach45).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach46).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach47).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach48).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach49).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach50).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach51).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach52).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach53).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach54).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach55).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach56).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach57).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach58).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach59).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach60).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach61).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach62).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach63).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach64).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach65).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach66).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach67).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach68).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach69).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach70).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach71).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach72).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach73).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach74).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach75).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach76).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach77).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach78).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach79).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach80).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach81).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach82).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach83).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach84).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach85).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach86).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach87).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach88).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach89).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach90).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach91).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach92).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach93).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach94).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach95).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach96).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach97).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach98).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach99).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach100).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach101).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach102).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach103).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach104).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach105).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach106).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach107).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach108).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach109).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach110).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach111).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach112).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach113).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach114).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach115).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach116).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach117).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach118).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach119).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach120).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach121).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach122).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach123).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach124).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach125).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach126).x > 0.0)
        result.y = result.y + 1;
    result.x = result.x + 1;
    if(subpassLoad(attach127).x > 0.0)
        result.y = result.y + 1;
    imageStore(resultImage, ivec2(imageSize(resultImage) * inUV.xy), result);
}
