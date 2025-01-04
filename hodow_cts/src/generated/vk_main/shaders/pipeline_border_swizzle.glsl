#version 450

void main()
{
    const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
    const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform sampler2D texSampler;

layout (location=0) out vec4 colorOut;

void main()
{
    const vec2 coords = vec2(u, v);

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 0);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
}
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform sampler2D texSampler;
layout (set=0, binding=1, rgba32f) writeonly uniform image2D outImage;

void main()
{
    const vec2 coords = vec2(u, v);
    vec4 colorOut;

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 0);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), colorOut);
}
#version 450

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform sampler2D texSampler;

layout (location=0) out vec4 colorOut;

void main()
{
    const vec2 coords = vec2(u, v);

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 1);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
}
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform sampler2D texSampler;
layout (set=0, binding=1, rgba32f) writeonly uniform image2D outImage;

void main()
{
    const vec2 coords = vec2(u, v);
    vec4 colorOut;

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 1);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), colorOut);
}
#version 450

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform sampler2D texSampler;

layout (location=0) out vec4 colorOut;

void main()
{
    const vec2 coords = vec2(u, v);

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 2);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
}
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform sampler2D texSampler;
layout (set=0, binding=1, rgba32f) writeonly uniform image2D outImage;

void main()
{
    const vec2 coords = vec2(u, v);
    vec4 colorOut;

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 2);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), colorOut);
}
#version 450

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform sampler2D texSampler;

layout (location=0) out vec4 colorOut;

void main()
{
    const vec2 coords = vec2(u, v);

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 3);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
}
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform sampler2D texSampler;
layout (set=0, binding=1, rgba32f) writeonly uniform image2D outImage;

void main()
{
    const vec2 coords = vec2(u, v);
    vec4 colorOut;

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 3);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), colorOut);
}
#version 450

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform isampler2D texSampler;

layout (location=0) out ivec4 colorOut;

void main()
{
    const vec2 coords = vec2(u, v);

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 0);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
}
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform isampler2D texSampler;
layout (set=0, binding=1, rgba32i) writeonly uniform iimage2D outImage;

void main()
{
    const vec2 coords = vec2(u, v);
    ivec4 colorOut;

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 0);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), colorOut);
}
#version 450

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform isampler2D texSampler;

layout (location=0) out ivec4 colorOut;

void main()
{
    const vec2 coords = vec2(u, v);

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 1);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
}
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform isampler2D texSampler;
layout (set=0, binding=1, rgba32i) writeonly uniform iimage2D outImage;

void main()
{
    const vec2 coords = vec2(u, v);
    ivec4 colorOut;

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 1);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), colorOut);
}
#version 450

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform isampler2D texSampler;

layout (location=0) out ivec4 colorOut;

void main()
{
    const vec2 coords = vec2(u, v);

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 2);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
}
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform isampler2D texSampler;
layout (set=0, binding=1, rgba32i) writeonly uniform iimage2D outImage;

void main()
{
    const vec2 coords = vec2(u, v);
    ivec4 colorOut;

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 2);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), colorOut);
}
#version 450

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform isampler2D texSampler;

layout (location=0) out ivec4 colorOut;

void main()
{
    const vec2 coords = vec2(u, v);

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 3);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
}
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform isampler2D texSampler;
layout (set=0, binding=1, rgba32i) writeonly uniform iimage2D outImage;

void main()
{
    const vec2 coords = vec2(u, v);
    ivec4 colorOut;

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 3);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), colorOut);
}
#version 450

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform usampler2D texSampler;

layout (location=0) out uvec4 colorOut;

void main()
{
    const vec2 coords = vec2(u, v);

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 0);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
}
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform usampler2D texSampler;
layout (set=0, binding=1, rgba32ui) writeonly uniform uimage2D outImage;

void main()
{
    const vec2 coords = vec2(u, v);
    uvec4 colorOut;

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 0);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), colorOut);
}
#version 450

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform usampler2D texSampler;

layout (location=0) out uvec4 colorOut;

void main()
{
    const vec2 coords = vec2(u, v);

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 1);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
}
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform usampler2D texSampler;
layout (set=0, binding=1, rgba32ui) writeonly uniform uimage2D outImage;

void main()
{
    const vec2 coords = vec2(u, v);
    uvec4 colorOut;

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 1);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), colorOut);
}
#version 450

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform usampler2D texSampler;

layout (location=0) out uvec4 colorOut;

void main()
{
    const vec2 coords = vec2(u, v);

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 2);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
}
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform usampler2D texSampler;
layout (set=0, binding=1, rgba32ui) writeonly uniform uimage2D outImage;

void main()
{
    const vec2 coords = vec2(u, v);
    uvec4 colorOut;

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 2);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), colorOut);
}
#version 450

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform usampler2D texSampler;

layout (location=0) out uvec4 colorOut;

void main()
{
    const vec2 coords = vec2(u, v);

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 3);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
}
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (constant_id=0) const float u = 0.0f;
layout (constant_id=1) const float v = 0.0f;
layout (constant_id=2) const int gatherFlag = 0;

layout (set=0, binding=0) uniform usampler2D texSampler;
layout (set=0, binding=1, rgba32ui) writeonly uniform uimage2D outImage;

void main()
{
    const vec2 coords = vec2(u, v);
    uvec4 colorOut;

    if (gatherFlag != 0)
    {
        colorOut = textureGather(texSampler, coords, 3);
    }
    else
    {
        colorOut = texture(texSampler, coords);
    }
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), colorOut);
}
