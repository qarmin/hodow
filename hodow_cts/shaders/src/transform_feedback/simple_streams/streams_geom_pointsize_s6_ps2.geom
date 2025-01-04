#version 450

layout(points) in;
layout(points, max_vertices = 16) out;
layout(stream = 6) out;
layout(location = 0) out vec4 color;

layout(stream = 6) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    // Color constants
    vec4 g = vec4(0.0, 1.0, 0.0, 1.0);
    vec4 m = vec4(1.0, 0.0, 1.0, 1.0);
    // Coordinate constants: leftmost column
    vec4 a = vec4(-1.0,-1.0, 0.0, 1.0);
    vec4 b = vec4(-1.0, 0.0, 0.0, 1.0);
    vec4 c = vec4(-1.0, 1.0, 0.0, 1.0);
    // Coordinate constants: middle column
    vec4 i = vec4( 0.0,-1.0, 0.0, 1.0);
    vec4 j = vec4( 0.0, 0.0, 0.0, 1.0);
    vec4 k = vec4( 0.0, 1.0, 0.0, 1.0);
    // Coordinate constants: rightmost column
    vec4 x = vec4( 1.0,-1.0, 0.0, 1.0);
    vec4 y = vec4( 1.0, 0.0, 0.0, 1.0);
    vec4 z = vec4( 1.0, 1.0, 0.0, 1.0);

    if (gl_PrimitiveIDIn == 0)
    {
        color = g; gl_Position = (a + j) / 2.0f; gl_PointSize = 1.0f; EmitStreamVertex(0);
        EndStreamPrimitive(0);
        color = m; gl_Position = (b + k) / 2.0f; gl_PointSize = 1.0f; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
    else
    {
        color = g; gl_Position = (j + x) / 2.0f; gl_PointSize = 2.0f; EmitStreamVertex(0);
        EndStreamPrimitive(0);
        color = m; gl_Position = (k + y) / 2.0f; gl_PointSize = 2.0f; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
}
