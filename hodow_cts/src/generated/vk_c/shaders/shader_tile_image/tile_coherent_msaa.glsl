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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 2; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 63)).xy;
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
    out0.y *= 0.015873;
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
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 63));
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
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 2; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 63)).xy;
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
    out0.y *= 0.015873;
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
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 2; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 63)).xy;
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
    out0.y *= 0.015873;
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
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 63)).xy;
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
    out0.y *= 0.015873;
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
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 63));
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
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
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
    for (int i = 0; i < 4; ++i)
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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 63)).xy;
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
    out0.y *= 0.015873;
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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 4; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 63)).xy;
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
    out0.y *= 0.015873;
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
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 63)).xy;
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
    out0.y *= 0.015873;
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
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 63));
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
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 63)).xy;
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
    out0.y *= 0.015873;
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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 8; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 63)).xy;
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
    out0.y *= 0.015873;
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
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 63)).xy;
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
    out0.y *= 0.015873;
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
        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * 63));
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
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
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
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
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
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 63)).xy;
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
    out0.y *= 0.015873;
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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp attachmentEXT colorIn0;
layout( location = 0 ) out highp vec3 out0;

void main()
{
    uint zero = 0;
    uint previous = 0;
    bool error = false;
    for (int i = 0; i < 16; ++i)
    {
        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)
        {
            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * 63)).xy;
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
    out0.y *= 0.015873;
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
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
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
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;

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
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;

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
#extension GL_EXT_shader_tile_image : require
precision highp float;
precision highp int;
layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;

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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;

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
    for (int i = 0; i < 32; ++i)
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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp uattachmentEXT colorIn0;
layout( location = 0 ) out highp uvec2 out0;

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
layout( location = 0 ) flat in uint patchIndex;
layout( location = 0 ) tileImageEXT highp iattachmentEXT colorIn0;
layout( location = 0 ) out highp ivec2 out0;

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
}
