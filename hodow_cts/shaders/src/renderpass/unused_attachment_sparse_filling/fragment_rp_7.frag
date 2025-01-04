#version 450
layout(location = 0) in vec4 inUV;
layout(binding = 0, rg32ui) uniform uimage2D resultImage;
layout(binding = 1, input_attachment_index = 2) uniform subpassInput attach1;
layout(binding = 2, input_attachment_index = 4) uniform subpassInput attach2;
layout(binding = 3, input_attachment_index = 9) uniform subpassInput attach3;
layout(binding = 4, input_attachment_index = 10) uniform subpassInput attach4;
layout(binding = 5, input_attachment_index = 11) uniform subpassInput attach5;
layout(binding = 6, input_attachment_index = 12) uniform subpassInput attach6;
layout(binding = 7, input_attachment_index = 13) uniform subpassInput attach7;
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
    imageStore(resultImage, ivec2(imageSize(resultImage) * inUV.xy), result);
}
