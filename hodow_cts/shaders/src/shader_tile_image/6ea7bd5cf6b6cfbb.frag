#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 9;
 scalingFactor += 32;
    uint previousDepth = uint(round(depthAttachmentReadEXT(gl_SampleID) * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(9 + 1);
    zero = patchIndex / (9 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (previous.x == 0 && patchIndex == 1)
    {
        out0.x = 0;
        out0.y = (1u + zero + gl_SampleID);
    }
    else if (previous.x == 0 && (previous.y + 1) == (patchIndex + gl_SampleID) && (previousDepth + 1) == (patchIndex + gl_SampleID))
    {
        out0.x = 0;
        out0.y = uint(previousDepth + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previousDepth);
    }
 gl_FragDepth = float(out0.y) / scalingFactor;
}
