#version 450
layout(location = 0) in vec4 inUV;
layout(binding = 0, rg32ui) uniform uimage2D resultImage;
layout(binding = 1, input_attachment_index = 1) uniform subpassInput attach1;
void main (void)
{
    uvec4 result = uvec4(0);
    result.x = result.x + 1;
    if(subpassLoad(attach1).x > 0.0)
        result.y = result.y + 1;
    imageStore(resultImage, ivec2(imageSize(resultImage) * inUV.xy), result);
}
