#version 450

layout(points) in;

layout(points, max_vertices = 32) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int counts[] = int[](1, 1, 2, 4, 8);

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    int c0 = 0;
    int c1 = 0;

    // Start 1st buffer from point where 0th buffer ended
    for (int i = 0; i < counts.length(); i++)
        c1 = c1 + 4 * counts[i];

    for (int i = 0; i < counts.length(); i++)
    {
        const int n0 = counts[i];
        const int n1 = counts[counts.length() - 1 - i];

        for (int j = 0; j < n0; j++)
        {
            out0 = vec4(ivec4(c0, c0 + 1, c0 + 2, c0 + 3));
            c0 = c0 + 4;
            gl_PointSize = 1.0;
            EmitStreamVertex(0);
            EndStreamPrimitive(0);
        }

        for (int j = 0; j < n1; j++)
        {
            out1 = vec4(ivec4(c1, c1 + 1, c1 + 2, c1 + 3));
            c1 = c1 + 4;
            gl_PointSize = 1.0;
            EmitStreamVertex(3);
            EndStreamPrimitive(3);
        }
    }
}
