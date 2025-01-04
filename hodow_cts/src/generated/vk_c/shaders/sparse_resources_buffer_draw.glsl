#version 450

layout(location = 0) in vec4 in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
}
#version 450

layout(location = 0) out vec4 o_color;

layout(constant_id = 1) const int dataSize  = 1;
layout(constant_id = 2) const int chunkSize = 1;

layout(set = 0, binding = 0, std140) uniform SparseBuffer {
    ivec4 data[dataSize];
} buff;

void main(void)
{
    const int fragNdx        = int(gl_FragCoord.x) + 128 * int(gl_FragCoord.y);
    const int pageSize       = 128 * 128;
    const int numChunks      = dataSize / chunkSize;
    bool      ok             = true;

    for (int ndx = fragNdx; ndx < dataSize; ndx += pageSize)
    {
        ivec4 readData = buff.data[ndx];

        ok = ok && (readData == ivec4(3*ndx ^ 127, 0, 0, 0));
    }

    if (ok)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out vec4 o_color;

layout(constant_id = 1) const int dataSize  = 1;
layout(constant_id = 2) const int chunkSize = 1;

layout(set = 0, binding = 0, std140) uniform SparseBuffer {
    ivec4 data[dataSize];
} buff;

void main(void)
{
    const int fragNdx        = int(gl_FragCoord.x) + 128 * int(gl_FragCoord.y);
    const int pageSize       = 128 * 128;
    const int numChunks      = dataSize / chunkSize;
    const int nonAliasedSize = (numChunks > 1 ? dataSize - chunkSize : dataSize);
    bool      ok             = true;

    for (int ndx = fragNdx; ndx < dataSize; ndx += pageSize)
    {
        ivec4 readData = buff.data[ndx];

        ok = ok && (readData == ivec4(3*(ndx % nonAliasedSize) ^ 127, 0, 0, 0));
    }

    if (ok)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out vec4 o_color;

layout(constant_id = 1) const int dataSize  = 1;
layout(constant_id = 2) const int chunkSize = 1;

layout(set = 0, binding = 0, std140) uniform SparseBuffer {
    ivec4 data[dataSize];
} buff;

void main(void)
{
    const int fragNdx        = int(gl_FragCoord.x) + 128 * int(gl_FragCoord.y);
    const int pageSize       = 128 * 128;
    const int numChunks      = dataSize / chunkSize;
    bool      ok             = true;

    for (int ndx = fragNdx; ndx < dataSize; ndx += pageSize)
    {
        ivec4 readData = buff.data[ndx];

        if (ndx >= chunkSize && ndx < 2*chunkSize)
            continue;
        ok = ok && (readData == ivec4(3*ndx ^ 127, 0, 0, 0));
    }

    if (ok)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out vec4 o_color;

layout(constant_id = 1) const int dataSize  = 1;
layout(constant_id = 2) const int chunkSize = 1;

layout(set = 0, binding = 0, std140) uniform SparseBuffer {
    ivec4 data[dataSize];
} buff;

void main(void)
{
    const int fragNdx        = int(gl_FragCoord.x) + 128 * int(gl_FragCoord.y);
    const int pageSize       = 128 * 128;
    const int numChunks      = dataSize / chunkSize;
    const int nonAliasedSize = (numChunks > 1 ? dataSize - chunkSize : dataSize);
    bool      ok             = true;

    for (int ndx = fragNdx; ndx < dataSize; ndx += pageSize)
    {
        ivec4 readData = buff.data[ndx];

        if (ndx >= chunkSize && ndx < 2*chunkSize)
            continue;
        ok = ok && (readData == ivec4(3*(ndx % nonAliasedSize) ^ 127, 0, 0, 0));
    }

    if (ok)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out vec4 o_color;

layout(constant_id = 1) const int dataSize  = 1;
layout(constant_id = 2) const int chunkSize = 1;

layout(set = 0, binding = 0, std140) uniform SparseBuffer {
    ivec4 data[dataSize];
} buff;

void main(void)
{
    const int fragNdx        = int(gl_FragCoord.x) + 128 * int(gl_FragCoord.y);
    const int pageSize       = 128 * 128;
    const int numChunks      = dataSize / chunkSize;
    bool      ok             = true;

    for (int ndx = fragNdx; ndx < dataSize; ndx += pageSize)
    {
        ivec4 readData = buff.data[ndx];

        if (ndx >= chunkSize && ndx < 2 * chunkSize)
            ok = ok && (readData == ivec4(0));
        else
            ok = ok && (readData == ivec4(3*ndx ^ 127, 0, 0, 0));
    }

    if (ok)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out vec4 o_color;

layout(constant_id = 1) const int dataSize  = 1;
layout(constant_id = 2) const int chunkSize = 1;

layout(set = 0, binding = 0, std430) buffer SparseBuffer {
    volatile ivec4 data[dataSize];
} buff;

void main(void)
{
    const int fragNdx        = int(gl_FragCoord.x) + 128 * int(gl_FragCoord.y);
    const int pageSize       = 128 * 128;
    const int numChunks      = dataSize / chunkSize;
    bool      ok             = true;

    for (int ndx = fragNdx; ndx < dataSize; ndx += pageSize)
    {
        ivec4 readData = buff.data[ndx];

        // Write a new value based on index
        ivec4 newData = ivec4(ndx * 2 + 1, ndx ^ 0x55, ndx, 1);
        buff.data[ndx] = newData;
        ivec4 verifyData = buff.data[ndx];

        if (ndx >= chunkSize && ndx < 2 * chunkSize)
            ok = ok && (readData == ivec4(0)) && (verifyData == ivec4(0));
        else
            ok = ok && (readData == ivec4(3*ndx ^ 127, 0, 0, 0)) && (verifyData == newData);
    }

    if (ok)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 0) out int  out_ndx;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
    out_ndx     = gl_VertexIndex;
}
#version 450

layout(location = 0) flat in  int  in_ndx;
layout(location = 0)      out vec4 o_color;

void main(void)
{
    if (in_ndx % 2 == 0)
        o_color = vec4(vec3(1.0), 1.0);
    else
        o_color = vec4(vec3(0.75), 1.0);
}
#version 450
layout(location = 0) in vec4 in_position;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint out_ndx;
out gl_PerVertex {
    vec4 gl_Position;
};
void main(void)
{
    gl_Position = in_position;
    out_ndx     = gl_VertexIndex;
}
#version 450
layout(location = 0) out vec4 o_color;
void main(void)
{
    o_color = vec4(1.0);
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) writeonly buffer Output
{  uint r[]; };
void main(void)
{
    r[gl_GlobalInvocationID.y] = 135 + gl_GlobalInvocationID.y;
}
