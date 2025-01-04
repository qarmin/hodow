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
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 1;
    uint previousDepth = uint(round(depthAttachmentReadEXT() * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0)));
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
    uint patchCountPerDraw = 3;
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
    uint patchCountPerDraw = 3;
    uint globalPatchIndex = drawIndex * patchCountPerDraw + localPatchIndex;
    patchIndex = globalPatchIndex;
    gl_Position = vec4(v_position, 0.111111 * globalPatchIndex, 1);
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
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 9;
    uint previousDepth = uint(round(depthAttachmentReadEXT() * scalingFactor));
    uvec4 previous = uvec4(round(colorAttachmentReadEXT(colorIn0)));
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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 9;
 scalingFactor += 2;
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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 9;
 scalingFactor += 4;
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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 9;
 scalingFactor += 8;
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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec4 out0;

void main()
{
    uint zero = 0;
 uint scalingFactor = 9;
 scalingFactor += 16;
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
