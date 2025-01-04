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
