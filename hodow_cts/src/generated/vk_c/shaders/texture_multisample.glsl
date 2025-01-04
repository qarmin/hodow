#version 430

layout(local_size_x = 16, local_size_y = 16) in;
uniform layout(set=0, binding=0, r32i) iimage2DMS texture;
uniform layout(set=0, binding=1, rgba8) image2D result;

void main()
{
    ivec2 loc = ivec2(gl_LocalInvocationID.xy);
    // Partner location is a mirror in local workgroup space.
    ivec2 partnerLoc = ivec2(15) - loc;
    int id = loc.y * 16 + loc.x;
    int partnerId = partnerLoc.y * 16 + partnerLoc.x;
    ivec2 workGroupOffset = ivec2(gl_WorkGroupID.xy) * ivec2(16);

    // Initialize texture with id + sample id
    for (int s = 0; s < 4; s++)
        imageStore(texture, loc + workGroupOffset, s, ivec4(s + id));

    memoryBarrierImage();
    barrier();

    for (int s = 0; s < 4; s++)
    {
        // Add id to both location and partner location.
        imageAtomicAdd(texture, loc + workGroupOffset, s, id);
        imageAtomicAdd(texture, partnerLoc + workGroupOffset, s, id);

        // Set MSB for location and the second MSB for partner.
        imageAtomicOr(texture, loc + workGroupOffset, s, 1 << 31);
        imageAtomicOr(texture, partnerLoc + workGroupOffset, s, 1 << 30);
    }

    memoryBarrierImage();
    barrier();

    for (int s = 0; s < 4; s++)
    {
        // XOR with two patterns in the second highest byte. Should set this
        // byte to 0xc. The order of XOR operations don't matter.
        imageAtomicXor(texture, loc + workGroupOffset, s, 0x0a000000);
        imageAtomicXor(texture, partnerLoc + workGroupOffset, s, 0x06000000);
    }

    memoryBarrierImage();
    barrier();

    for (int s = 0; s < 4; s++)
    {
        // Finally mask out one of LSBs based on sample
        imageAtomicAnd(texture, loc + workGroupOffset, s, ~(1 << s));
    }

    // Verification
    bool ok = true;

    for (int s = 0; s < 4; s++)
    {
        if (imageLoad(texture, loc + workGroupOffset, s).r != (((s + id * 2 + partnerId) | 0xcc000000) & ~(1 << s)))
            ok = false;
    }

    vec4 color = ok ? vec4(0, 1, 0, 1) : vec4(1, 0, 0, 1);
    imageStore(result, loc + workGroupOffset, color);
}
#version 430

layout(local_size_x = 16, local_size_y = 16) in;
uniform layout(set=0, binding=0, r32ui) uimage2DMS texture;
uniform layout(set=0, binding=1, rgba8) image2D result;

void main()
{
    ivec2 loc = ivec2(gl_LocalInvocationID.xy);
    // Partner location is a mirror in local workgroup space.
    ivec2 partnerLoc = ivec2(15) - loc;
    uint id = loc.y * 16 + loc.x;
    uint partnerId = partnerLoc.y * 16 + partnerLoc.x;
    ivec2 workGroupOffset = ivec2(gl_WorkGroupID.xy) * ivec2(16);

    // Initialize texture with id + sample id
    for (int s = 0; s < 4; s++)
        imageStore(texture, loc + workGroupOffset, s, uvec4(s + id));

    memoryBarrierImage();
    barrier();

    for (int s = 0; s < 4; s++)
    {
        // Add id to both location and partner location.
        imageAtomicAdd(texture, loc + workGroupOffset, s, id);
        imageAtomicAdd(texture, partnerLoc + workGroupOffset, s, id);

        // Set MSB for location and the second MSB for partner.
        imageAtomicOr(texture, loc + workGroupOffset, s, 1u << 31);
        imageAtomicOr(texture, partnerLoc + workGroupOffset, s, 1u << 30);
    }

    memoryBarrierImage();
    barrier();

    for (int s = 0; s < 4; s++)
    {
        // XOR with two patterns in the second highest byte. Should set this
        // byte to 0xc. The order of XOR operations don't matter.
        imageAtomicXor(texture, loc + workGroupOffset, s, 0x0a000000);
        imageAtomicXor(texture, partnerLoc + workGroupOffset, s, 0x06000000);
    }

    memoryBarrierImage();
    barrier();

    for (int s = 0; s < 4; s++)
    {
        // Finally mask out one of LSBs based on sample
        imageAtomicAnd(texture, loc + workGroupOffset, s, ~(1u << s));
    }

    // Verification
    bool ok = true;

    for (int s = 0; s < 4; s++)
    {
        if (imageLoad(texture, loc + workGroupOffset, s).r != (((s + id * 2 + partnerId) | 0xcc000000) & ~(1u << s)))
            ok = false;
    }

    vec4 color = ok ? vec4(0, 1, 0, 1) : vec4(1, 0, 0, 1);
    imageStore(result, loc + workGroupOffset, color);
}
#version 430
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require

layout(local_size_x = 16, local_size_y = 16) in;
uniform layout(set=0, binding=0, r64i) i64image2DMS texture;
uniform layout(set=0, binding=1, rgba8) image2D result;

void main()
{
    ivec2 loc = ivec2(gl_LocalInvocationID.xy);
    // Partner location is a mirror in local workgroup space.
    ivec2 partnerLoc = ivec2(15) - loc;
    int id = loc.y * 16 + loc.x;
    int partnerId = partnerLoc.y * 16 + partnerLoc.x;
    ivec2 workGroupOffset = ivec2(gl_WorkGroupID.xy) * ivec2(16);

    // Initialize texture with id + sample id
    for (int s = 0; s < 4; s++)
        imageStore(texture, loc + workGroupOffset, s, ivec4(int64_t(s + id)));

    memoryBarrierImage();
    barrier();

    for (int s = 0; s < 4; s++)
    {
        // Add id to both location and partner location.
        imageAtomicAdd(texture, loc + workGroupOffset, s, int64_t(id));
        imageAtomicAdd(texture, partnerLoc + workGroupOffset, s, int64_t(id));

        // Set MSB for location and the second MSB for partner.
        imageAtomicOr(texture, loc + workGroupOffset, s, int64_t(1) << 63);
        imageAtomicOr(texture, partnerLoc + workGroupOffset, s, int64_t(1) << 62);
    }

    memoryBarrierImage();
    barrier();

    for (int s = 0; s < 4; s++)
    {
        // XOR with two patterns in the second highest byte. Should set this
        // byte to 0xc. The order of XOR operations don't matter.
        imageAtomicXor(texture, loc + workGroupOffset, s, 0x0a00000000000000L);
        imageAtomicXor(texture, partnerLoc + workGroupOffset, s, 0x0600000000000000L);
    }

    memoryBarrierImage();
    barrier();

    for (int s = 0; s < 4; s++)
    {
        // Finally mask out one of LSBs based on sample
        imageAtomicAnd(texture, loc + workGroupOffset, s, ~(int64_t(1) << s));
    }

    // Verification
    bool ok = true;

    for (int s = 0; s < 4; s++)
    {
        if (imageLoad(texture, loc + workGroupOffset, s).r != int64_t(((s + id * 2 + partnerId) | 0x0a00000000000000L) & ~(int64_t(1) << s)))
            ok = false;
    }

    vec4 color = ok ? vec4(0, 1, 0, 1) : vec4(1, 0, 0, 1);
    imageStore(result, loc + workGroupOffset, color);
}
#version 430
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require

layout(local_size_x = 16, local_size_y = 16) in;
uniform layout(set=0, binding=0, r64ui) u64image2DMS texture;
uniform layout(set=0, binding=1, rgba8) image2D result;

void main()
{
    ivec2 loc = ivec2(gl_LocalInvocationID.xy);
    // Partner location is a mirror in local workgroup space.
    ivec2 partnerLoc = ivec2(15) - loc;
    int id = loc.y * 16 + loc.x;
    int partnerId = partnerLoc.y * 16 + partnerLoc.x;
    ivec2 workGroupOffset = ivec2(gl_WorkGroupID.xy) * ivec2(16);

    // Initialize texture with id + sample id
    for (int s = 0; s < 4; s++)
        imageStore(texture, loc + workGroupOffset, s, uvec4(uint64_t(s + id)));

    memoryBarrierImage();
    barrier();

    for (int s = 0; s < 4; s++)
    {
        // Add id to both location and partner location.
        imageAtomicAdd(texture, loc + workGroupOffset, s, uint64_t(id));
        imageAtomicAdd(texture, partnerLoc + workGroupOffset, s, uint64_t(id));

        // Set MSB for location and the second MSB for partner.
        imageAtomicOr(texture, loc + workGroupOffset, s, uint64_t(1) << 63);
        imageAtomicOr(texture, partnerLoc + workGroupOffset, s, uint64_t(1) << 62);
    }

    memoryBarrierImage();
    barrier();

    for (int s = 0; s < 4; s++)
    {
        // XOR with two patterns in the second highest byte. Should set this
        // byte to 0xc. The order of XOR operations don't matter.
        imageAtomicXor(texture, loc + workGroupOffset, s, 0x0a00000000000000L);
        imageAtomicXor(texture, partnerLoc + workGroupOffset, s, 0x0600000000000000L);
    }

    memoryBarrierImage();
    barrier();

    for (int s = 0; s < 4; s++)
    {
        // Finally mask out one of LSBs based on sample
        imageAtomicAnd(texture, loc + workGroupOffset, s, ~(uint64_t(1) << s));
    }

    // Verification
    bool ok = true;

    for (int s = 0; s < 4; s++)
    {
        if (imageLoad(texture, loc + workGroupOffset, s).r != uint64_t(((s + id * 2 + partnerId) | 0x0a00000000000000L) & ~(uint64_t(1) << s)))
            ok = false;
    }

    vec4 color = ok ? vec4(0, 1, 0, 1) : vec4(1, 0, 0, 1);
    imageStore(result, loc + workGroupOffset, color);
}
#version 430

layout(local_size_x = 16, local_size_y = 16) in;

uniform layout(set=0, binding=0, rgba8) image2DMS texture;
uniform layout(set=0, binding=1, rgba8) image2D result;


void main()
{
    int numSamples = 16;
    int distortion = 256;
    vec4 ndxColors[4];

    ndxColors[0] = vec4(1.0, 0.0, 0.0, 1.0);
    ndxColors[1] = vec4(0.0, 1.0, 0.0, 1.0);
    ndxColors[2] = vec4(0.0, 0.0, 1.0, 1.0);
    ndxColors[3] = vec4(0.0, 1.0, 1.0, 1.0);

    ivec2 uv = ivec2(gl_GlobalInvocationID.xy);

    // Initialize texture
    for (int s = -distortion; s < distortion; s++)
    {
        vec4 color = vec4(1);

        if (s >= 0 && s < numSamples) color = ndxColors[s % 4];

        imageStore(texture, uv, s, color);
    }

    memoryBarrierImage();
    barrier();

    // Verification
    bool imageOk = true;

    for (int s = 0; s < numSamples; s++)
    {
        vec4 color = vec4(1);

        if (s >= 0 && s < numSamples) color = ndxColors[s % 4];

        if (imageLoad(texture, uv, s) != color)
            imageOk = false;
    }

    vec4 resultColor = imageOk ? vec4(0, 1, 0, 1) : vec4(1, 0, 0, 1);
    imageStore(result, uv, resultColor);
}
#version 430

layout(local_size_x = 16, local_size_y = 16) in;

uniform layout(set=0, binding=0, rgba8) image2DMS texture;
uniform layout(set=0, binding=1, rgba8) image2D result;


void main()
{
    int numSamples = 2;
    int distortion = 256;
    vec4 ndxColors[2];

    ndxColors[0] = vec4(1.0, 0.0, 1.0, 1.0);
    ndxColors[1] = vec4(0.0, 1.0, 1.0, 1.0);

    ivec2 uv = ivec2(gl_GlobalInvocationID.xy);

    // Initialize texture
    for (int s = -distortion; s < distortion; s++)
    {
        vec4 color = vec4(1);

        if (s >= 0 && s < numSamples) color = ndxColors[s % 2];

        imageStore(texture, uv, s, color);
    }

    memoryBarrierImage();
    barrier();

    // Verification
    bool imageOk = true;

    for (int s = 0; s < numSamples; s++)
    {
        vec4 color = vec4(1);

        if (s >= 0 && s < numSamples) color = ndxColors[s % 2];

        if (imageLoad(texture, uv, s) != color)
            imageOk = false;
    }

    vec4 resultColor = imageOk ? vec4(0, 1, 0, 1) : vec4(1, 0, 0, 1);
    imageStore(result, uv, resultColor);
}
#version 430

layout(local_size_x = 16, local_size_y = 16) in;

uniform layout(set=0, binding=0, rgba8) image2DMS texture;
uniform layout(set=0, binding=1, rgba8) image2D result;


void main()
{
    int numSamples = 32;
    int distortion = 256;
    vec4 ndxColors[4];

    ndxColors[0] = vec4(1.0, 0.0, 0.0, 1.0);
    ndxColors[1] = vec4(0.0, 1.0, 0.0, 1.0);
    ndxColors[2] = vec4(0.0, 0.0, 1.0, 1.0);
    ndxColors[3] = vec4(0.0, 1.0, 1.0, 1.0);

    ivec2 uv = ivec2(gl_GlobalInvocationID.xy);

    // Initialize texture
    for (int s = -distortion; s < distortion; s++)
    {
        vec4 color = vec4(1);

        if (s >= 0 && s < numSamples) color = ndxColors[s % 4];

        imageStore(texture, uv, s, color);
    }

    memoryBarrierImage();
    barrier();

    // Verification
    bool imageOk = true;

    for (int s = 0; s < numSamples; s++)
    {
        vec4 color = vec4(1);

        if (s >= 0 && s < numSamples) color = ndxColors[s % 4];

        if (imageLoad(texture, uv, s) != color)
            imageOk = false;
    }

    vec4 resultColor = imageOk ? vec4(0, 1, 0, 1) : vec4(1, 0, 0, 1);
    imageStore(result, uv, resultColor);
}
#version 430

layout(local_size_x = 16, local_size_y = 16) in;

uniform layout(set=0, binding=0, rgba8) image2DMS texture;
uniform layout(set=0, binding=1, rgba8) image2D result;


void main()
{
    int numSamples = 4;
    int distortion = 256;
    vec4 ndxColors[4];

    ndxColors[0] = vec4(1.0, 0.0, 0.0, 1.0);
    ndxColors[1] = vec4(0.0, 1.0, 0.0, 1.0);
    ndxColors[2] = vec4(0.0, 0.0, 1.0, 1.0);
    ndxColors[3] = vec4(0.0, 1.0, 1.0, 1.0);

    ivec2 uv = ivec2(gl_GlobalInvocationID.xy);

    // Initialize texture
    for (int s = -distortion; s < distortion; s++)
    {
        vec4 color = vec4(1);

        if (s >= 0 && s < numSamples) color = ndxColors[s % 4];

        imageStore(texture, uv, s, color);
    }

    memoryBarrierImage();
    barrier();

    // Verification
    bool imageOk = true;

    for (int s = 0; s < numSamples; s++)
    {
        vec4 color = vec4(1);

        if (s >= 0 && s < numSamples) color = ndxColors[s % 4];

        if (imageLoad(texture, uv, s) != color)
            imageOk = false;
    }

    vec4 resultColor = imageOk ? vec4(0, 1, 0, 1) : vec4(1, 0, 0, 1);
    imageStore(result, uv, resultColor);
}
#version 430

layout(local_size_x = 16, local_size_y = 16) in;

uniform layout(set=0, binding=0, rgba8) image2DMS texture;
uniform layout(set=0, binding=1, rgba8) image2D result;


void main()
{
    int numSamples = 64;
    int distortion = 256;
    vec4 ndxColors[4];

    ndxColors[0] = vec4(1.0, 0.0, 0.0, 1.0);
    ndxColors[1] = vec4(0.0, 1.0, 0.0, 1.0);
    ndxColors[2] = vec4(0.0, 0.0, 1.0, 1.0);
    ndxColors[3] = vec4(0.0, 1.0, 1.0, 1.0);

    ivec2 uv = ivec2(gl_GlobalInvocationID.xy);

    // Initialize texture
    for (int s = -distortion; s < distortion; s++)
    {
        vec4 color = vec4(1);

        if (s >= 0 && s < numSamples) color = ndxColors[s % 4];

        imageStore(texture, uv, s, color);
    }

    memoryBarrierImage();
    barrier();

    // Verification
    bool imageOk = true;

    for (int s = 0; s < numSamples; s++)
    {
        vec4 color = vec4(1);

        if (s >= 0 && s < numSamples) color = ndxColors[s % 4];

        if (imageLoad(texture, uv, s) != color)
            imageOk = false;
    }

    vec4 resultColor = imageOk ? vec4(0, 1, 0, 1) : vec4(1, 0, 0, 1);
    imageStore(result, uv, resultColor);
}
#version 430

layout(local_size_x = 16, local_size_y = 16) in;

uniform layout(set=0, binding=0, rgba8) image2DMS texture;
uniform layout(set=0, binding=1, rgba8) image2D result;


void main()
{
    int numSamples = 8;
    int distortion = 256;
    vec4 ndxColors[4];

    ndxColors[0] = vec4(1.0, 0.0, 0.0, 1.0);
    ndxColors[1] = vec4(0.0, 1.0, 0.0, 1.0);
    ndxColors[2] = vec4(0.0, 0.0, 1.0, 1.0);
    ndxColors[3] = vec4(0.0, 1.0, 1.0, 1.0);

    ivec2 uv = ivec2(gl_GlobalInvocationID.xy);

    // Initialize texture
    for (int s = -distortion; s < distortion; s++)
    {
        vec4 color = vec4(1);

        if (s >= 0 && s < numSamples) color = ndxColors[s % 4];

        imageStore(texture, uv, s, color);
    }

    memoryBarrierImage();
    barrier();

    // Verification
    bool imageOk = true;

    for (int s = 0; s < numSamples; s++)
    {
        vec4 color = vec4(1);

        if (s >= 0 && s < numSamples) color = ndxColors[s % 4];

        if (imageLoad(texture, uv, s) != color)
            imageOk = false;
    }

    vec4 resultColor = imageOk ? vec4(0, 1, 0, 1) : vec4(1, 0, 0, 1);
    imageStore(result, uv, resultColor);
}
