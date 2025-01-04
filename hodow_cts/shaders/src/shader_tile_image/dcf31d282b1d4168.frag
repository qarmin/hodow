#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_stencil_attachment_readEXT ) in;
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
    uint previousStencil = uint(round(stencilAttachmentReadEXT() ));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (previous.x == 0 && (previous.y + 1) == patchIndex && (previousStencil + 1) == patchIndex)
    {
        out0.x = 0;
        out0.y = uint(previousStencil + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previousStencil);
    }
}
