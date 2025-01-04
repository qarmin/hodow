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
    gl_Position = vec4(v_position, 1.000000 * globalPatchIndex, 1);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
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
    gl_Position = vec4(v_position, 0.333333 * globalPatchIndex, 1);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0) * 255).xy));
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
    out0.y *= 0.00392157;
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
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 255));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0) * 128).xy));
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
    out0.y *= 0.0078125;
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
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 128));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0) * 255).xy));
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
    out0.y *= 0.00392157;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform utexture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 2u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 2u + i;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform itexture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 2u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 2u + i;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 255).xy));
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
    out0.y *= 0.00392157;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 2u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 2u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 255));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 128).xy));
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
    out0.y *= 0.0078125;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 2u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 2u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 128));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 255).xy));
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
    out0.y *= 0.00392157;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 65535).xy));
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
    out0.y *= 1.5259e-05;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 2u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 2u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 65535));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 32768).xy));
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
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 2u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 2u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 32768));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
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
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 2u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 2u + i;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 1023).xy));
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
    out0.y *= 0.000977517;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 2u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 2u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 1023));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 255).xy));
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
    out0.y *= 0.00392157;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 4u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 4u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 255));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 128).xy));
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
    out0.y *= 0.0078125;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 4u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 4u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 128));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform utexture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 4u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 4u + i;
        colorbuf.values[idx] = uvec2(round(vec2(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).xy)));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform itexture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 4u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 4u + i;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 1023).xy));
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
    out0.y *= 0.000977517;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 4u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 4u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 1023));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 128).xy));
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
    out0.y *= 0.0078125;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 4u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 4u + i;
        colorbuf.values[idx] = uvec2(round(vec2(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).xy)));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform utexture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 8u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 8u + i;
        colorbuf.values[idx] = uvec2(round(vec2(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).xy)));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform itexture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 8u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 8u + i;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 65535).xy));
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
    out0.y *= 1.5259e-05;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 8u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 8u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 65535));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 32768).xy));
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
    out0.y *= 3.05176e-05;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 8u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 8u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 32768));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 8u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 8u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 255));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 8u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 8u + i;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 8u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 8u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 1023));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 255).xy));
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
    out0.y *= 0.00392157;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 16u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 16u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 255));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 128).xy));
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
    out0.y *= 0.0078125;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 16u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 16u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 128));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform utexture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 16u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 16u + i;
        colorbuf.values[idx] = uvec2(round(vec2(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).xy)));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform itexture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 16u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 16u + i;
        colorbuf.values[idx] = uvec2(round(vec2(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).xy)));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 16u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 16u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 65535));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 16u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 16u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 32768));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 65535).xy));
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
    out0.y *= 1.5259e-05;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 32768).xy));
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
    out0.y *= 3.05176e-05;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 16u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 16u + i;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 65535).xy));
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
    out0.y *= 1.5259e-05;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;
void main()
{
    uint zero = 0;
    uvec2 previous[1];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 32768).xy));
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
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform utexture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 32u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 32u + i;
        colorbuf.values[idx] = uvec2(round(vec2(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).xy)));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform itexture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 32u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 32u + i;
        colorbuf.values[idx] = uvec2(round(vec2(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).xy)));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 32u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 32u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 255));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 32u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 32u + i;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp uattachmentEXT colorIn1;
layout( location = 0 ) out highp uvec4 out0;
layout( location = 1 ) out highp uvec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = uint(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = uint(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = uint(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp iattachmentEXT colorIn1;
layout( location = 0 ) out highp ivec4 out0;
layout( location = 1 ) out highp ivec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = int(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = int(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = int(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0) * 65535).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1) * 65535).xy));
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
    out0.y *= 1.5259e-05;
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
    out1.y *= 1.5259e-05;
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
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 65535));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0) * 32768).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1) * 32768).xy));
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
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 32768));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0) * 1023).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1) * 1023).xy));
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
    out0.y *= 0.000977517;
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
    out1.y *= 0.000977517;
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
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 1023));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0) * 255).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1) * 255).xy));
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
    out0.y *= 0.00392157;
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
    out1.y *= 0.00392157;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1)).xy));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0) * 65535).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1) * 65535).xy));
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
    out0.y *= 1.5259e-05;
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
    out1.y *= 1.5259e-05;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0) * 32768).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1) * 32768).xy));
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
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1)).xy));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 255).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 255).xy));
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
    out0.y *= 0.00392157;
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
    out1.y *= 0.00392157;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 128).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 128).xy));
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
    out0.y *= 0.0078125;
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
    out1.y *= 0.0078125;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp uattachmentEXT colorIn1;
layout( location = 0 ) out highp uvec4 out0;
layout( location = 1 ) out highp uvec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = uint(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = uint(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = uint(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp iattachmentEXT colorIn1;
layout( location = 0 ) out highp ivec4 out0;
layout( location = 1 ) out highp ivec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = int(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = int(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = int(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 65535).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 65535).xy));
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
    out0.y *= 1.5259e-05;
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
    out1.y *= 1.5259e-05;
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
layout( location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp uattachmentEXT colorIn1;
layout( location = 0 ) out highp uvec2 out0;
layout( location = 1 ) out highp uvec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = uint(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = uint(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = uint(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp iattachmentEXT colorIn1;
layout( location = 0 ) out highp ivec2 out0;
layout( location = 1 ) out highp ivec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = int(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = int(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = int(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID)).xy));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp uattachmentEXT colorIn1;
layout( location = 0 ) out highp uvec2 out0;
layout( location = 1 ) out highp uvec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = uint(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = uint(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = uint(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp iattachmentEXT colorIn1;
layout( location = 0 ) out highp ivec2 out0;
layout( location = 1 ) out highp ivec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = int(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = int(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = int(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 255).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 255).xy));
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
    out0.y *= 0.00392157;
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
    out1.y *= 0.00392157;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 128).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 128).xy));
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
    out0.y *= 0.0078125;
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
    out1.y *= 0.0078125;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID)).xy));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 255).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 255).xy));
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
    out0.y *= 0.00392157;
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
    out1.y *= 0.00392157;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 128).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 128).xy));
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
    out0.y *= 0.0078125;
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
    out1.y *= 0.0078125;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 8u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 8u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 128));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 65535).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 65535).xy));
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
    out0.y *= 1.5259e-05;
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
    out1.y *= 1.5259e-05;
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
layout( location = 0) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp uattachmentEXT colorIn1;
layout( location = 0 ) out highp uvec4 out0;
layout( location = 1 ) out highp uvec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = uint(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = uint(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = uint(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp iattachmentEXT colorIn1;
layout( location = 0 ) out highp ivec4 out0;
layout( location = 1 ) out highp ivec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = int(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = int(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = int(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 255).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 255).xy));
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
    out0.y *= 0.00392157;
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
    out1.y *= 0.00392157;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 128).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 128).xy));
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
    out0.y *= 0.0078125;
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
    out1.y *= 0.0078125;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 32u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 32u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 128));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 65535).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 65535).xy));
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
    out0.y *= 1.5259e-05;
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
    out1.y *= 1.5259e-05;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 32u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 32u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 65535));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 32768).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 32768).xy));
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
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 32u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 32u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 32768));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn0, gl_SampleID) * 65535).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn1, gl_SampleID) * 65535).xy));
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
    out0.y *= 1.5259e-05;
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
    out1.y *= 1.5259e-05;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 1) tileImageEXT highp attachmentEXT colorIn1;
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
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
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn[2];
layout( location = 0 ) out highp uvec2 out0;
layout( location = 1 ) out highp uvec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0])).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1])).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = uint(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = uint(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = uint(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn[2];
layout( location = 0 ) out highp ivec2 out0;
layout( location = 1 ) out highp ivec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0])).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1])).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = int(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = int(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = int(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0])).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1])).xy));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0])).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1])).xy));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn[2];
layout( location = 0 ) out highp uvec4 out0;
layout( location = 1 ) out highp uvec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0])).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1])).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = uint(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = uint(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = uint(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn[2];
layout( location = 0 ) out highp ivec4 out0;
layout( location = 1 ) out highp ivec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0])).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1])).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = int(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = int(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = int(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0]) * 255).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1]) * 255).xy));
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
    out0.y *= 0.00392157;
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
    out1.y *= 0.00392157;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0]) * 65535).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1]) * 65535).xy));
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
    out0.y *= 1.5259e-05;
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
    out1.y *= 1.5259e-05;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0]) * 32768).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1]) * 32768).xy));
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
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn[2];
layout( location = 0 ) out highp uvec4 out0;
layout( location = 1 ) out highp uvec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0])).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1])).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = uint(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = uint(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = uint(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn[2];
layout( location = 0 ) out highp ivec4 out0;
layout( location = 1 ) out highp ivec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0])).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1])).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = int(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = int(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = int(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0]) * 1023).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1]) * 1023).xy));
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
    out0.y *= 0.000977517;
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
    out1.y *= 0.000977517;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 255).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 255).xy));
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
    out0.y *= 0.00392157;
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
    out1.y *= 0.00392157;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 128).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 128).xy));
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
    out0.y *= 0.0078125;
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
    out1.y *= 0.0078125;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 65535).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 65535).xy));
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
    out0.y *= 1.5259e-05;
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
    out1.y *= 1.5259e-05;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 32768).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 32768).xy));
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
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn[2];
layout( location = 0 ) out highp uvec4 out0;
layout( location = 1 ) out highp uvec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = uint(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = uint(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = uint(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn[2];
layout( location = 0 ) out highp ivec4 out0;
layout( location = 1 ) out highp ivec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = int(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = int(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = int(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn[2];
layout( location = 0 ) out highp uvec2 out0;
layout( location = 1 ) out highp uvec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = uint(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = uint(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = uint(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn[2];
layout( location = 0 ) out highp ivec2 out0;
layout( location = 1 ) out highp ivec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = int(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = int(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = int(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID)).xy));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 255).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 255).xy));
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
    out0.y *= 0.00392157;
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
    out1.y *= 0.00392157;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 128).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 128).xy));
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
    out0.y *= 0.0078125;
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
    out1.y *= 0.0078125;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn[2];
layout( location = 0 ) out highp uvec2 out0;
layout( location = 1 ) out highp uvec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = uint(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = uint(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = uint(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn[2];
layout( location = 0 ) out highp ivec2 out0;
layout( location = 1 ) out highp ivec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = int(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = int(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = int(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 65535).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 65535).xy));
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
    out0.y *= 1.5259e-05;
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
    out1.y *= 1.5259e-05;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 32768).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 32768).xy));
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
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn[2];
layout( location = 0 ) out highp uvec4 out0;
layout( location = 1 ) out highp uvec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID)).xy));
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
        out0.y = uint(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = uint(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = uint(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = uint(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = uint(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn[2];
layout( location = 0 ) out highp ivec4 out0;
layout( location = 1 ) out highp ivec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID)).xy));
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
        out0.y = int(patchIndex + zero + gl_SampleID + 0);
    }
    else if (previous[0].x == 0 && (previous[0].y + 1) == (patchIndex + gl_SampleID + 0))
    {
        out0.x = 0;
        out0.y = int(previous[0].y + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous[0].y);
    }
    if (previous[1].x == 0 && patchIndex == 1)
    {
        out1.x = 0;
        out1.y = int(patchIndex + zero + gl_SampleID + 1);
    }
    else if (previous[1].x == 0 && (previous[1].y + 1) == (patchIndex + gl_SampleID + 1))
    {
        out1.x = 0;
        out1.y = int(previous[1].y + 1 + zero);
    }
    else
    {
        out1.x = 1;
        out1.y = int(previous[1].y);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID)).xy));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 65535).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 65535).xy));
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
    out0.y *= 1.5259e-05;
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
    out1.y *= 1.5259e-05;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 4u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 4u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 65535));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 32768).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 32768).xy));
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
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 4u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 4u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 32768));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 255).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 255).xy));
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
    out0.y *= 0.00392157;
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
    out1.y *= 0.00392157;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 128).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 128).xy));
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
    out0.y *= 0.0078125;
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
    out1.y *= 0.0078125;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID)).xy));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec2 out0;
layout( location = 1 ) out highp vec2 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID)).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID)).xy));
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn[2];
layout( location = 0 ) out highp vec4 out0;
layout( location = 1 ) out highp vec4 out1;
void main()
{
    uint zero = 0;
    uvec2 previous[2];
    previous[0] = uvec2(round((colorAttachmentReadEXT(colorIn[0], gl_SampleID) * 1023).xy));
    previous[1] = uvec2(round((colorAttachmentReadEXT(colorIn[1], gl_SampleID) * 1023).xy));
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
    out0.y *= 0.000977517;
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
    out1.y *= 0.000977517;
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 16u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 16u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 1023));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
    }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
precision highp float;
precision highp int;
layout(set = 0, binding = 0) uniform texture2DMS colorTex;
layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
    for (uint i = 0u; i < 32u; ++i) {
        uint idx = ((gl_GlobalInvocationID.y * 4u) + gl_GlobalInvocationID.x) * 32u + i;
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 1023));
        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));
    }
}
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
    uint localPatchIndex = uint(gl_VertexIndex) / 3 + 1;
    uint patchCountPerDraw = 1;
    uint globalPatchIndex = drawIndex * patchCountPerDraw + localPatchIndex;
    patchIndex = globalPatchIndex;
    gl_Position = vec4(v_position, 1.000000 * globalPatchIndex, 1);
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 2; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 2; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 2; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 65535)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
    out0.y *= 1.5259e-05;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
    uint localPatchIndex = uint(gl_VertexIndex) / 3 + 1;
    uint patchCountPerDraw = 1;
    uint globalPatchIndex = drawIndex * patchCountPerDraw + localPatchIndex;
    patchIndex = globalPatchIndex;
    gl_Position = vec4(v_position, 0.333333 * globalPatchIndex, 1);
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 2; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 255)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    out0.y *= 0.00392157;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 2; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 128)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    out0.y *= 0.0078125;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 2; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 2; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
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
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 255)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    out0.y *= 0.00392157;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 2; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
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
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
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
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1023)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    out0.y *= 0.000977517;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1023)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
    out0.y *= 0.000977517;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 255)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    out0.y *= 0.00392157;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 128)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    out0.y *= 0.0078125;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 255)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    out0.y *= 0.00392157;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 255)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
    out0.y *= 0.00392157;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 128)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
    out0.y *= 0.0078125;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 255)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    out0.y *= 0.00392157;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 128)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    out0.y *= 0.0078125;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 65535)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    out0.y *= 1.5259e-05;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1023)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    out0.y *= 0.000977517;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 255)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
    out0.y *= 0.00392157;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 128)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
    out0.y *= 0.0078125;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 255)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
    out0.y *= 0.00392157;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 65535)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
    out0.y *= 1.5259e-05;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 32; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 255)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
    out0.y *= 0.00392157;
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec2 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 32; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 32; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 32; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 32; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 32; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = uint(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = uint(previous);
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec4 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 32; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 1)).xy;
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
    for(uint index = 0u; index < overheadLoop; index++)
    {
        zero = uint(sin(float(zero)));
    }
}
    if (!error && (previous + 1 == patchIndex))
    {
        out0.x = 0;
        out0.y = int(previous + 1 + zero);
    }
    else
    {
        out0.x = 1;
        out0.y = int(previous);
    }
}
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
layout( non_coherent_color_attachment_readEXT ) in;
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
layout( non_coherent_color_attachment_readEXT ) in;
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
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( location = 0 ) flat in uint patchIndex;
layout( non_coherent_color_attachment_readEXT ) in;
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
layout( non_coherent_color_attachment_readEXT ) in;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( non_coherent_depth_attachment_readEXT ) in;
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
layout( non_coherent_color_attachment_readEXT ) in;
layout( non_coherent_stencil_attachment_readEXT ) in;
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_depth_attachment_readEXT ) in;
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 3;
    uint previousDepth = uint(round(depthAttachmentReadEXT() * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
}
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_depth_attachment_readEXT ) in;
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 1;
 scalingFactor += 2;
    uint previousDepth = uint(round(depthAttachmentReadEXT(gl_SampleID) * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_depth_attachment_readEXT ) in;
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 3;
 scalingFactor += 2;
    uint previousDepth = uint(round(depthAttachmentReadEXT(gl_SampleID) * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_depth_attachment_readEXT ) in;
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 1;
 scalingFactor += 4;
    uint previousDepth = uint(round(depthAttachmentReadEXT(gl_SampleID) * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_depth_attachment_readEXT ) in;
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 3;
 scalingFactor += 4;
    uint previousDepth = uint(round(depthAttachmentReadEXT(gl_SampleID) * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_depth_attachment_readEXT ) in;
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 1;
 scalingFactor += 8;
    uint previousDepth = uint(round(depthAttachmentReadEXT(gl_SampleID) * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_depth_attachment_readEXT ) in;
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 3;
 scalingFactor += 8;
    uint previousDepth = uint(round(depthAttachmentReadEXT(gl_SampleID) * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_depth_attachment_readEXT ) in;
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 1;
 scalingFactor += 16;
    uint previousDepth = uint(round(depthAttachmentReadEXT(gl_SampleID) * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_depth_attachment_readEXT ) in;
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 3;
 scalingFactor += 16;
    uint previousDepth = uint(round(depthAttachmentReadEXT(gl_SampleID) * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_depth_attachment_readEXT ) in;
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 1;
 scalingFactor += 32;
    uint previousDepth = uint(round(depthAttachmentReadEXT(gl_SampleID) * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(1 + 1);
    zero = patchIndex / (1 + 1);
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
#version 450 core
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
layout( non_coherent_depth_attachment_readEXT ) in;
layout( non_coherent_color_attachment_readEXT ) in;
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 3;
 scalingFactor += 32;
    uint previousDepth = uint(round(depthAttachmentReadEXT(gl_SampleID) * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
    uint previousStencil = uint(round(stencilAttachmentReadEXT(gl_SampleID) ));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
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
    uint previousStencil = uint(round(stencilAttachmentReadEXT(gl_SampleID) ));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0, gl_SampleID)));
{
    uint overheadLoop = uint(gl_FragCoord.x) * uint(3 + 1);
    zero = patchIndex / (3 + 1);
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
