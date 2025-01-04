#version 450
layout(location = 0) in vec4 inUV;
layout(binding = 0, rg32ui) uniform uimage2D resultImage;
layout(binding = 1, input_attachment_index = 11) uniform subpassInput attach1;
layout(binding = 2, input_attachment_index = 29) uniform subpassInput attach2;
layout(binding = 3, input_attachment_index = 26) uniform subpassInput attach3;
layout(binding = 4, input_attachment_index = 8) uniform subpassInput attach4;
layout(binding = 5, input_attachment_index = 16) uniform subpassInput attach5;
layout(binding = 6, input_attachment_index = 27) uniform subpassInput attach6;
layout(binding = 7, input_attachment_index = 14) uniform subpassInput attach7;
layout(binding = 8, input_attachment_index = 18) uniform subpassInput attach8;
layout(binding = 9, input_attachment_index = 10) uniform subpassInput attach9;
layout(binding = 10, input_attachment_index = 12) uniform subpassInput attach10;
layout(binding = 11, input_attachment_index = 28) uniform subpassInput attach11;
layout(binding = 12, input_attachment_index = 5) uniform subpassInput attach12;
layout(binding = 13, input_attachment_index = 15) uniform subpassInput attach13;
layout(binding = 14, input_attachment_index = 4) uniform subpassInput attach14;
layout(binding = 15, input_attachment_index = 23) uniform subpassInput attach15;
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
    imageStore(resultImage, ivec2(imageSize(resultImage) * inUV.xy), result);
}
