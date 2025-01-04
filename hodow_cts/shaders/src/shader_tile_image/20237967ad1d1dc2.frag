#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0) * 63).xy));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
    out0.y *= 0.015873;
}
