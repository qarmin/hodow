#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 2; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 32768)).xy;
            if (previousSample.x != 0)
            {
                error = true;
                break;            }
            if (previous == 0)
            {
                previous = previousSample.y;
            }

            if ((patchIndex != 1 && previousSample.y == 0) || previous != previousSample.y)
            {
                error = true;
                break;
            }
        }
    }

{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(9 + 1);
    zero = patchIndex / (9 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = float(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = float(previous);
    }
    out0.y *= 3.05176e-05;
}
