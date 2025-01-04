#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
layout( non_coherent_color_attachment_readEXT ) in;
layout(location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout(location = 1) tileImageEXT highp iattachmentEXT colorIn1;
layout(location = 0) out highp ivec2 out0;
layout(location = 1) out highp ivec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous;
    previous = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
    uint err = 0;
    uint dx = 0;
    uint dy = 0;
    if (patchIndex != 1)    {
        dx = uint(round(abs(dFdxFine(previous.y))));
        dy = uint(round(abs(dFdyFine(previous.y))));
        uint err = 0;
        if ((dx != 0 && dx != patchIndex - 1) || (dy != 0 && dy != patchIndex - 1))
        {
            err = 1;
        }
    }
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(2 + 1);
    zero = patchIndex / (2 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (patchIndex == 1 && err != 1)
    {
        out0.x = 0;
        out0.y = int(patchIndex);
        out1.x = 0;
        out1.y = 0;
    }
    else if (previous.x == 0 && err != 1 && ((previous.y + 1) == patchIndex || previous.y == 0))
    {
        out0.x = 0;
        out0.y = 0;
        out1.x = 0;
        out1.y = int(max(dx, dy) + 1);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous.y);
        out1.x = 1;
        out1.y = int(previous.x);
    }
}
