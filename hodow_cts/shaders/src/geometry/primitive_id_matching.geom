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
