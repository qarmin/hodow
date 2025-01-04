#version 450
layout(location = 0) in vec4 inUV;
layout(binding = 0, rg32ui) uniform uimage2D resultImage;
layout(binding = 1, input_attachment_index = 29) uniform subpassInput attach1;
layout(binding = 2, input_attachment_index = 25) uniform subpassInput attach2;
layout(binding = 3, input_attachment_index = 27) uniform subpassInput attach3;
layout(binding = 4, input_attachment_index = 3) uniform subpassInput attach4;
layout(binding = 5, input_attachment_index = 4) uniform subpassInput attach5;
layout(binding = 6, input_attachment_index = 2) uniform subpassInput attach6;
layout(binding = 7, input_attachment_index = 34) uniform subpassInput attach7;
layout(binding = 8, input_attachment_index = 6) uniform subpassInput attach8;
layout(binding = 9, input_attachment_index = 44) uniform subpassInput attach9;
layout(binding = 10, input_attachment_index = 23) uniform subpassInput attach10;
layout(binding = 11, input_attachment_index = 43) uniform subpassInput attach11;
layout(binding = 12, input_attachment_index = 56) uniform subpassInput attach12;
layout(binding = 13, input_attachment_index = 38) uniform subpassInput attach13;
layout(binding = 14, input_attachment_index = 36) uniform subpassInput attach14;
layout(binding = 15, input_attachment_index = 21) uniform subpassInput attach15;
layout(binding = 16, input_attachment_index = 26) uniform subpassInput attach16;
layout(binding = 17, input_attachment_index = 15) uniform subpassInput attach17;
layout(binding = 18, input_attachment_index = 39) uniform subpassInput attach18;
layout(binding = 19, input_attachment_index = 28) uniform subpassInput attach19;
layout(binding = 20, input_attachment_index = 35) uniform subpassInput attach20;
layout(binding = 21, input_attachment_index = 61) uniform subpassInput attach21;
layout(binding = 22, input_attachment_index = 5) uniform subpassInput attach22;
layout(binding = 23, input_attachment_index = 40) uniform subpassInput attach23;
layout(binding = 24, input_attachment_index = 46) uniform subpassInput attach24;
layout(binding = 25, input_attachment_index = 31) uniform subpassInput attach25;
layout(binding = 26, input_attachment_index = 11) uniform subpassInput attach26;
layout(binding = 27, input_attachment_index = 41) uniform subpassInput attach27;
layout(binding = 28, input_attachment_index = 22) uniform subpassInput attach28;
layout(binding = 29, input_attachment_index = 33) uniform subpassInput attach29;
layout(binding = 30, input_attachment_index = 48) uniform subpassInput attach30;
layout(binding = 31, input_attachment_index = 55) uniform subpassInput attach31;
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
    imageStore(resultImage, ivec2(imageSize(resultImage) * inUV.xy), result);
}
