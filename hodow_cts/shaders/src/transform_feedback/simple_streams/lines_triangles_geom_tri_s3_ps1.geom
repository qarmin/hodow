#version 450

layout(points) in;

layout(triangle_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int vertices_in_primitive[] = int[](3, 8, 6, 5, 4);

int num_vertices_in_primitives()
{
    int c = 0;

    for (int i = 0; i < vertices_in_primitive.length(); i++)
        c = c + vertices_in_primitive[i];

    return c;
}

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    int vc = num_vertices_in_primitives();
    int c0 = vc * gl_PrimitiveIDIn;
    int c1 = vc * (8 + gl_PrimitiveIDIn);

    for (int i = 0; i < vertices_in_primitive.length(); i++)
    {
        const int n = vertices_in_primitive[i];

        for (int j = 0; j < n; j++)
        {
            out0 = vec4(ivec4(c0, gl_PrimitiveIDIn, i, j));
            c0 = c0 + 1;
            gl_PointSize = 1.0;
            EmitStreamVertex(0);

            out1 = vec4(ivec4(c1, gl_PrimitiveIDIn, i, j));
            c1 = c1 + 1;
            gl_PointSize = 1.0;
            EmitStreamVertex(3);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(3);
    }
}
