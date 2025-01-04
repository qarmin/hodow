#version 440
layout(location = 0) in vec4 vs_in_position_ndc;

out gl_PerVertex {
    vec4  gl_Position;
};
void main (void)
{
    gl_Position = vs_in_position_ndc;
}
#version 440

layout(location = 0) out vec4 fs_out_color;

layout(set = 0, binding = 0, input_attachment_index = 0) uniform subpassInputMS imageMS;

layout(set = 0, binding = 1, std140) uniform SampleBlock {
    int sampleNdx;
};
void main (void)
{
    fs_out_color = subpassLoad(imageMS, sampleNdx);
}
#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    fs_out_color = vec4(float(gl_SampleID) / float(255), 0.0, 0.0, 1.0);
}
#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    if (gl_SamplePosition.x < 0.0 || gl_SamplePosition.x > 1.0 || gl_SamplePosition.y < 0.0 || gl_SamplePosition.y > 1.0)
        fs_out_color = vec4(0.0, 0.0, 1.0, 1.0);
    else
        fs_out_color = vec4(gl_SamplePosition.x, gl_SamplePosition.y, 0.0, 1.0);
}
#version 440
layout(location = 0) in vec4 vs_in_position_ndc;
layout(location = 1) in vec2 vs_in_position_screen;

layout(location = 0) sample out vec2 vs_out_position_screen;

out gl_PerVertex {
    vec4  gl_Position;
};
void main (void)
{
    gl_Position = vs_in_position_ndc;
    vs_out_position_screen = vs_in_position_screen;
}
#version 440
layout(location = 0) sample in vec2 fs_in_position_screen;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.15625; // 4 subpixel bits. Assume 3 accurate bits + 0.03125 for other errors
    const ivec2 nearby_pixel = ivec2(floor(fs_in_position_screen));
    bool ok = false;

    // sample at edge + inaccuaries may cause us to round to any neighboring pixel
    // check all neighbors for any match
    for (int dy = -1; dy <= 1; ++dy)
    for (int dx = -1; dx <= 1; ++dx)
    {
        ivec2 current_pixel = nearby_pixel + ivec2(dx, dy);
        vec2 position_inside_pixel = vec2(current_pixel) + gl_SamplePosition;
        vec2 position_diff = abs(position_inside_pixel - fs_in_position_screen);

        if (all(lessThan(position_diff, vec2(threshold))))
            ok = true;
    }

    if (ok)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440

layout(location = 0) out vec4 fs_out_color;

layout(set = 0, binding = 0, std140) uniform SampleMaskBlock
{
    int sampleMaskPattern;
};
void main (void)
{
    if ((gl_SampleMaskIn[0] & ~sampleMaskPattern) != 0)
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
    else
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    if (((gl_SampleMaskIn[0] >> gl_SampleID) & 0x01) == 0x01)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    gl_SampleMask[0] = 0xAAAAAAAA;

    fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const int maskBitCount = bitCount(gl_SampleMaskIn[0]);

    if (maskBitCount < 1 || maskBitCount > 1)
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
    else
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const int maskBitCount = bitCount(gl_SampleMaskIn[0]);

    if (maskBitCount < 1 || maskBitCount > 2)
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
    else
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const int maskBitCount = bitCount(gl_SampleMaskIn[0]);

    if (maskBitCount < 1 || maskBitCount > 3)
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
    else
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const int maskBitCount = bitCount(gl_SampleMaskIn[0]);

    if (maskBitCount < 1 || maskBitCount > 5)
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
    else
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const int maskBitCount = bitCount(gl_SampleMaskIn[0]);

    if (maskBitCount < 1 || maskBitCount > 9)
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
    else
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const int maskBitCount = bitCount(gl_SampleMaskIn[0]);

    if (maskBitCount < 1 || maskBitCount > 17)
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
    else
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 450

layout (rgba8, set=0, binding=0) uniform image2DMS writeImg;
layout (rgba8, set=0, binding=1) uniform image2D   verificationImg;

void main()
{
        vec4  wcolor   = vec4(0, 0, 1, 1);
        uvec2 ucoords  = uvec2(gl_GlobalInvocationID.xy);
        ivec2 icoords  = ivec2(ucoords);
        uint writeMask = ((ucoords.x << 1) | ucoords.y);
        for (uint i = 0; i < 2; ++i)
        {
                if ((writeMask & (1 << i)) != 0)
                        imageStore(writeImg, icoords, int(i), wcolor);
        }
}
#version 450

layout (rgba8, set=0, binding=0) uniform image2DMS writeImg;
layout (rgba8, set=0, binding=1) uniform image2D   verificationImg;

void main()
{
        vec4  wcolor   = vec4(0, 0, 1, 1);
        vec4  bcolor   = vec4(1, 0, 0, 1);
        vec4  gcolor   = vec4(0, 1, 0, 1);
        vec4  ccolor   = vec4(0, 0, 0, 1);
        uvec2 ucoords  = uvec2(gl_GlobalInvocationID.xy);
        ivec2 icoords  = ivec2(ucoords);
        uint writeMask = ((ucoords.x << 1) | ucoords.y);
        bool ok = true;
        for (uint i = 0; i < 2; ++i)
        {
                bool expectWrite = ((writeMask & (1 << i)) != 0);
                vec4 sampleColor = imageLoad(writeImg, icoords, int(i));
                vec4 wantedColor = (expectWrite ? wcolor : ccolor);
                ok = ok && (sampleColor == wantedColor);
        }
        vec4 resultColor = (ok ? gcolor : bcolor);
        imageStore(verificationImg, icoords, resultColor);
}
#version 450

layout (rgba8, set=0, binding=0) uniform image2DMS writeImg;
layout (rgba8, set=0, binding=1) uniform image2D   verificationImg;

void main()
{
        vec4  wcolor   = vec4(0, 0, 1, 1);
        uvec2 ucoords  = uvec2(gl_GlobalInvocationID.xy);
        ivec2 icoords  = ivec2(ucoords);
        uint writeMask = ((ucoords.x << 2) | ucoords.y);
        for (uint i = 0; i < 4; ++i)
        {
                if ((writeMask & (1 << i)) != 0)
                        imageStore(writeImg, icoords, int(i), wcolor);
        }
}
#version 450

layout (rgba8, set=0, binding=0) uniform image2DMS writeImg;
layout (rgba8, set=0, binding=1) uniform image2D   verificationImg;

void main()
{
        vec4  wcolor   = vec4(0, 0, 1, 1);
        vec4  bcolor   = vec4(1, 0, 0, 1);
        vec4  gcolor   = vec4(0, 1, 0, 1);
        vec4  ccolor   = vec4(0, 0, 0, 1);
        uvec2 ucoords  = uvec2(gl_GlobalInvocationID.xy);
        ivec2 icoords  = ivec2(ucoords);
        uint writeMask = ((ucoords.x << 2) | ucoords.y);
        bool ok = true;
        for (uint i = 0; i < 4; ++i)
        {
                bool expectWrite = ((writeMask & (1 << i)) != 0);
                vec4 sampleColor = imageLoad(writeImg, icoords, int(i));
                vec4 wantedColor = (expectWrite ? wcolor : ccolor);
                ok = ok && (sampleColor == wantedColor);
        }
        vec4 resultColor = (ok ? gcolor : bcolor);
        imageStore(verificationImg, icoords, resultColor);
}
#version 450

layout (rgba8, set=0, binding=0) uniform image2DMS writeImg;
layout (rgba8, set=0, binding=1) uniform image2D   verificationImg;

void main()
{
        vec4  wcolor   = vec4(0, 0, 1, 1);
        uvec2 ucoords  = uvec2(gl_GlobalInvocationID.xy);
        ivec2 icoords  = ivec2(ucoords);
        uint writeMask = ((ucoords.x << 4) | ucoords.y);
        for (uint i = 0; i < 8; ++i)
        {
                if ((writeMask & (1 << i)) != 0)
                        imageStore(writeImg, icoords, int(i), wcolor);
        }
}
#version 450

layout (rgba8, set=0, binding=0) uniform image2DMS writeImg;
layout (rgba8, set=0, binding=1) uniform image2D   verificationImg;

void main()
{
        vec4  wcolor   = vec4(0, 0, 1, 1);
        vec4  bcolor   = vec4(1, 0, 0, 1);
        vec4  gcolor   = vec4(0, 1, 0, 1);
        vec4  ccolor   = vec4(0, 0, 0, 1);
        uvec2 ucoords  = uvec2(gl_GlobalInvocationID.xy);
        ivec2 icoords  = ivec2(ucoords);
        uint writeMask = ((ucoords.x << 4) | ucoords.y);
        bool ok = true;
        for (uint i = 0; i < 8; ++i)
        {
                bool expectWrite = ((writeMask & (1 << i)) != 0);
                vec4 sampleColor = imageLoad(writeImg, icoords, int(i));
                vec4 wantedColor = (expectWrite ? wcolor : ccolor);
                ok = ok && (sampleColor == wantedColor);
        }
        vec4 resultColor = (ok ? gcolor : bcolor);
        imageStore(verificationImg, icoords, resultColor);
}
#version 450

layout (rgba8, set=0, binding=0) uniform image2DMS writeImg;
layout (rgba8, set=0, binding=1) uniform image2D   verificationImg;

void main()
{
        vec4  wcolor   = vec4(0, 0, 1, 1);
        uvec2 ucoords  = uvec2(gl_GlobalInvocationID.xy);
        ivec2 icoords  = ivec2(ucoords);
        uint writeMask = ((ucoords.x << 8) | ucoords.y);
        for (uint i = 0; i < 16; ++i)
        {
                if ((writeMask & (1 << i)) != 0)
                        imageStore(writeImg, icoords, int(i), wcolor);
        }
}
#version 450

layout (rgba8, set=0, binding=0) uniform image2DMS writeImg;
layout (rgba8, set=0, binding=1) uniform image2D   verificationImg;

void main()
{
        vec4  wcolor   = vec4(0, 0, 1, 1);
        vec4  bcolor   = vec4(1, 0, 0, 1);
        vec4  gcolor   = vec4(0, 1, 0, 1);
        vec4  ccolor   = vec4(0, 0, 0, 1);
        uvec2 ucoords  = uvec2(gl_GlobalInvocationID.xy);
        ivec2 icoords  = ivec2(ucoords);
        uint writeMask = ((ucoords.x << 8) | ucoords.y);
        bool ok = true;
        for (uint i = 0; i < 16; ++i)
        {
                bool expectWrite = ((writeMask & (1 << i)) != 0);
                vec4 sampleColor = imageLoad(writeImg, icoords, int(i));
                vec4 wantedColor = (expectWrite ? wcolor : ccolor);
                ok = ok && (sampleColor == wantedColor);
        }
        vec4 resultColor = (ok ? gcolor : bcolor);
        imageStore(verificationImg, icoords, resultColor);
}
#version 450
layout (location=0) in vec2 inPos;
void main()
{
    gl_Position = vec4(inPos, 0.0, 1.0);
}
#version 450

layout (location=0) out vec4 outColor;

vec4 wcolor = vec4(0, 0, 1, 1);
vec4 ccolor = vec4(0, 0, 0, 1);

void main()
{
    uvec2 ucoords    = uvec2(gl_FragCoord);
    ivec2 icoords    = ivec2(ucoords);
    gl_SampleMask[0] = int((ucoords.x << 0) | ucoords.y);
    outColor         = wcolor;
}
#version 450

layout (location=0) out vec4 outColor;

vec4 wcolor = vec4(0, 0, 1, 1);
vec4 ccolor = vec4(0, 0, 0, 1);

layout(set=0, binding=0, input_attachment_index=0) uniform subpassInput inputAttachment;
layout(set=0, binding=1, std430) buffer StorageBuffer {
    int writeFlags[2];
} sb;

void main()
{
    uvec2 ucoords          = uvec2(gl_FragCoord);
    ivec2 icoords          = ivec2(ucoords);
    uint  bufferp          = ((ucoords.y * 2 + ucoords.x) * 1) + uint(gl_SampleID);
    vec4  storedc          = subpassLoad(inputAttachment);
    sb.writeFlags[bufferp] = ((storedc == wcolor) ? 1 : ((storedc == ccolor) ? 0 : 2));
    outColor               = storedc;
}
#version 450

layout (location=0) out vec4 outColor;

vec4 wcolor = vec4(0, 0, 1, 1);
vec4 ccolor = vec4(0, 0, 0, 1);

void main()
{
    uvec2 ucoords    = uvec2(gl_FragCoord);
    ivec2 icoords    = ivec2(ucoords);
    gl_SampleMask[0] = int((ucoords.x << 1) | ucoords.y);
    outColor         = wcolor;
}
#version 450

layout (location=0) out vec4 outColor;

vec4 wcolor = vec4(0, 0, 1, 1);
vec4 ccolor = vec4(0, 0, 0, 1);

layout(set=0, binding=0, input_attachment_index=0) uniform subpassInputMS inputAttachment;
layout(set=0, binding=1, std430) buffer StorageBuffer {
    int writeFlags[8];
} sb;

void main()
{
    uvec2 ucoords          = uvec2(gl_FragCoord);
    ivec2 icoords          = ivec2(ucoords);
    uint  bufferp          = ((ucoords.y * 2 + ucoords.x) * 2) + uint(gl_SampleID);
    vec4  storedc          = subpassLoad(inputAttachment, gl_SampleID);
    sb.writeFlags[bufferp] = ((storedc == wcolor) ? 1 : ((storedc == ccolor) ? 0 : 2));
    outColor               = storedc;
}
#version 450

layout (location=0) out vec4 outColor;

vec4 wcolor = vec4(0, 0, 1, 1);
vec4 ccolor = vec4(0, 0, 0, 1);

void main()
{
    uvec2 ucoords    = uvec2(gl_FragCoord);
    ivec2 icoords    = ivec2(ucoords);
    gl_SampleMask[0] = int((ucoords.x << 2) | ucoords.y);
    outColor         = wcolor;
}
#version 450

layout (location=0) out vec4 outColor;

vec4 wcolor = vec4(0, 0, 1, 1);
vec4 ccolor = vec4(0, 0, 0, 1);

layout(set=0, binding=0, input_attachment_index=0) uniform subpassInputMS inputAttachment;
layout(set=0, binding=1, std430) buffer StorageBuffer {
    int writeFlags[64];
} sb;

void main()
{
    uvec2 ucoords          = uvec2(gl_FragCoord);
    ivec2 icoords          = ivec2(ucoords);
    uint  bufferp          = ((ucoords.y * 4 + ucoords.x) * 4) + uint(gl_SampleID);
    vec4  storedc          = subpassLoad(inputAttachment, gl_SampleID);
    sb.writeFlags[bufferp] = ((storedc == wcolor) ? 1 : ((storedc == ccolor) ? 0 : 2));
    outColor               = storedc;
}
#version 450

layout (location=0) out vec4 outColor;

vec4 wcolor = vec4(0, 0, 1, 1);
vec4 ccolor = vec4(0, 0, 0, 1);

void main()
{
    uvec2 ucoords    = uvec2(gl_FragCoord);
    ivec2 icoords    = ivec2(ucoords);
    gl_SampleMask[0] = int((ucoords.x << 4) | ucoords.y);
    outColor         = wcolor;
}
#version 450

layout (location=0) out vec4 outColor;

vec4 wcolor = vec4(0, 0, 1, 1);
vec4 ccolor = vec4(0, 0, 0, 1);

layout(set=0, binding=0, input_attachment_index=0) uniform subpassInputMS inputAttachment;
layout(set=0, binding=1, std430) buffer StorageBuffer {
    int writeFlags[2048];
} sb;

void main()
{
    uvec2 ucoords          = uvec2(gl_FragCoord);
    ivec2 icoords          = ivec2(ucoords);
    uint  bufferp          = ((ucoords.y * 16 + ucoords.x) * 8) + uint(gl_SampleID);
    vec4  storedc          = subpassLoad(inputAttachment, gl_SampleID);
    sb.writeFlags[bufferp] = ((storedc == wcolor) ? 1 : ((storedc == ccolor) ? 0 : 2));
    outColor               = storedc;
}
#version 450

layout (location=0) out vec4 outColor;

vec4 wcolor = vec4(0, 0, 1, 1);
vec4 ccolor = vec4(0, 0, 0, 1);

void main()
{
    uvec2 ucoords    = uvec2(gl_FragCoord);
    ivec2 icoords    = ivec2(ucoords);
    gl_SampleMask[0] = int((ucoords.x << 8) | ucoords.y);
    outColor         = wcolor;
}
#version 450

layout (location=0) out vec4 outColor;

vec4 wcolor = vec4(0, 0, 1, 1);
vec4 ccolor = vec4(0, 0, 0, 1);

layout(set=0, binding=0, input_attachment_index=0) uniform subpassInputMS inputAttachment;
layout(set=0, binding=1, std430) buffer StorageBuffer {
    int writeFlags[1048576];
} sb;

void main()
{
    uvec2 ucoords          = uvec2(gl_FragCoord);
    ivec2 icoords          = ivec2(ucoords);
    uint  bufferp          = ((ucoords.y * 256 + ucoords.x) * 16) + uint(gl_SampleID);
    vec4  storedc          = subpassLoad(inputAttachment, gl_SampleID);
    sb.writeFlags[bufferp] = ((storedc == wcolor) ? 1 : ((storedc == ccolor) ? 0 : 2));
    outColor               = storedc;
}
