#version 450

layout(vertices = 4) out;
layout(location = 0) flat out uint tesc_primitive_id[];

void main (void)
{
    if (gl_InvocationID == 0) {
        gl_TessLevelInner[0] = 2.0f;
        gl_TessLevelInner[1] = 2.0f;
        gl_TessLevelOuter[0] = 2.0f;
        gl_TessLevelOuter[1] = 2.0f;
        gl_TessLevelOuter[2] = 2.0f;
        gl_TessLevelOuter[3] = 2.0f;
    }
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    tesc_primitive_id[gl_InvocationID] = gl_PrimitiveID;
}
