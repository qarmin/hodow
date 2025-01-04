#version 310 es
layout(location = 0) in highp vec4 a_position;
void main (void) { gl_Position = a_position; }
#version 450
layout(local_size_x = 64) in;
layout(set = 0, binding = 0, std430) writeonly buffer Out { uint v[]; } outBuffer;
void main (void)
{
    outBuffer.v[gl_GlobalInvocationID.x] = gl_GlobalInvocationID.x + 1u;
}
