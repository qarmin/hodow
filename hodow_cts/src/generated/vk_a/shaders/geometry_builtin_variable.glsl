#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    vec2 offset = vec2(float((gl_VertexIndex / 4) & 1), float(((gl_VertexIndex / 4) >> 1) & 1));
    gl_Position = vec4(pos - 1.0f + offset, 0.0f, 1.0f);
}
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
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
layout(location = 0) flat in uint tesc_primitive_id[];
layout(location = 1) flat in uint tese_primitive_id[];
layout(location = 0) flat out uint out_tesc_primitive_id;
layout(location = 1) flat out uint out_tese_primitive_id;
layout(location = 2) flat out uint out_geom_primitive_id;

void main(void)
{
    out_tesc_primitive_id = tesc_primitive_id[0];
    out_tese_primitive_id = tese_primitive_id[0];
    gl_PrimitiveID = gl_PrimitiveIDIn;
    out_geom_primitive_id = gl_PrimitiveID;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    out_tesc_primitive_id = tesc_primitive_id[1];
    out_tese_primitive_id = tese_primitive_id[1];
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();
    out_tesc_primitive_id = tesc_primitive_id[2];
    out_tese_primitive_id = tese_primitive_id[2];
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in uint tesc_primitive_id;
layout(location = 1) flat in uint tese_primitive_id;
layout(location = 2) flat in uint geom_primitive_id;
layout (location = 0) out vec4 outColor;
void main() {
    outColor = vec4(
                    float(tesc_primitive_id) / 255.0f,
                    float(tese_primitive_id) / 255.0f,
                    float(geom_primitive_id) / 255.0f,
                    1.0f
                    );
}
