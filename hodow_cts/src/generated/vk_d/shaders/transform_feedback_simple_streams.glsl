#version 450

layout(location = 0) out ivec4 out0;

void main(void)
{
    out0 = ivec4(gl_VertexIndex);
}
#version 450

void main(void)
{
}
#version 450

layout(location=0) out uint id;void main(void)
{
  id = gl_VertexIndex;}
#version 450

layout(location = 0) in  vec4 i_color;
layout(location = 0) out vec4 o_color;

void main(void)
{
    o_color = i_color;
}
#version 450

layout(points) in;

layout(points, max_vertices = 32) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 1, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int counts[] = int[](1, 1, 2, 4, 8);

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
            EmitStreamVertex(0);
            EndStreamPrimitive(0);
        }

        for (int j = 0; j < n1; j++)
        {
            out1 = vec4(ivec4(c1, c1 + 1, c1 + 2, c1 + 3));
            c1 = c1 + 4;
            EmitStreamVertex(1);
            EndStreamPrimitive(1);
        }
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 2) out;

layout(location=0) in uint id[1];layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0, component = 0) out uint out0;
layout(stream = 1, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 4, location = 0, component = 1) out uint out1;

void main(void)
{
    out0 = id[0] * 2 + 0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);

    out1 = id[0] * 2 + 1;
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 1) out;
layout(location = 0) out vec4 color;

layout(stream = 1) out gl_PerVertex
{
    vec4 gl_Position;
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
        color = m; gl_Position = b; EmitStreamVertex(1);
        color = m; gl_Position = y; EmitStreamVertex(1);
        color = m; gl_Position = c; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
    else
    {
        color = m; gl_Position = y; EmitStreamVertex(1);
        color = m; gl_Position = c; EmitStreamVertex(1);
        color = m; gl_Position = z; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 1) out;
layout(location = 0) out vec4 color;

layout(stream = 1) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_ClipDistance[];
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
        color = m; gl_Position = b; gl_ClipDistance[0] = -1.0; EmitStreamVertex(1);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; EmitStreamVertex(1);
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
    else
    {
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; EmitStreamVertex(1);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; EmitStreamVertex(1);
        color = m; gl_Position = z; gl_ClipDistance[0] =  1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 1) out;
layout(location = 0) out vec4 color;

layout(stream = 1) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_CullDistance[];
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
        color = m; gl_Position = b; gl_CullDistance[0] = -1.0; EmitStreamVertex(1);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; EmitStreamVertex(1);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; EmitStreamVertex(1);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; EmitStreamVertex(1);
        color = m; gl_Position = k; gl_CullDistance[0] = -1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
    else
    {
        color = m; gl_Position = j; gl_CullDistance[0] =  1.0; EmitStreamVertex(1);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; EmitStreamVertex(1);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; EmitStreamVertex(1);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; EmitStreamVertex(1);
        color = m; gl_Position = z; gl_CullDistance[0] =  1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 32) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 1, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

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
            EmitStreamVertex(1);
            EndStreamPrimitive(1);
        }
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 2) out;

layout(location=0) in uint id[1];layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0, component = 0) out uint out0;
layout(stream = 1, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 4, location = 0, component = 1) out uint out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    out0 = id[0] * 2 + 0;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);

    out1 = id[0] * 2 + 1;
    gl_PointSize = 1.0;
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 1) out;
layout(location = 0) out vec4 color;

layout(stream = 1) out gl_PerVertex
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
        color = m; gl_Position = b; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = y; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = c; gl_PointSize = 1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
    else
    {
        color = m; gl_Position = y; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = c; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = z; gl_PointSize = 1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 1) out;
layout(location = 0) out vec4 color;

layout(stream = 1) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_ClipDistance[];
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
        color = m; gl_Position = b; gl_ClipDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
    else
    {
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = z; gl_ClipDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 1) out;
layout(location = 0) out vec4 color;

layout(stream = 1) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_CullDistance[];
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
        color = m; gl_Position = b; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = k; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
    else
    {
        color = m; gl_Position = j; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        color = m; gl_Position = z; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;
layout(points, max_vertices = 16) out;
layout(stream = 1) out;
layout(location = 0) out vec4 color;

layout(stream = 1) out gl_PerVertex
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
        color = m; gl_Position = (b + k) / 2.0f; gl_PointSize = 1.0f; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
    else
    {
        color = g; gl_Position = (j + x) / 2.0f; gl_PointSize = 2.0f; EmitStreamVertex(0);
        EndStreamPrimitive(0);
        color = m; gl_Position = (k + y) / 2.0f; gl_PointSize = 2.0f; EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 32) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int counts[] = int[](1, 1, 2, 4, 8);

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
            EmitStreamVertex(0);
            EndStreamPrimitive(0);
        }

        for (int j = 0; j < n1; j++)
        {
            out1 = vec4(ivec4(c1, c1 + 1, c1 + 2, c1 + 3));
            c1 = c1 + 4;
            EmitStreamVertex(3);
            EndStreamPrimitive(3);
        }
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 2) out;

layout(location=0) in uint id[1];layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0, component = 0) out uint out0;
layout(stream = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 4, location = 0, component = 1) out uint out1;

void main(void)
{
    out0 = id[0] * 2 + 0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);

    out1 = id[0] * 2 + 1;
    EmitStreamVertex(3);
    EndStreamPrimitive(3);
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 3) out;
layout(location = 0) out vec4 color;

layout(stream = 3) out gl_PerVertex
{
    vec4 gl_Position;
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
        color = m; gl_Position = b; EmitStreamVertex(3);
        color = m; gl_Position = y; EmitStreamVertex(3);
        color = m; gl_Position = c; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
    else
    {
        color = m; gl_Position = y; EmitStreamVertex(3);
        color = m; gl_Position = c; EmitStreamVertex(3);
        color = m; gl_Position = z; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 3) out;
layout(location = 0) out vec4 color;

layout(stream = 3) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_ClipDistance[];
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
        color = m; gl_Position = b; gl_ClipDistance[0] = -1.0; EmitStreamVertex(3);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; EmitStreamVertex(3);
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
    else
    {
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; EmitStreamVertex(3);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; EmitStreamVertex(3);
        color = m; gl_Position = z; gl_ClipDistance[0] =  1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 3) out;
layout(location = 0) out vec4 color;

layout(stream = 3) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_CullDistance[];
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
        color = m; gl_Position = b; gl_CullDistance[0] = -1.0; EmitStreamVertex(3);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; EmitStreamVertex(3);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; EmitStreamVertex(3);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; EmitStreamVertex(3);
        color = m; gl_Position = k; gl_CullDistance[0] = -1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
    else
    {
        color = m; gl_Position = j; gl_CullDistance[0] =  1.0; EmitStreamVertex(3);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; EmitStreamVertex(3);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; EmitStreamVertex(3);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; EmitStreamVertex(3);
        color = m; gl_Position = z; gl_CullDistance[0] =  1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
}
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
#version 450

layout(points) in;

layout(points, max_vertices = 2) out;

layout(location=0) in uint id[1];layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0, component = 0) out uint out0;
layout(stream = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 4, location = 0, component = 1) out uint out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    out0 = id[0] * 2 + 0;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);

    out1 = id[0] * 2 + 1;
    gl_PointSize = 1.0;
    EmitStreamVertex(3);
    EndStreamPrimitive(3);
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 3) out;
layout(location = 0) out vec4 color;

layout(stream = 3) out gl_PerVertex
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
        color = m; gl_Position = b; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = y; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = c; gl_PointSize = 1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
    else
    {
        color = m; gl_Position = y; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = c; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = z; gl_PointSize = 1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 3) out;
layout(location = 0) out vec4 color;

layout(stream = 3) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_ClipDistance[];
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
        color = m; gl_Position = b; gl_ClipDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
    else
    {
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = z; gl_ClipDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 3) out;
layout(location = 0) out vec4 color;

layout(stream = 3) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_CullDistance[];
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
        color = m; gl_Position = b; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = k; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
    else
    {
        color = m; gl_Position = j; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        color = m; gl_Position = z; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
}
#version 450

layout(points) in;
layout(points, max_vertices = 16) out;
layout(stream = 3) out;
layout(location = 0) out vec4 color;

layout(stream = 3) out gl_PerVertex
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
        color = m; gl_Position = (b + k) / 2.0f; gl_PointSize = 1.0f; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
    else
    {
        color = g; gl_Position = (j + x) / 2.0f; gl_PointSize = 2.0f; EmitStreamVertex(0);
        EndStreamPrimitive(0);
        color = m; gl_Position = (k + y) / 2.0f; gl_PointSize = 2.0f; EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 32) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 6, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int counts[] = int[](1, 1, 2, 4, 8);

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
            EmitStreamVertex(0);
            EndStreamPrimitive(0);
        }

        for (int j = 0; j < n1; j++)
        {
            out1 = vec4(ivec4(c1, c1 + 1, c1 + 2, c1 + 3));
            c1 = c1 + 4;
            EmitStreamVertex(6);
            EndStreamPrimitive(6);
        }
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 2) out;

layout(location=0) in uint id[1];layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0, component = 0) out uint out0;
layout(stream = 6, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 4, location = 0, component = 1) out uint out1;

void main(void)
{
    out0 = id[0] * 2 + 0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);

    out1 = id[0] * 2 + 1;
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 6) out;
layout(location = 0) out vec4 color;

layout(stream = 6) out gl_PerVertex
{
    vec4 gl_Position;
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
        color = m; gl_Position = b; EmitStreamVertex(6);
        color = m; gl_Position = y; EmitStreamVertex(6);
        color = m; gl_Position = c; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
    else
    {
        color = m; gl_Position = y; EmitStreamVertex(6);
        color = m; gl_Position = c; EmitStreamVertex(6);
        color = m; gl_Position = z; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 6) out;
layout(location = 0) out vec4 color;

layout(stream = 6) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_ClipDistance[];
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
        color = m; gl_Position = b; gl_ClipDistance[0] = -1.0; EmitStreamVertex(6);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; EmitStreamVertex(6);
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
    else
    {
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; EmitStreamVertex(6);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; EmitStreamVertex(6);
        color = m; gl_Position = z; gl_ClipDistance[0] =  1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 6) out;
layout(location = 0) out vec4 color;

layout(stream = 6) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_CullDistance[];
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
        color = m; gl_Position = b; gl_CullDistance[0] = -1.0; EmitStreamVertex(6);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; EmitStreamVertex(6);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; EmitStreamVertex(6);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; EmitStreamVertex(6);
        color = m; gl_Position = k; gl_CullDistance[0] = -1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
    else
    {
        color = m; gl_Position = j; gl_CullDistance[0] =  1.0; EmitStreamVertex(6);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; EmitStreamVertex(6);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; EmitStreamVertex(6);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; EmitStreamVertex(6);
        color = m; gl_Position = z; gl_CullDistance[0] =  1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 32) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 6, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

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
            EmitStreamVertex(6);
            EndStreamPrimitive(6);
        }
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 2) out;

layout(location=0) in uint id[1];layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0, component = 0) out uint out0;
layout(stream = 6, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 4, location = 0, component = 1) out uint out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    out0 = id[0] * 2 + 0;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);

    out1 = id[0] * 2 + 1;
    gl_PointSize = 1.0;
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
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
        color = m; gl_Position = b; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = y; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = c; gl_PointSize = 1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
    else
    {
        color = m; gl_Position = y; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = c; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = z; gl_PointSize = 1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 6) out;
layout(location = 0) out vec4 color;

layout(stream = 6) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_ClipDistance[];
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
        color = m; gl_Position = b; gl_ClipDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
    else
    {
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = z; gl_ClipDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 6) out;
layout(location = 0) out vec4 color;

layout(stream = 6) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_CullDistance[];
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
        color = m; gl_Position = b; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = k; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
    else
    {
        color = m; gl_Position = j; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        color = m; gl_Position = z; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
}
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
#version 450

layout(points) in;

layout(points, max_vertices = 32) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int counts[] = int[](1, 1, 2, 4, 8);

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
            EmitStreamVertex(0);
            EndStreamPrimitive(0);
        }

        for (int j = 0; j < n1; j++)
        {
            out1 = vec4(ivec4(c1, c1 + 1, c1 + 2, c1 + 3));
            c1 = c1 + 4;
            EmitStreamVertex(14);
            EndStreamPrimitive(14);
        }
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 2) out;

layout(location=0) in uint id[1];layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0, component = 0) out uint out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 4, location = 0, component = 1) out uint out1;

void main(void)
{
    out0 = id[0] * 2 + 0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);

    out1 = id[0] * 2 + 1;
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 14) out;
layout(location = 0) out vec4 color;

layout(stream = 14) out gl_PerVertex
{
    vec4 gl_Position;
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
        color = m; gl_Position = b; EmitStreamVertex(14);
        color = m; gl_Position = y; EmitStreamVertex(14);
        color = m; gl_Position = c; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
    else
    {
        color = m; gl_Position = y; EmitStreamVertex(14);
        color = m; gl_Position = c; EmitStreamVertex(14);
        color = m; gl_Position = z; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 14) out;
layout(location = 0) out vec4 color;

layout(stream = 14) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_ClipDistance[];
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
        color = m; gl_Position = b; gl_ClipDistance[0] = -1.0; EmitStreamVertex(14);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; EmitStreamVertex(14);
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
    else
    {
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; EmitStreamVertex(14);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; EmitStreamVertex(14);
        color = m; gl_Position = z; gl_ClipDistance[0] =  1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 14) out;
layout(location = 0) out vec4 color;

layout(stream = 14) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_CullDistance[];
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
        color = m; gl_Position = b; gl_CullDistance[0] = -1.0; EmitStreamVertex(14);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; EmitStreamVertex(14);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; EmitStreamVertex(14);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; EmitStreamVertex(14);
        color = m; gl_Position = k; gl_CullDistance[0] = -1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
    else
    {
        color = m; gl_Position = j; gl_CullDistance[0] =  1.0; EmitStreamVertex(14);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; EmitStreamVertex(14);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; EmitStreamVertex(14);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; EmitStreamVertex(14);
        color = m; gl_Position = z; gl_CullDistance[0] =  1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 32) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

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
            EmitStreamVertex(14);
            EndStreamPrimitive(14);
        }
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 2) out;

layout(location=0) in uint id[1];layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0, component = 0) out uint out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 4, location = 0, component = 1) out uint out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    out0 = id[0] * 2 + 0;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);

    out1 = id[0] * 2 + 1;
    gl_PointSize = 1.0;
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 14) out;
layout(location = 0) out vec4 color;

layout(stream = 14) out gl_PerVertex
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
        color = m; gl_Position = b; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = y; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = c; gl_PointSize = 1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
    else
    {
        color = m; gl_Position = y; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = c; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = z; gl_PointSize = 1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 14) out;
layout(location = 0) out vec4 color;

layout(stream = 14) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_ClipDistance[];
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
        color = m; gl_Position = b; gl_ClipDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
    else
    {
        color = m; gl_Position = y; gl_ClipDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = c; gl_ClipDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = z; gl_ClipDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;
layout(stream = 14) out;
layout(location = 0) out vec4 color;

layout(stream = 14) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_CullDistance[];
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
        color = m; gl_Position = b; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
        color = m; gl_Position = j; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = c; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = k; gl_CullDistance[0] = -1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
    else
    {
        color = m; gl_Position = j; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
        color = m; gl_Position = y; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = k; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        color = m; gl_Position = z; gl_CullDistance[0] =  1.0; gl_PointSize = 1.0; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;
layout(points, max_vertices = 16) out;
layout(stream = 14) out;
layout(location = 0) out vec4 color;

layout(stream = 14) out gl_PerVertex
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
        color = m; gl_Position = (b + k) / 2.0f; gl_PointSize = 1.0f; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
    else
    {
        color = g; gl_Position = (j + x) / 2.0f; gl_PointSize = 2.0f; EmitStreamVertex(0);
        EndStreamPrimitive(0);
        color = m; gl_Position = (k + y) / 2.0f; gl_PointSize = 2.0f; EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(location = 0) out vec4 o_color;

void main(void)
{
    o_color = vec4(1.0, 1.0, 1.0, 1.0);
}
#version 450

layout(location = 0) in vec4 in_position;

void main(void)
{
    gl_Position = in_position;
}
#version 450

layout(location = 0) in vec4 in_position;

void main(void)
{
    gl_Position = in_position;
    gl_PointSize = 1.0;
}
#version 450

layout(push_constant, std430) uniform PushConstantBlock
{
    uint  start;
    float width;
    float posY;
} pc;

layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;

void main(void)
{
    idx_out           = pc.start + gl_VertexIndex;
    const float posX  = ((float(gl_VertexIndex) + 0.5) / pc.width) * 2.0 - 1.0;
    gl_Position       = vec4(posX, pc.posY, 0.0, 1.0);
    gl_PointSize      = 1.0;
}
#version 450
layout (location=0) out vec4 outColor;
void main (void) { outColor = vec4(0.0, 0.0, 1.0, 1.0); }

               OpCapability Shader
               OpCapability TransformFeedback
               OpMemoryModel Logical GLSL450
               OpEntryPoint Vertex %main "main" %_
               OpExecutionMode %main Xfb
               OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
               OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
               OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
               OpMemberDecorate %gl_PerVertex 3 BuiltIn CullDistance
               OpDecorate %gl_PerVertex Block
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
       %uint = OpTypeInt 32 0
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
          %_ = OpVariable %_ptr_Output_gl_PerVertex Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
    %float_1 = OpConstant %float 1
         %17 = OpConstantComposite %v4float %float_1 %float_1 %float_1 %float_1
%_ptr_Output_v4float = OpTypePointer Output %v4float
       %main = OpFunction %void None %3
          %5 = OpLabel
         %19 = OpAccessChain %_ptr_Output_v4float %_ %int_0
               OpStore %19 %17
               OpReturn
               OpFunctionEnd
        #version 450

layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position = vec4(1.0, 1.0, float(gl_VertexIndex) / 3.0 - 1.0, 1.0);
    gl_PointSize = 1.0;
}
#version 450

out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position = vec4(1.0, 1.0, float(gl_VertexIndex) / 3.0 - 1.0, 1.0);
}
#version 450
layout(vertices = 3) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];
void main (void)
{
    gl_TessLevelInner[0] = 0.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
    vec4 gl_Position;
};

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(triangles, ccw) in;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
    vec4 gl_Position;
};

void main (void)
{
    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;
    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;
    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;
    gl_Position = p0 + p1 + p2;
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(triangles, ccw) in;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

void main (void)
{
    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;
    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;
    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;
    gl_Position = p0 + p1 + p2;
    gl_PointSize = 1.0;
}
#version 460
out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0) in vec4 inPos;
void main(void) {
    gl_Position = inPos;
}
#version 460
layout (points) in;
layout (points, max_vertices=2) out;
in gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[1];
out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0, stream=0, xfb_buffer=0, xfb_offset=0, xfb_stride=16) out vec4 pos0;
layout (location=1, stream=1, xfb_buffer=1, xfb_offset=0, xfb_stride=16) out vec4 pos1;
void main() {
    vec4 inPos0;
    vec4 inPos1;

    inPos0 = gl_in[0].gl_Position;
    inPos1 = vec4(inPos0.x, -inPos0.y, inPos0.z, inPos0.w);
    gl_Position = inPos0;
    gl_PointSize = 1.0;
    pos0 = inPos0;
    EmitStreamVertex(0);

    inPos0 = gl_in[0].gl_Position;
    inPos1 = vec4(inPos0.x, -inPos0.y, inPos0.z, inPos0.w);
    gl_Position = inPos1;
    gl_PointSize = 1.0;
    pos1 = inPos1;
    EmitStreamVertex(1);
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=0) out vec4 outColor;
void main(void) {
    const vec4 offset = vec4(-100.0);
    const vec4 finalColor = vec4(0.0, 0.0, 1.0, 1.0);
    outColor = max(inPos + offset, finalColor);
}
#version 460
layout (points) in;
layout (points, max_vertices=2) out;
in gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[1];
layout (stream=1) out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0, stream=0, xfb_buffer=0, xfb_offset=0, xfb_stride=16) out vec4 pos0;
layout (location=1, stream=1, xfb_buffer=1, xfb_offset=0, xfb_stride=16) out vec4 pos1;
void main() {
    vec4 inPos0;
    vec4 inPos1;

    inPos0 = gl_in[0].gl_Position;
    inPos1 = vec4(inPos0.x, -inPos0.y, inPos0.z, inPos0.w);
    gl_Position = inPos0;
    gl_PointSize = 1.0;
    pos0 = inPos0;
    EmitStreamVertex(0);

    inPos0 = gl_in[0].gl_Position;
    inPos1 = vec4(inPos0.x, -inPos0.y, inPos0.z, inPos0.w);
    gl_Position = inPos1;
    gl_PointSize = 1.0;
    pos1 = inPos1;
    EmitStreamVertex(1);
}
#version 460
layout (location=1) in vec4 inPos;
layout (location=0) out vec4 outColor;
void main(void) {
    const vec4 offset = vec4(-100.0);
    const vec4 finalColor = vec4(0.0, 0.0, 1.0, 1.0);
    outColor = max(inPos + offset, finalColor);
}
#version 450

layout(push_constant) uniform pushConstants
{
    uint start;
} uInput;

layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;

void main(void)
{
    idx_out = uInput.start + gl_VertexIndex;
}
#version 450

layout(push_constant) uniform pushConstants
{
    uint start;
} uInput;

layout(xfb_buffer = 1, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;

void main(void)
{
    idx_out = uInput.start + gl_VertexIndex;
}
#version 450

layout(push_constant) uniform pushConstants
{
    uint start;
} uInput;

layout(xfb_buffer = 2, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;

void main(void)
{
    idx_out = uInput.start + gl_VertexIndex;
}
#version 450

layout(push_constant) uniform pushConstants
{
    uint start;
} uInput;

layout(xfb_buffer = 3, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;

void main(void)
{
    idx_out = uInput.start + gl_VertexIndex;
}
#version 450
layout(push_constant) uniform pushConstants
{
    uint start;
} uInput;
void main(void)
{
}
#version 450
layout(vertices = 3) out;
void main (void)
{
    gl_TessLevelInner[0] = 2.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
}
#version 450
layout(triangles, ccw) in;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;


void main (void)
{
    idx_out = gl_PrimitiveID;
}
#version 450

layout(push_constant) uniform pushConstants
{
    uint start;
} uInput;

layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;

void main(void)
{
    idx_out = uInput.start + gl_VertexIndex;
    gl_PointSize = 1.0;
}
#version 450
layout(triangles, ccw) in;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;
out gl_PerVertex { float gl_PointSize; };


void main (void)
{
    idx_out = gl_PrimitiveID;
    gl_PointSize = 1.0;
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 1, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(1);

    for (int j = 0; j < n0; j++)
    {
        out0 = vec4(c0);
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 1, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(1);

    for (int j = 0; j < n0; j++)
    {
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;

layout(line_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 1, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int vertices_in_primitive[] = int[](2, 6, 3);

int num_vertices_in_primitives()
{
    int c = 0;

    for (int i = 0; i < vertices_in_primitive.length(); i++)
        c = c + vertices_in_primitive[i];

    return c;
}

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
            EmitStreamVertex(0);

            out1 = vec4(ivec4(c1, gl_PrimitiveIDIn, i, j));
            c1 = c1 + 1;
            EmitStreamVertex(1);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;

layout(triangle_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 1, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int vertices_in_primitive[] = int[](3, 8, 6, 5, 4);

int num_vertices_in_primitives()
{
    int c = 0;

    for (int i = 0; i < vertices_in_primitive.length(); i++)
        c = c + vertices_in_primitive[i];

    return c;
}

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
            EmitStreamVertex(0);

            out1 = vec4(ivec4(c1, gl_PrimitiveIDIn, i, j));
            c1 = c1 + 1;
            EmitStreamVertex(1);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 1, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(1);

    for (int j = 0; j < n0; j++)
    {
        out0 = vec4(c0);
        gl_PointSize = 1.0;
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        gl_PointSize = 1.0;
        EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 1, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(1);

    for (int j = 0; j < n0; j++)
    {
        gl_PointSize = 1.0;
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        gl_PointSize = 1.0;
        EmitStreamVertex(1);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;

layout(line_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 1, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int vertices_in_primitive[] = int[](2, 6, 3);

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
            EmitStreamVertex(1);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;

layout(triangle_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 1, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

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
            EmitStreamVertex(1);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(1);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(3);

    for (int j = 0; j < n0; j++)
    {
        out0 = vec4(c0);
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(3);

    for (int j = 0; j < n0; j++)
    {
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
}
#version 450

layout(points) in;

layout(line_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int vertices_in_primitive[] = int[](2, 6, 3);

int num_vertices_in_primitives()
{
    int c = 0;

    for (int i = 0; i < vertices_in_primitive.length(); i++)
        c = c + vertices_in_primitive[i];

    return c;
}

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
            EmitStreamVertex(0);

            out1 = vec4(ivec4(c1, gl_PrimitiveIDIn, i, j));
            c1 = c1 + 1;
            EmitStreamVertex(3);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(3);
    }
}
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
            EmitStreamVertex(0);

            out1 = vec4(ivec4(c1, gl_PrimitiveIDIn, i, j));
            c1 = c1 + 1;
            EmitStreamVertex(3);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(3);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(3);

    for (int j = 0; j < n0; j++)
    {
        out0 = vec4(c0);
        gl_PointSize = 1.0;
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        gl_PointSize = 1.0;
        EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(3);

    for (int j = 0; j < n0; j++)
    {
        gl_PointSize = 1.0;
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        gl_PointSize = 1.0;
        EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
}
#version 450

layout(points) in;

layout(line_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int vertices_in_primitive[] = int[](2, 6, 3);

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
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 6, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(6);

    for (int j = 0; j < n0; j++)
    {
        out0 = vec4(c0);
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 6, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(6);

    for (int j = 0; j < n0; j++)
    {
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;

layout(line_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 6, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int vertices_in_primitive[] = int[](2, 6, 3);

int num_vertices_in_primitives()
{
    int c = 0;

    for (int i = 0; i < vertices_in_primitive.length(); i++)
        c = c + vertices_in_primitive[i];

    return c;
}

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
            EmitStreamVertex(0);

            out1 = vec4(ivec4(c1, gl_PrimitiveIDIn, i, j));
            c1 = c1 + 1;
            EmitStreamVertex(6);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;

layout(triangle_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 6, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int vertices_in_primitive[] = int[](3, 8, 6, 5, 4);

int num_vertices_in_primitives()
{
    int c = 0;

    for (int i = 0; i < vertices_in_primitive.length(); i++)
        c = c + vertices_in_primitive[i];

    return c;
}

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
            EmitStreamVertex(0);

            out1 = vec4(ivec4(c1, gl_PrimitiveIDIn, i, j));
            c1 = c1 + 1;
            EmitStreamVertex(6);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 6, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(6);

    for (int j = 0; j < n0; j++)
    {
        out0 = vec4(c0);
        gl_PointSize = 1.0;
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        gl_PointSize = 1.0;
        EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 6, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(6);

    for (int j = 0; j < n0; j++)
    {
        gl_PointSize = 1.0;
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        gl_PointSize = 1.0;
        EmitStreamVertex(6);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;

layout(line_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 6, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int vertices_in_primitive[] = int[](2, 6, 3);

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
            EmitStreamVertex(6);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;

layout(triangle_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 6, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

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
            EmitStreamVertex(6);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(6);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(14);

    for (int j = 0; j < n0; j++)
    {
        out0 = vec4(c0);
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(14);

    for (int j = 0; j < n0; j++)
    {
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;

layout(line_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int vertices_in_primitive[] = int[](2, 6, 3);

int num_vertices_in_primitives()
{
    int c = 0;

    for (int i = 0; i < vertices_in_primitive.length(); i++)
        c = c + vertices_in_primitive[i];

    return c;
}

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
            EmitStreamVertex(0);

            out1 = vec4(ivec4(c1, gl_PrimitiveIDIn, i, j));
            c1 = c1 + 1;
            EmitStreamVertex(14);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;

layout(triangle_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int vertices_in_primitive[] = int[](3, 8, 6, 5, 4);

int num_vertices_in_primitives()
{
    int c = 0;

    for (int i = 0; i < vertices_in_primitive.length(); i++)
        c = c + vertices_in_primitive[i];

    return c;
}

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
            EmitStreamVertex(0);

            out1 = vec4(ivec4(c1, gl_PrimitiveIDIn, i, j));
            c1 = c1 + 1;
            EmitStreamVertex(14);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(14);

    for (int j = 0; j < n0; j++)
    {
        out0 = vec4(c0);
        gl_PointSize = 1.0;
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        gl_PointSize = 1.0;
        EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(14);

    for (int j = 0; j < n0; j++)
    {
        gl_PointSize = 1.0;
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        gl_PointSize = 1.0;
        EmitStreamVertex(14);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;

layout(line_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

const int vertices_in_primitive[] = int[](2, 6, 3);

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
            EmitStreamVertex(14);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(14);
    }
}
#version 450

layout(points) in;

layout(triangle_strip, max_vertices = 256) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

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
            EmitStreamVertex(14);
        }

        EndStreamPrimitive(0);
        EndStreamPrimitive(14);
    }
}
