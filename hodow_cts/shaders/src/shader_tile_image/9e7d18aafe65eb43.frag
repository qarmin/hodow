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
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 32768).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 32768).xy));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (previous[0].x == 0 && patchIndex == 1)
    {
        out0.x = 0;
        out0.y = float(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = float(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = float(previous[0].y);
    }
    out0.y *= 3.05176e-05;
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = float(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = float(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = float(previous[1].y);
    }
    out1.y *= 3.05176e-05;
}
