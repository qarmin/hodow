#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 1) in  vec4 in_color;
layout(location = 0) out vec4 o_color;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
    o_color     = in_color;
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 o_color;

void main(void)
{
    o_color = vec4(in_color);
}
#version 450

layout(location = 0) in  vec4  in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == vec4(0, 0, 1, 1))
            ++clearColorCount;
        else if (color == vec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba8) uniform image2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == vec4(0, 0, 1, 1))
            ++clearColorCount;
        else if (color == vec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba8) uniform image2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == vec4(0, 0, 1, 1))
            ++clearColorCount;
        else if (color == vec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba8) uniform image2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == vec4(0, 0, 1, 1))
            ++clearColorCount;
        else if (color == vec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba8) uniform image2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == vec4(0, 0, 1, 1))
            ++clearColorCount;
        else if (color == vec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba8) uniform image2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == vec4(0, 0, 1, 1))
            ++clearColorCount;
        else if (color == vec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba8) uniform image2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform sampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == vec4(0, 0, 1, 1))
            ++clearColorCount;
        else if (color == vec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba8) uniform image2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform sampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == vec4(0, 0, 1, 1))
            ++clearColorCount;
        else if (color == vec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba8) uniform image2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform sampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == vec4(0, 0, 1, 1))
            ++clearColorCount;
        else if (color == vec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba8) uniform image2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform sampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == vec4(0, 0, 1, 1))
            ++clearColorCount;
        else if (color == vec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba8) uniform image2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform sampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == vec4(0, 0, 1, 1))
            ++clearColorCount;
        else if (color == vec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba8) uniform image2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform sampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == vec4(0, 0, 1, 1))
            ++clearColorCount;
        else if (color == vec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba8) uniform image2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out uint o_color;

void main(void)
{
    o_color = uint(in_color.r);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform usampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == uvec4(16, 0, 0, 1))
            ++clearColorCount;
        else if (color == uvec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, r32ui) uniform uimage2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    uvec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform usampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == uvec4(16, 0, 0, 1))
            ++clearColorCount;
        else if (color == uvec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, r32ui) uniform uimage2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    uvec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform usampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == uvec4(16, 0, 0, 1))
            ++clearColorCount;
        else if (color == uvec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, r32ui) uniform uimage2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    uvec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform usampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == uvec4(16, 0, 0, 1))
            ++clearColorCount;
        else if (color == uvec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, r32ui) uniform uimage2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    uvec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform usampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == uvec4(16, 0, 0, 1))
            ++clearColorCount;
        else if (color == uvec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, r32ui) uniform uimage2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    uvec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform usampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == uvec4(16, 0, 0, 1))
            ++clearColorCount;
        else if (color == uvec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, r32ui) uniform uimage2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    uvec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform usampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == uvec4(16, 0, 0, 1))
            ++clearColorCount;
        else if (color == uvec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, r32ui) uniform uimage2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    uvec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform usampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == uvec4(16, 0, 0, 1))
            ++clearColorCount;
        else if (color == uvec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, r32ui) uniform uimage2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    uvec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform usampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == uvec4(16, 0, 0, 1))
            ++clearColorCount;
        else if (color == uvec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, r32ui) uniform uimage2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    uvec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform usampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == uvec4(16, 0, 0, 1))
            ++clearColorCount;
        else if (color == uvec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, r32ui) uniform uimage2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    uvec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform usampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == uvec4(16, 0, 0, 1))
            ++clearColorCount;
        else if (color == uvec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, r32ui) uniform uimage2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    uvec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform usampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == uvec4(16, 0, 0, 1))
            ++clearColorCount;
        else if (color == uvec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, r32ui) uniform uimage2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    uvec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out ivec2 o_color;

void main(void)
{
    o_color = ivec2(in_color.rg);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform isampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == ivec4(16, 32, 0, 1))
            ++clearColorCount;
        else if (color == ivec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rg16i) uniform iimage2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    ivec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform isampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == ivec4(16, 32, 0, 1))
            ++clearColorCount;
        else if (color == ivec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rg16i) uniform iimage2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    ivec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform isampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == ivec4(16, 32, 0, 1))
            ++clearColorCount;
        else if (color == ivec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rg16i) uniform iimage2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    ivec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform isampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == ivec4(16, 32, 0, 1))
            ++clearColorCount;
        else if (color == ivec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rg16i) uniform iimage2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    ivec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform isampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == ivec4(16, 32, 0, 1))
            ++clearColorCount;
        else if (color == ivec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rg16i) uniform iimage2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    ivec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform isampler2DMS colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == ivec4(16, 32, 0, 1))
            ++clearColorCount;
        else if (color == ivec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rg16i) uniform iimage2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    ivec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform isampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == ivec4(16, 32, 0, 1))
            ++clearColorCount;
        else if (color == ivec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rg16i) uniform iimage2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    ivec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform isampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == ivec4(16, 32, 0, 1))
            ++clearColorCount;
        else if (color == ivec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rg16i) uniform iimage2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    ivec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform isampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == ivec4(16, 32, 0, 1))
            ++clearColorCount;
        else if (color == ivec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rg16i) uniform iimage2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    ivec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform isampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == ivec4(16, 32, 0, 1))
            ++clearColorCount;
        else if (color == ivec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rg16i) uniform iimage2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    ivec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform isampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == ivec4(16, 32, 0, 1))
            ++clearColorCount;
        else if (color == ivec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rg16i) uniform iimage2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    ivec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform isampler2DMSArray colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx)
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = texelFetch(colorTexture, ivec3(gl_FragCoord.xy, layerNdx), sampleNdx);
        if (color == ivec4(16, 32, 0, 1))
            ++clearColorCount;
        else if (color == ivec4(1, 0, 0, 1))
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rg16i) uniform iimage2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    ivec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform image2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform image2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform image2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform image2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform image2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform image2DMS u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec2(gx, gy), 0);
    for (int sampleNdx = 1; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec2(gx, gy), 0, prevColor);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform image2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform image2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform image2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform image2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform image2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450
layout(local_size_x = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform image2DMSArray u_msImage;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    vec4 prevColor = imageLoad(u_msImage, ivec3(gx, gy, gz), 0);
    for (int sampleNdx = 1; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, prevColor);
        prevColor = color;
    }
    imageStore(u_msImage, ivec3(gx, gy, gz), 0, prevColor);
}
#version 450

layout(location = 0) out uint o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint result = 0;
    vec4 a, b;

#if 2 > 0
    a = texelFetch(colorTexture, ivec2(0,0), 0);
    b = vec4(0, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 1
    a = texelFetch(colorTexture, ivec2(0,0), 1);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 2
    a = texelFetch(colorTexture, ivec2(0,0), 2);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 3
    a = texelFetch(colorTexture, ivec2(0,0), 3);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 4
    a = texelFetch(colorTexture, ivec2(0,0), 4);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 5
    a = texelFetch(colorTexture, ivec2(0,0), 5);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 6
    a = texelFetch(colorTexture, ivec2(0,0), 6);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 7
    a = texelFetch(colorTexture, ivec2(0,0), 7);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 8
    a = texelFetch(colorTexture, ivec2(0,0), 8);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 9
    a = texelFetch(colorTexture, ivec2(0,0), 9);
    b = vec4(1, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 10
    a = texelFetch(colorTexture, ivec2(0,0), 10);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 11
    a = texelFetch(colorTexture, ivec2(0,0), 11);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 12
    a = texelFetch(colorTexture, ivec2(0,0), 12);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 13
    a = texelFetch(colorTexture, ivec2(0,0), 13);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 14
    a = texelFetch(colorTexture, ivec2(0,0), 14);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 15
    a = texelFetch(colorTexture, ivec2(0,0), 15);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 16
    a = texelFetch(colorTexture, ivec2(0,0), 16);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 17
    a = texelFetch(colorTexture, ivec2(0,0), 17);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 18
    a = texelFetch(colorTexture, ivec2(0,0), 18);
    b = vec4(0, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 19
    a = texelFetch(colorTexture, ivec2(0,0), 19);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 20
    a = texelFetch(colorTexture, ivec2(0,0), 20);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 21
    a = texelFetch(colorTexture, ivec2(0,0), 21);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 22
    a = texelFetch(colorTexture, ivec2(0,0), 22);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 23
    a = texelFetch(colorTexture, ivec2(0,0), 23);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 24
    a = texelFetch(colorTexture, ivec2(0,0), 24);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 25
    a = texelFetch(colorTexture, ivec2(0,0), 25);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 26
    a = texelFetch(colorTexture, ivec2(0,0), 26);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 27
    a = texelFetch(colorTexture, ivec2(0,0), 27);
    b = vec4(1, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 28
    a = texelFetch(colorTexture, ivec2(0,0), 28);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 29
    a = texelFetch(colorTexture, ivec2(0,0), 29);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 30
    a = texelFetch(colorTexture, ivec2(0,0), 30);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 31
    a = texelFetch(colorTexture, ivec2(0,0), 31);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 32
    a = texelFetch(colorTexture, ivec2(0,0), 32);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 33
    a = texelFetch(colorTexture, ivec2(0,0), 33);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 34
    a = texelFetch(colorTexture, ivec2(0,0), 34);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 35
    a = texelFetch(colorTexture, ivec2(0,0), 35);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 36
    a = texelFetch(colorTexture, ivec2(0,0), 36);
    b = vec4(0, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 37
    a = texelFetch(colorTexture, ivec2(0,0), 37);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 38
    a = texelFetch(colorTexture, ivec2(0,0), 38);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 39
    a = texelFetch(colorTexture, ivec2(0,0), 39);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 40
    a = texelFetch(colorTexture, ivec2(0,0), 40);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 41
    a = texelFetch(colorTexture, ivec2(0,0), 41);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 42
    a = texelFetch(colorTexture, ivec2(0,0), 42);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 43
    a = texelFetch(colorTexture, ivec2(0,0), 43);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 44
    a = texelFetch(colorTexture, ivec2(0,0), 44);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 45
    a = texelFetch(colorTexture, ivec2(0,0), 45);
    b = vec4(1, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 46
    a = texelFetch(colorTexture, ivec2(0,0), 46);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 47
    a = texelFetch(colorTexture, ivec2(0,0), 47);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 48
    a = texelFetch(colorTexture, ivec2(0,0), 48);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 49
    a = texelFetch(colorTexture, ivec2(0,0), 49);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 50
    a = texelFetch(colorTexture, ivec2(0,0), 50);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 51
    a = texelFetch(colorTexture, ivec2(0,0), 51);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 52
    a = texelFetch(colorTexture, ivec2(0,0), 52);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 53
    a = texelFetch(colorTexture, ivec2(0,0), 53);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 54
    a = texelFetch(colorTexture, ivec2(0,0), 54);
    b = vec4(0, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 55
    a = texelFetch(colorTexture, ivec2(0,0), 55);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 56
    a = texelFetch(colorTexture, ivec2(0,0), 56);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 57
    a = texelFetch(colorTexture, ivec2(0,0), 57);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 58
    a = texelFetch(colorTexture, ivec2(0,0), 58);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 59
    a = texelFetch(colorTexture, ivec2(0,0), 59);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 60
    a = texelFetch(colorTexture, ivec2(0,0), 60);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 61
    a = texelFetch(colorTexture, ivec2(0,0), 61);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 62
    a = texelFetch(colorTexture, ivec2(0,0), 62);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 2 > 63
    a = texelFetch(colorTexture, ivec2(0,0), 63);
    b = vec4(1, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif

    o_status = result;
}
#version 450

layout(location = 0) out uint o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint result = 0;
    vec4 a, b;

#if 4 > 0
    a = texelFetch(colorTexture, ivec2(0,0), 0);
    b = vec4(0, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 1
    a = texelFetch(colorTexture, ivec2(0,0), 1);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 2
    a = texelFetch(colorTexture, ivec2(0,0), 2);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 3
    a = texelFetch(colorTexture, ivec2(0,0), 3);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 4
    a = texelFetch(colorTexture, ivec2(0,0), 4);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 5
    a = texelFetch(colorTexture, ivec2(0,0), 5);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 6
    a = texelFetch(colorTexture, ivec2(0,0), 6);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 7
    a = texelFetch(colorTexture, ivec2(0,0), 7);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 8
    a = texelFetch(colorTexture, ivec2(0,0), 8);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 9
    a = texelFetch(colorTexture, ivec2(0,0), 9);
    b = vec4(1, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 10
    a = texelFetch(colorTexture, ivec2(0,0), 10);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 11
    a = texelFetch(colorTexture, ivec2(0,0), 11);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 12
    a = texelFetch(colorTexture, ivec2(0,0), 12);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 13
    a = texelFetch(colorTexture, ivec2(0,0), 13);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 14
    a = texelFetch(colorTexture, ivec2(0,0), 14);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 15
    a = texelFetch(colorTexture, ivec2(0,0), 15);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 16
    a = texelFetch(colorTexture, ivec2(0,0), 16);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 17
    a = texelFetch(colorTexture, ivec2(0,0), 17);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 18
    a = texelFetch(colorTexture, ivec2(0,0), 18);
    b = vec4(0, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 19
    a = texelFetch(colorTexture, ivec2(0,0), 19);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 20
    a = texelFetch(colorTexture, ivec2(0,0), 20);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 21
    a = texelFetch(colorTexture, ivec2(0,0), 21);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 22
    a = texelFetch(colorTexture, ivec2(0,0), 22);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 23
    a = texelFetch(colorTexture, ivec2(0,0), 23);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 24
    a = texelFetch(colorTexture, ivec2(0,0), 24);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 25
    a = texelFetch(colorTexture, ivec2(0,0), 25);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 26
    a = texelFetch(colorTexture, ivec2(0,0), 26);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 27
    a = texelFetch(colorTexture, ivec2(0,0), 27);
    b = vec4(1, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 28
    a = texelFetch(colorTexture, ivec2(0,0), 28);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 29
    a = texelFetch(colorTexture, ivec2(0,0), 29);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 30
    a = texelFetch(colorTexture, ivec2(0,0), 30);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 31
    a = texelFetch(colorTexture, ivec2(0,0), 31);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 32
    a = texelFetch(colorTexture, ivec2(0,0), 32);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 33
    a = texelFetch(colorTexture, ivec2(0,0), 33);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 34
    a = texelFetch(colorTexture, ivec2(0,0), 34);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 35
    a = texelFetch(colorTexture, ivec2(0,0), 35);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 36
    a = texelFetch(colorTexture, ivec2(0,0), 36);
    b = vec4(0, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 37
    a = texelFetch(colorTexture, ivec2(0,0), 37);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 38
    a = texelFetch(colorTexture, ivec2(0,0), 38);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 39
    a = texelFetch(colorTexture, ivec2(0,0), 39);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 40
    a = texelFetch(colorTexture, ivec2(0,0), 40);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 41
    a = texelFetch(colorTexture, ivec2(0,0), 41);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 42
    a = texelFetch(colorTexture, ivec2(0,0), 42);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 43
    a = texelFetch(colorTexture, ivec2(0,0), 43);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 44
    a = texelFetch(colorTexture, ivec2(0,0), 44);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 45
    a = texelFetch(colorTexture, ivec2(0,0), 45);
    b = vec4(1, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 46
    a = texelFetch(colorTexture, ivec2(0,0), 46);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 47
    a = texelFetch(colorTexture, ivec2(0,0), 47);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 48
    a = texelFetch(colorTexture, ivec2(0,0), 48);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 49
    a = texelFetch(colorTexture, ivec2(0,0), 49);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 50
    a = texelFetch(colorTexture, ivec2(0,0), 50);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 51
    a = texelFetch(colorTexture, ivec2(0,0), 51);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 52
    a = texelFetch(colorTexture, ivec2(0,0), 52);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 53
    a = texelFetch(colorTexture, ivec2(0,0), 53);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 54
    a = texelFetch(colorTexture, ivec2(0,0), 54);
    b = vec4(0, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 55
    a = texelFetch(colorTexture, ivec2(0,0), 55);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 56
    a = texelFetch(colorTexture, ivec2(0,0), 56);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 57
    a = texelFetch(colorTexture, ivec2(0,0), 57);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 58
    a = texelFetch(colorTexture, ivec2(0,0), 58);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 59
    a = texelFetch(colorTexture, ivec2(0,0), 59);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 60
    a = texelFetch(colorTexture, ivec2(0,0), 60);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 61
    a = texelFetch(colorTexture, ivec2(0,0), 61);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 62
    a = texelFetch(colorTexture, ivec2(0,0), 62);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 4 > 63
    a = texelFetch(colorTexture, ivec2(0,0), 63);
    b = vec4(1, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif

    o_status = result;
}
#version 450

layout(location = 0) out uint o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint result = 0;
    vec4 a, b;

#if 8 > 0
    a = texelFetch(colorTexture, ivec2(0,0), 0);
    b = vec4(0, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 1
    a = texelFetch(colorTexture, ivec2(0,0), 1);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 2
    a = texelFetch(colorTexture, ivec2(0,0), 2);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 3
    a = texelFetch(colorTexture, ivec2(0,0), 3);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 4
    a = texelFetch(colorTexture, ivec2(0,0), 4);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 5
    a = texelFetch(colorTexture, ivec2(0,0), 5);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 6
    a = texelFetch(colorTexture, ivec2(0,0), 6);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 7
    a = texelFetch(colorTexture, ivec2(0,0), 7);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 8
    a = texelFetch(colorTexture, ivec2(0,0), 8);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 9
    a = texelFetch(colorTexture, ivec2(0,0), 9);
    b = vec4(1, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 10
    a = texelFetch(colorTexture, ivec2(0,0), 10);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 11
    a = texelFetch(colorTexture, ivec2(0,0), 11);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 12
    a = texelFetch(colorTexture, ivec2(0,0), 12);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 13
    a = texelFetch(colorTexture, ivec2(0,0), 13);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 14
    a = texelFetch(colorTexture, ivec2(0,0), 14);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 15
    a = texelFetch(colorTexture, ivec2(0,0), 15);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 16
    a = texelFetch(colorTexture, ivec2(0,0), 16);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 17
    a = texelFetch(colorTexture, ivec2(0,0), 17);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 18
    a = texelFetch(colorTexture, ivec2(0,0), 18);
    b = vec4(0, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 19
    a = texelFetch(colorTexture, ivec2(0,0), 19);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 20
    a = texelFetch(colorTexture, ivec2(0,0), 20);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 21
    a = texelFetch(colorTexture, ivec2(0,0), 21);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 22
    a = texelFetch(colorTexture, ivec2(0,0), 22);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 23
    a = texelFetch(colorTexture, ivec2(0,0), 23);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 24
    a = texelFetch(colorTexture, ivec2(0,0), 24);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 25
    a = texelFetch(colorTexture, ivec2(0,0), 25);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 26
    a = texelFetch(colorTexture, ivec2(0,0), 26);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 27
    a = texelFetch(colorTexture, ivec2(0,0), 27);
    b = vec4(1, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 28
    a = texelFetch(colorTexture, ivec2(0,0), 28);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 29
    a = texelFetch(colorTexture, ivec2(0,0), 29);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 30
    a = texelFetch(colorTexture, ivec2(0,0), 30);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 31
    a = texelFetch(colorTexture, ivec2(0,0), 31);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 32
    a = texelFetch(colorTexture, ivec2(0,0), 32);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 33
    a = texelFetch(colorTexture, ivec2(0,0), 33);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 34
    a = texelFetch(colorTexture, ivec2(0,0), 34);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 35
    a = texelFetch(colorTexture, ivec2(0,0), 35);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 36
    a = texelFetch(colorTexture, ivec2(0,0), 36);
    b = vec4(0, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 37
    a = texelFetch(colorTexture, ivec2(0,0), 37);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 38
    a = texelFetch(colorTexture, ivec2(0,0), 38);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 39
    a = texelFetch(colorTexture, ivec2(0,0), 39);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 40
    a = texelFetch(colorTexture, ivec2(0,0), 40);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 41
    a = texelFetch(colorTexture, ivec2(0,0), 41);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 42
    a = texelFetch(colorTexture, ivec2(0,0), 42);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 43
    a = texelFetch(colorTexture, ivec2(0,0), 43);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 44
    a = texelFetch(colorTexture, ivec2(0,0), 44);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 45
    a = texelFetch(colorTexture, ivec2(0,0), 45);
    b = vec4(1, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 46
    a = texelFetch(colorTexture, ivec2(0,0), 46);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 47
    a = texelFetch(colorTexture, ivec2(0,0), 47);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 48
    a = texelFetch(colorTexture, ivec2(0,0), 48);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 49
    a = texelFetch(colorTexture, ivec2(0,0), 49);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 50
    a = texelFetch(colorTexture, ivec2(0,0), 50);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 51
    a = texelFetch(colorTexture, ivec2(0,0), 51);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 52
    a = texelFetch(colorTexture, ivec2(0,0), 52);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 53
    a = texelFetch(colorTexture, ivec2(0,0), 53);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 54
    a = texelFetch(colorTexture, ivec2(0,0), 54);
    b = vec4(0, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 55
    a = texelFetch(colorTexture, ivec2(0,0), 55);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 56
    a = texelFetch(colorTexture, ivec2(0,0), 56);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 57
    a = texelFetch(colorTexture, ivec2(0,0), 57);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 58
    a = texelFetch(colorTexture, ivec2(0,0), 58);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 59
    a = texelFetch(colorTexture, ivec2(0,0), 59);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 60
    a = texelFetch(colorTexture, ivec2(0,0), 60);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 61
    a = texelFetch(colorTexture, ivec2(0,0), 61);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 62
    a = texelFetch(colorTexture, ivec2(0,0), 62);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 8 > 63
    a = texelFetch(colorTexture, ivec2(0,0), 63);
    b = vec4(1, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif

    o_status = result;
}
#version 450

layout(location = 0) out uint o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint result = 0;
    vec4 a, b;

#if 16 > 0
    a = texelFetch(colorTexture, ivec2(0,0), 0);
    b = vec4(0, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 1
    a = texelFetch(colorTexture, ivec2(0,0), 1);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 2
    a = texelFetch(colorTexture, ivec2(0,0), 2);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 3
    a = texelFetch(colorTexture, ivec2(0,0), 3);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 4
    a = texelFetch(colorTexture, ivec2(0,0), 4);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 5
    a = texelFetch(colorTexture, ivec2(0,0), 5);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 6
    a = texelFetch(colorTexture, ivec2(0,0), 6);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 7
    a = texelFetch(colorTexture, ivec2(0,0), 7);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 8
    a = texelFetch(colorTexture, ivec2(0,0), 8);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 9
    a = texelFetch(colorTexture, ivec2(0,0), 9);
    b = vec4(1, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 10
    a = texelFetch(colorTexture, ivec2(0,0), 10);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 11
    a = texelFetch(colorTexture, ivec2(0,0), 11);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 12
    a = texelFetch(colorTexture, ivec2(0,0), 12);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 13
    a = texelFetch(colorTexture, ivec2(0,0), 13);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 14
    a = texelFetch(colorTexture, ivec2(0,0), 14);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 15
    a = texelFetch(colorTexture, ivec2(0,0), 15);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 16
    a = texelFetch(colorTexture, ivec2(0,0), 16);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 17
    a = texelFetch(colorTexture, ivec2(0,0), 17);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 18
    a = texelFetch(colorTexture, ivec2(0,0), 18);
    b = vec4(0, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 19
    a = texelFetch(colorTexture, ivec2(0,0), 19);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 20
    a = texelFetch(colorTexture, ivec2(0,0), 20);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 21
    a = texelFetch(colorTexture, ivec2(0,0), 21);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 22
    a = texelFetch(colorTexture, ivec2(0,0), 22);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 23
    a = texelFetch(colorTexture, ivec2(0,0), 23);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 24
    a = texelFetch(colorTexture, ivec2(0,0), 24);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 25
    a = texelFetch(colorTexture, ivec2(0,0), 25);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 26
    a = texelFetch(colorTexture, ivec2(0,0), 26);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 27
    a = texelFetch(colorTexture, ivec2(0,0), 27);
    b = vec4(1, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 28
    a = texelFetch(colorTexture, ivec2(0,0), 28);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 29
    a = texelFetch(colorTexture, ivec2(0,0), 29);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 30
    a = texelFetch(colorTexture, ivec2(0,0), 30);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 31
    a = texelFetch(colorTexture, ivec2(0,0), 31);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 32
    a = texelFetch(colorTexture, ivec2(0,0), 32);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 33
    a = texelFetch(colorTexture, ivec2(0,0), 33);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 34
    a = texelFetch(colorTexture, ivec2(0,0), 34);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 35
    a = texelFetch(colorTexture, ivec2(0,0), 35);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 36
    a = texelFetch(colorTexture, ivec2(0,0), 36);
    b = vec4(0, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 37
    a = texelFetch(colorTexture, ivec2(0,0), 37);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 38
    a = texelFetch(colorTexture, ivec2(0,0), 38);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 39
    a = texelFetch(colorTexture, ivec2(0,0), 39);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 40
    a = texelFetch(colorTexture, ivec2(0,0), 40);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 41
    a = texelFetch(colorTexture, ivec2(0,0), 41);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 42
    a = texelFetch(colorTexture, ivec2(0,0), 42);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 43
    a = texelFetch(colorTexture, ivec2(0,0), 43);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 44
    a = texelFetch(colorTexture, ivec2(0,0), 44);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 45
    a = texelFetch(colorTexture, ivec2(0,0), 45);
    b = vec4(1, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 46
    a = texelFetch(colorTexture, ivec2(0,0), 46);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 47
    a = texelFetch(colorTexture, ivec2(0,0), 47);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 48
    a = texelFetch(colorTexture, ivec2(0,0), 48);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 49
    a = texelFetch(colorTexture, ivec2(0,0), 49);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 50
    a = texelFetch(colorTexture, ivec2(0,0), 50);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 51
    a = texelFetch(colorTexture, ivec2(0,0), 51);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 52
    a = texelFetch(colorTexture, ivec2(0,0), 52);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 53
    a = texelFetch(colorTexture, ivec2(0,0), 53);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 54
    a = texelFetch(colorTexture, ivec2(0,0), 54);
    b = vec4(0, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 55
    a = texelFetch(colorTexture, ivec2(0,0), 55);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 56
    a = texelFetch(colorTexture, ivec2(0,0), 56);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 57
    a = texelFetch(colorTexture, ivec2(0,0), 57);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 58
    a = texelFetch(colorTexture, ivec2(0,0), 58);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 59
    a = texelFetch(colorTexture, ivec2(0,0), 59);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 60
    a = texelFetch(colorTexture, ivec2(0,0), 60);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 61
    a = texelFetch(colorTexture, ivec2(0,0), 61);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 62
    a = texelFetch(colorTexture, ivec2(0,0), 62);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 16 > 63
    a = texelFetch(colorTexture, ivec2(0,0), 63);
    b = vec4(1, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif

    o_status = result;
}
#version 450

layout(location = 0) out uint o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint result = 0;
    vec4 a, b;

#if 32 > 0
    a = texelFetch(colorTexture, ivec2(0,0), 0);
    b = vec4(0, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 1
    a = texelFetch(colorTexture, ivec2(0,0), 1);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 2
    a = texelFetch(colorTexture, ivec2(0,0), 2);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 3
    a = texelFetch(colorTexture, ivec2(0,0), 3);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 4
    a = texelFetch(colorTexture, ivec2(0,0), 4);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 5
    a = texelFetch(colorTexture, ivec2(0,0), 5);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 6
    a = texelFetch(colorTexture, ivec2(0,0), 6);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 7
    a = texelFetch(colorTexture, ivec2(0,0), 7);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 8
    a = texelFetch(colorTexture, ivec2(0,0), 8);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 9
    a = texelFetch(colorTexture, ivec2(0,0), 9);
    b = vec4(1, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 10
    a = texelFetch(colorTexture, ivec2(0,0), 10);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 11
    a = texelFetch(colorTexture, ivec2(0,0), 11);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 12
    a = texelFetch(colorTexture, ivec2(0,0), 12);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 13
    a = texelFetch(colorTexture, ivec2(0,0), 13);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 14
    a = texelFetch(colorTexture, ivec2(0,0), 14);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 15
    a = texelFetch(colorTexture, ivec2(0,0), 15);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 16
    a = texelFetch(colorTexture, ivec2(0,0), 16);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 17
    a = texelFetch(colorTexture, ivec2(0,0), 17);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 18
    a = texelFetch(colorTexture, ivec2(0,0), 18);
    b = vec4(0, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 19
    a = texelFetch(colorTexture, ivec2(0,0), 19);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 20
    a = texelFetch(colorTexture, ivec2(0,0), 20);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 21
    a = texelFetch(colorTexture, ivec2(0,0), 21);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 22
    a = texelFetch(colorTexture, ivec2(0,0), 22);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 23
    a = texelFetch(colorTexture, ivec2(0,0), 23);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 24
    a = texelFetch(colorTexture, ivec2(0,0), 24);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 25
    a = texelFetch(colorTexture, ivec2(0,0), 25);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 26
    a = texelFetch(colorTexture, ivec2(0,0), 26);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 27
    a = texelFetch(colorTexture, ivec2(0,0), 27);
    b = vec4(1, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 28
    a = texelFetch(colorTexture, ivec2(0,0), 28);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 29
    a = texelFetch(colorTexture, ivec2(0,0), 29);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 30
    a = texelFetch(colorTexture, ivec2(0,0), 30);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 31
    a = texelFetch(colorTexture, ivec2(0,0), 31);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 32
    a = texelFetch(colorTexture, ivec2(0,0), 32);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 33
    a = texelFetch(colorTexture, ivec2(0,0), 33);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 34
    a = texelFetch(colorTexture, ivec2(0,0), 34);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 35
    a = texelFetch(colorTexture, ivec2(0,0), 35);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 36
    a = texelFetch(colorTexture, ivec2(0,0), 36);
    b = vec4(0, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 37
    a = texelFetch(colorTexture, ivec2(0,0), 37);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 38
    a = texelFetch(colorTexture, ivec2(0,0), 38);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 39
    a = texelFetch(colorTexture, ivec2(0,0), 39);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 40
    a = texelFetch(colorTexture, ivec2(0,0), 40);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 41
    a = texelFetch(colorTexture, ivec2(0,0), 41);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 42
    a = texelFetch(colorTexture, ivec2(0,0), 42);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 43
    a = texelFetch(colorTexture, ivec2(0,0), 43);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 44
    a = texelFetch(colorTexture, ivec2(0,0), 44);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 45
    a = texelFetch(colorTexture, ivec2(0,0), 45);
    b = vec4(1, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 46
    a = texelFetch(colorTexture, ivec2(0,0), 46);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 47
    a = texelFetch(colorTexture, ivec2(0,0), 47);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 48
    a = texelFetch(colorTexture, ivec2(0,0), 48);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 49
    a = texelFetch(colorTexture, ivec2(0,0), 49);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 50
    a = texelFetch(colorTexture, ivec2(0,0), 50);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 51
    a = texelFetch(colorTexture, ivec2(0,0), 51);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 52
    a = texelFetch(colorTexture, ivec2(0,0), 52);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 53
    a = texelFetch(colorTexture, ivec2(0,0), 53);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 54
    a = texelFetch(colorTexture, ivec2(0,0), 54);
    b = vec4(0, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 55
    a = texelFetch(colorTexture, ivec2(0,0), 55);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 56
    a = texelFetch(colorTexture, ivec2(0,0), 56);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 57
    a = texelFetch(colorTexture, ivec2(0,0), 57);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 58
    a = texelFetch(colorTexture, ivec2(0,0), 58);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 59
    a = texelFetch(colorTexture, ivec2(0,0), 59);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 60
    a = texelFetch(colorTexture, ivec2(0,0), 60);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 61
    a = texelFetch(colorTexture, ivec2(0,0), 61);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 62
    a = texelFetch(colorTexture, ivec2(0,0), 62);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 32 > 63
    a = texelFetch(colorTexture, ivec2(0,0), 63);
    b = vec4(1, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif

    o_status = result;
}
#version 450

layout(location = 0) out uint o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint result = 0;
    vec4 a, b;

#if 64 > 0
    a = texelFetch(colorTexture, ivec2(0,0), 0);
    b = vec4(0, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 1
    a = texelFetch(colorTexture, ivec2(0,0), 1);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 2
    a = texelFetch(colorTexture, ivec2(0,0), 2);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 3
    a = texelFetch(colorTexture, ivec2(0,0), 3);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 4
    a = texelFetch(colorTexture, ivec2(0,0), 4);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 5
    a = texelFetch(colorTexture, ivec2(0,0), 5);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 6
    a = texelFetch(colorTexture, ivec2(0,0), 6);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 7
    a = texelFetch(colorTexture, ivec2(0,0), 7);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 8
    a = texelFetch(colorTexture, ivec2(0,0), 8);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 9
    a = texelFetch(colorTexture, ivec2(0,0), 9);
    b = vec4(1, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 10
    a = texelFetch(colorTexture, ivec2(0,0), 10);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 11
    a = texelFetch(colorTexture, ivec2(0,0), 11);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 12
    a = texelFetch(colorTexture, ivec2(0,0), 12);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 13
    a = texelFetch(colorTexture, ivec2(0,0), 13);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 14
    a = texelFetch(colorTexture, ivec2(0,0), 14);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 15
    a = texelFetch(colorTexture, ivec2(0,0), 15);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 16
    a = texelFetch(colorTexture, ivec2(0,0), 16);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 17
    a = texelFetch(colorTexture, ivec2(0,0), 17);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 18
    a = texelFetch(colorTexture, ivec2(0,0), 18);
    b = vec4(0, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 19
    a = texelFetch(colorTexture, ivec2(0,0), 19);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 20
    a = texelFetch(colorTexture, ivec2(0,0), 20);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 21
    a = texelFetch(colorTexture, ivec2(0,0), 21);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 22
    a = texelFetch(colorTexture, ivec2(0,0), 22);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 23
    a = texelFetch(colorTexture, ivec2(0,0), 23);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 24
    a = texelFetch(colorTexture, ivec2(0,0), 24);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 25
    a = texelFetch(colorTexture, ivec2(0,0), 25);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 26
    a = texelFetch(colorTexture, ivec2(0,0), 26);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 27
    a = texelFetch(colorTexture, ivec2(0,0), 27);
    b = vec4(1, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 28
    a = texelFetch(colorTexture, ivec2(0,0), 28);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 29
    a = texelFetch(colorTexture, ivec2(0,0), 29);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 30
    a = texelFetch(colorTexture, ivec2(0,0), 30);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 31
    a = texelFetch(colorTexture, ivec2(0,0), 31);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 32
    a = texelFetch(colorTexture, ivec2(0,0), 32);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 33
    a = texelFetch(colorTexture, ivec2(0,0), 33);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 34
    a = texelFetch(colorTexture, ivec2(0,0), 34);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 35
    a = texelFetch(colorTexture, ivec2(0,0), 35);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 36
    a = texelFetch(colorTexture, ivec2(0,0), 36);
    b = vec4(0, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 37
    a = texelFetch(colorTexture, ivec2(0,0), 37);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 38
    a = texelFetch(colorTexture, ivec2(0,0), 38);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 39
    a = texelFetch(colorTexture, ivec2(0,0), 39);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 40
    a = texelFetch(colorTexture, ivec2(0,0), 40);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 41
    a = texelFetch(colorTexture, ivec2(0,0), 41);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 42
    a = texelFetch(colorTexture, ivec2(0,0), 42);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 43
    a = texelFetch(colorTexture, ivec2(0,0), 43);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 44
    a = texelFetch(colorTexture, ivec2(0,0), 44);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 45
    a = texelFetch(colorTexture, ivec2(0,0), 45);
    b = vec4(1, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 46
    a = texelFetch(colorTexture, ivec2(0,0), 46);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 47
    a = texelFetch(colorTexture, ivec2(0,0), 47);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 48
    a = texelFetch(colorTexture, ivec2(0,0), 48);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 49
    a = texelFetch(colorTexture, ivec2(0,0), 49);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 50
    a = texelFetch(colorTexture, ivec2(0,0), 50);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 51
    a = texelFetch(colorTexture, ivec2(0,0), 51);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 52
    a = texelFetch(colorTexture, ivec2(0,0), 52);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 53
    a = texelFetch(colorTexture, ivec2(0,0), 53);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 54
    a = texelFetch(colorTexture, ivec2(0,0), 54);
    b = vec4(0, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 55
    a = texelFetch(colorTexture, ivec2(0,0), 55);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 56
    a = texelFetch(colorTexture, ivec2(0,0), 56);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 57
    a = texelFetch(colorTexture, ivec2(0,0), 57);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 58
    a = texelFetch(colorTexture, ivec2(0,0), 58);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 59
    a = texelFetch(colorTexture, ivec2(0,0), 59);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 60
    a = texelFetch(colorTexture, ivec2(0,0), 60);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 61
    a = texelFetch(colorTexture, ivec2(0,0), 61);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 62
    a = texelFetch(colorTexture, ivec2(0,0), 62);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if 64 > 63
    a = texelFetch(colorTexture, ivec2(0,0), 63);
    b = vec4(1, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif

    o_status = result;
}
#version 450
void main(void) {
    gl_Position = vec4(float(gl_VertexIndex & 1) * 2.0 - 1.0,
                       float((gl_VertexIndex >> 1) & 1) * 2.0 - 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out vec4 outColor;
void main(void) {
    outColor = vec4(gl_FragCoord.xy / 16.0, gl_SampleID / 64.0, 1.0);
}
#version 450
#extension GL_EXT_samplerless_texture_functions : enable
layout(local_size_x = 16, local_size_y = 16) in;
layout(set = 0, binding = 0) uniform texture2DMS inputImage;
layout(set = 0, binding = 1) buffer Data { float v[]; };
void main()
{
  ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
  float samplesMulSum = 0.1;
  for (int i = 1 ; i < 2 ; i++) {
      vec4 currSample = texelFetch(inputImage, uv, i);
      // to make sure samples are in same order for each fragment we calculate
      // weighted sum of z component of all samples and later on host check if
      // same value was caluclated for all fragments
      samplesMulSum += float(i) * currSample.z;
  }
  v[gl_LocalInvocationIndex] = samplesMulSum;
}
#version 450
#extension GL_EXT_samplerless_texture_functions : enable
layout(local_size_x = 16, local_size_y = 16) in;
layout(set = 0, binding = 0) uniform texture2DMS inputImage;
layout(set = 0, binding = 1) buffer Data { float v[]; };
void main()
{
  ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
  float samplesMulSum = 0.1;
  for (int i = 1 ; i < 4 ; i++) {
      vec4 currSample = texelFetch(inputImage, uv, i);
      // to make sure samples are in same order for each fragment we calculate
      // weighted sum of z component of all samples and later on host check if
      // same value was caluclated for all fragments
      samplesMulSum += float(i) * currSample.z;
  }
  v[gl_LocalInvocationIndex] = samplesMulSum;
}
#version 450
#extension GL_EXT_samplerless_texture_functions : enable
layout(local_size_x = 16, local_size_y = 16) in;
layout(set = 0, binding = 0) uniform texture2DMS inputImage;
layout(set = 0, binding = 1) buffer Data { float v[]; };
void main()
{
  ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
  float samplesMulSum = 0.1;
  for (int i = 1 ; i < 8 ; i++) {
      vec4 currSample = texelFetch(inputImage, uv, i);
      // to make sure samples are in same order for each fragment we calculate
      // weighted sum of z component of all samples and later on host check if
      // same value was caluclated for all fragments
      samplesMulSum += float(i) * currSample.z;
  }
  v[gl_LocalInvocationIndex] = samplesMulSum;
}
#version 450
#extension GL_EXT_samplerless_texture_functions : enable
layout(local_size_x = 16, local_size_y = 16) in;
layout(set = 0, binding = 0) uniform texture2DMS inputImage;
layout(set = 0, binding = 1) buffer Data { float v[]; };
void main()
{
  ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
  float samplesMulSum = 0.1;
  for (int i = 1 ; i < 16 ; i++) {
      vec4 currSample = texelFetch(inputImage, uv, i);
      // to make sure samples are in same order for each fragment we calculate
      // weighted sum of z component of all samples and later on host check if
      // same value was caluclated for all fragments
      samplesMulSum += float(i) * currSample.z;
  }
  v[gl_LocalInvocationIndex] = samplesMulSum;
}
#version 450
#extension GL_EXT_samplerless_texture_functions : enable
layout(local_size_x = 16, local_size_y = 16) in;
layout(set = 0, binding = 0) uniform texture2DMS inputImage;
layout(set = 0, binding = 1) buffer Data { float v[]; };
void main()
{
  ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
  float samplesMulSum = 0.1;
  for (int i = 1 ; i < 32 ; i++) {
      vec4 currSample = texelFetch(inputImage, uv, i);
      // to make sure samples are in same order for each fragment we calculate
      // weighted sum of z component of all samples and later on host check if
      // same value was caluclated for all fragments
      samplesMulSum += float(i) * currSample.z;
  }
  v[gl_LocalInvocationIndex] = samplesMulSum;
}
#version 450
#extension GL_EXT_samplerless_texture_functions : enable
layout(local_size_x = 16, local_size_y = 16) in;
layout(set = 0, binding = 0) uniform texture2DMS inputImage;
layout(set = 0, binding = 1) buffer Data { float v[]; };
void main()
{
  ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
  float samplesMulSum = 0.1;
  for (int i = 1 ; i < 64 ; i++) {
      vec4 currSample = texelFetch(inputImage, uv, i);
      // to make sure samples are in same order for each fragment we calculate
      // weighted sum of z component of all samples and later on host check if
      // same value was caluclated for all fragments
      samplesMulSum += float(i) * currSample.z;
  }
  v[gl_LocalInvocationIndex] = samplesMulSum;
}
#version 450
layout(location = 0) in vec4 inPosition;
void main()
{
    gl_Position = inPosition;
}
#version 450
layout(location = 0) out vec4 outColor;

layout(push_constant) uniform PushConsts {
    int width;
    int height;
    int numSamples;
} pc;

void main()
{
    int s = gl_SampleID;

    float R = float(int(gl_FragCoord.x) + s) / float(pc.width + pc.numSamples);
    float G = float(int(gl_FragCoord.y) + s) / float(pc.height + pc.numSamples);
    float B = (pc.numSamples > 1) ? float(s) / float(pc.numSamples - 1) : 0.0;
    float A = 1.0f;

    outColor = vec4(R, G, B, A);
}
