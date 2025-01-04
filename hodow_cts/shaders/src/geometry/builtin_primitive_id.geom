#version 450
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};
layout(points, invocations=1) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) in vec4 v_geom_primitiveID[];
void main (void)
{
    gl_Position = gl_in[0].gl_Position + vec4(0.05, 0.0, 0.0, 0.0);
    gl_PrimitiveID = int(floor(v_geom_primitiveID[0].x)) + 3;
    EmitVertex();
    gl_Position = gl_in[0].gl_Position - vec4(0.05, 0.0, 0.0, 0.0);
    gl_PrimitiveID = int(floor(v_geom_primitiveID[0].x)) + 3;
    EmitVertex();
    gl_Position = gl_in[0].gl_Position + vec4(0.0, 0.05, 0.0, 0.0);
    gl_PrimitiveID = int(floor(v_geom_primitiveID[0].x)) + 3;
    EmitVertex();
}
