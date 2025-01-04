#version 450 core
precision highp float;
precision highp int;
layout(location = 0) in highp vec2 v_position;
layout(location = 0) flat out uint patchIndex;layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
void main ()
{
    uint localPatchIndex = uint(gl_VertexIndex) / 6 + 1;
    uint patchCountPerDraw = 1;
    uint globalPatchIndex = drawIndex * patchCountPerDraw + localPatchIndex;
    patchIndex = globalPatchIndex;
    gl_Position = vec4(v_position, 0.500000 * globalPatchIndex, 1);
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
layout(location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout(location = 1) tileImageEXT highp uattachmentEXT colorIn1;
layout(location = 0) out highp uvec2 out0;
layout(location = 1) out highp uvec2 out1;
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
        out0.y = uint(patchIndex);
        out1.x = 0;
        out1.y = 0;
    }
    else if (previous.x == 0 && err != 1 && ((previous.y + 1) == patchIndex || previous.y == 0))
    {
        out0.x = 0;
        out0.y = 0;
        out1.x = 0;
        out1.y = uint(max(dx, dy) + 1);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous.y);
        out1.x = 1;
        out1.y = uint(previous.x);
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform utexture2D colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 1u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 1u + i;
        colorbuf.values[idx] = uvec2(round(vec2(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).xy)));
    }
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
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
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform itexture2D colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 1u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 1u + i;
        colorbuf.values[idx] = uvec2(round(vec2(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).xy)));
    }
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
layout(location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout(location = 1) tileImageEXT highp uattachmentEXT colorIn1;
layout(location = 0) out highp uvec4 out0;
layout(location = 1) out highp uvec4 out1;
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
        out0.y = uint(patchIndex);
        out1.x = 0;
        out1.y = 0;
    }
    else if (previous.x == 0 && err != 1 && ((previous.y + 1) == patchIndex || previous.y == 0))
    {
        out0.x = 0;
        out0.y = 0;
        out1.x = 0;
        out1.y = uint(max(dx, dy) + 1);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous.y);
        out1.x = 1;
        out1.y = uint(previous.x);
    }
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
layout(location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout(location = 1) tileImageEXT highp iattachmentEXT colorIn1;
layout(location = 0) out highp ivec4 out0;
layout(location = 1) out highp ivec4 out1;
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
layout(location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout(location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout(location = 0) out highp vec2 out0;
layout(location = 1) out highp vec2 out1;
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
        out0.y = float(patchIndex);
        out1.x = 0;
        out1.y = 0;
    }
    else if (previous.x == 0 && err != 1 && ((previous.y + 1) == patchIndex || previous.y == 0))
    {
        out0.x = 0;
        out0.y = 0;
        out1.x = 0;
        out1.y = float(max(dx, dy) + 1);
    }
    else
    {
        out0.x = 1;
        out0.y = float(previous.y);
        out1.x = 1;
        out1.y = float(previous.x);
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2D colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 1u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 1u + i;
        colorbuf.values[idx] = uvec2(round(vec2(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).xy)));
    }
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
layout(location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout(location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout(location = 0) out highp vec4 out0;
layout(location = 1) out highp vec4 out1;
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
        out0.y = float(patchIndex);
        out1.x = 0;
        out1.y = 0;
    }
    else if (previous.x == 0 && err != 1 && ((previous.y + 1) == patchIndex || previous.y == 0))
    {
        out0.x = 0;
        out0.y = 0;
        out1.x = 0;
        out1.y = float(max(dx, dy) + 1);
    }
    else
    {
        out0.x = 1;
        out0.y = float(previous.y);
        out1.x = 1;
        out1.y = float(previous.x);
    }
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
layout(location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout(location = 1) tileImageEXT highp uattachmentEXT colorIn1;
layout(location = 0) out highp uvec4 out0;
layout(location = 1) out highp uvec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous;
 uint scalingFactor = 2;
    previous.x = uint(round(colorAttachmentReadEXT(colorIn0).x));
    previous.y = uint(round(depthAttachmentReadEXT() * scalingFactor));
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
        out0.y = uint(patchIndex);
        out1.x = 0;
        out1.y = 0;
    }
    else if (previous.x == 0 && err != 1 && ((previous.y + 1) == patchIndex || previous.y == 0))
    {
        out0.x = 0;
        out0.y = 0;
        out1.x = 0;
        out1.y = uint(max(dx, dy) + 1);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous.y);
        out1.x = 1;
        out1.y = uint(previous.x);
    }
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
layout(location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout(location = 1) tileImageEXT highp uattachmentEXT colorIn1;
layout(location = 0) out highp uvec4 out0;
layout(location = 1) out highp uvec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous;
    previous.x = uint(round(colorAttachmentReadEXT(colorIn0).x));
    previous.y = uint(stencilAttachmentReadEXT());
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
        out0.y = uint(patchIndex);
        out1.x = 0;
        out1.y = 0;
    }
    else if (previous.x == 0 && err != 1 && ((previous.y + 1) == patchIndex || previous.y == 0))
    {
        out0.x = 0;
        out0.y = 0;
        out1.x = 0;
        out1.y = uint(max(dx, dy) + 1);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous.y);
        out1.x = 1;
        out1.y = uint(previous.x);
    }
}
