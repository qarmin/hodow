#version 450

layout(quads, equal_spacing) in;
layout(location = 0) flat  in uint tesc_primitive_id[];
layout(location = 0) flat out uint out_tesc_primitive_id;
layout(location = 1) flat out uint tese_primitive_id;

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    out_tesc_primitive_id = tesc_primitive_id[0];
    tese_primitive_id = gl_PrimitiveID;
}
