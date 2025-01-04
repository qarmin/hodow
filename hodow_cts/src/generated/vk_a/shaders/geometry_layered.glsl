#version 450

void main(void)
{
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 4) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
    EmitVertex();
}
#version 450

layout(location = 0) out vec4 o_color;

void main(void)
{
    o_color = vec4(1.0);
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 4) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = 2;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = 2;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
    gl_Layer    = 2;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
    gl_Layer    = 2;
    gl_PointSize = 1.0;
    EmitVertex();
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 4) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = 3;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = 3;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
    gl_Layer    = 3;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
    gl_Layer    = 3;
    gl_PointSize = 1.0;
    EmitVertex();
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 4) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = 4;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = 4;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
    gl_Layer    = 4;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
    gl_Layer    = 4;
    gl_PointSize = 1.0;
    EmitVertex();
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 4) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = 6;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = 6;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
    gl_Layer    = 6;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
    gl_Layer    = 6;
    gl_PointSize = 1.0;
    EmitVertex();
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));

    for (int layerNdx = 0; layerNdx < 4; ++layerNdx) {
        const int colorNdx = layerNdx % 6;

        gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();
        EndPrimitive();
    };
}
#version 450

layout(location = 0) out vec4 o_color;
layout(location = 0) in  vec4 vert_color;

void main(void)
{
    o_color = vert_color;
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 24) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));

    for (int layerNdx = 0; layerNdx < 6; ++layerNdx) {
        const int colorNdx = layerNdx % 6;

        gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();
        EndPrimitive();
    };
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 32) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));

    for (int layerNdx = 0; layerNdx < 8; ++layerNdx) {
        const int colorNdx = layerNdx % 6;

        gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();
        EndPrimitive();
    };
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 48) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));

    for (int layerNdx = 0; layerNdx < 12; ++layerNdx) {
        const int colorNdx = layerNdx % 6;

        gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        vert_color  = colors[colorNdx];
        gl_PointSize = 1.0;
        EmitVertex();
        EndPrimitive();
    };
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 20) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    for (int layerNdx = 0; layerNdx < 4; ++layerNdx) {
        for (int colNdx = 0; colNdx <= layerNdx; ++colNdx) {
            const float posX = float(colNdx) / float(4) * 2.0 - 1.0;

            gl_Position = vec4(posX,  1.0, 0.0, 1.0);
            gl_Layer    = layerNdx;
            gl_PointSize = 1.0;
            EmitVertex();

            gl_Position = vec4(posX, -1.0, 0.0, 1.0);
            gl_Layer    = layerNdx;
            gl_PointSize = 1.0;
            EmitVertex();
        }
        EndPrimitive();
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 42) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    for (int layerNdx = 0; layerNdx < 6; ++layerNdx) {
        for (int colNdx = 0; colNdx <= layerNdx; ++colNdx) {
            const float posX = float(colNdx) / float(6) * 2.0 - 1.0;

            gl_Position = vec4(posX,  1.0, 0.0, 1.0);
            gl_Layer    = layerNdx;
            gl_PointSize = 1.0;
            EmitVertex();

            gl_Position = vec4(posX, -1.0, 0.0, 1.0);
            gl_Layer    = layerNdx;
            gl_PointSize = 1.0;
            EmitVertex();
        }
        EndPrimitive();
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 72) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    for (int layerNdx = 0; layerNdx < 8; ++layerNdx) {
        for (int colNdx = 0; colNdx <= layerNdx; ++colNdx) {
            const float posX = float(colNdx) / float(8) * 2.0 - 1.0;

            gl_Position = vec4(posX,  1.0, 0.0, 1.0);
            gl_Layer    = layerNdx;
            gl_PointSize = 1.0;
            EmitVertex();

            gl_Position = vec4(posX, -1.0, 0.0, 1.0);
            gl_Layer    = layerNdx;
            gl_PointSize = 1.0;
            EmitVertex();
        }
        EndPrimitive();
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 156) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    for (int layerNdx = 0; layerNdx < 12; ++layerNdx) {
        for (int colNdx = 0; colNdx <= layerNdx; ++colNdx) {
            const float posX = float(colNdx) / float(12) * 2.0 - 1.0;

            gl_Position = vec4(posX,  1.0, 0.0, 1.0);
            gl_Layer    = layerNdx;
            gl_PointSize = 1.0;
            EmitVertex();

            gl_Position = vec4(posX, -1.0, 0.0, 1.0);
            gl_Layer    = layerNdx;
            gl_PointSize = 1.0;
            EmitVertex();
        }
        EndPrimitive();
    }
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    for (int layerNdx = 0; layerNdx < 4; ++layerNdx) {
        gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();
        EndPrimitive();
    };
}
#version 450

layout(location = 0) out vec4 o_color;

void main(void)
{
    o_color = vec4( (gl_Layer    % 2) == 1 ? 1.0 : 0.5,
                   ((gl_Layer/2) % 2) == 1 ? 1.0 : 0.5,
                     gl_Layer         == 0 ? 1.0 : 0.0,
                                             1.0);
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 24) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    for (int layerNdx = 0; layerNdx < 6; ++layerNdx) {
        gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();
        EndPrimitive();
    };
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 32) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    for (int layerNdx = 0; layerNdx < 8; ++layerNdx) {
        gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();
        EndPrimitive();
    };
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 48) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    for (int layerNdx = 0; layerNdx < 12; ++layerNdx) {
        gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();
        EndPrimitive();
    };
}
#version 450

layout(points, invocations = 4) in;
layout(triangle_strip, max_vertices = 4) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));
    const int colorNdx = gl_InvocationID % 6;

    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();

    gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();

    gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(points, invocations = 6) in;
layout(triangle_strip, max_vertices = 4) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));
    const int colorNdx = gl_InvocationID % 6;

    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();

    gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();

    gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(points, invocations = 8) in;
layout(triangle_strip, max_vertices = 4) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));
    const int colorNdx = gl_InvocationID % 6;

    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();

    gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();

    gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(points, invocations = 12) in;
layout(triangle_strip, max_vertices = 4) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));
    const int colorNdx = gl_InvocationID % 6;

    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();

    gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();

    gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
    gl_Layer    = gl_InvocationID;
    gl_PointSize = 1.0;
    vert_color  = colors[colorNdx];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(points, invocations = 4) in;
layout(triangle_strip, max_vertices = 6) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const int   layerA = gl_InvocationID;
    const int   layerB = (gl_InvocationID + 1) % 4;
    const float aEnd   = float(layerA) / float(4) * 2.0 - 1.0;
    const float bEnd   = float(layerB) / float(4) * 2.0 - 1.0;

    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(aEnd, -1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(bEnd,  1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(bEnd, -1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(points, invocations = 6) in;
layout(triangle_strip, max_vertices = 6) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const int   layerA = gl_InvocationID;
    const int   layerB = (gl_InvocationID + 1) % 6;
    const float aEnd   = float(layerA) / float(6) * 2.0 - 1.0;
    const float bEnd   = float(layerB) / float(6) * 2.0 - 1.0;

    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(aEnd, -1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(bEnd,  1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(bEnd, -1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(points, invocations = 8) in;
layout(triangle_strip, max_vertices = 6) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const int   layerA = gl_InvocationID;
    const int   layerB = (gl_InvocationID + 1) % 8;
    const float aEnd   = float(layerA) / float(8) * 2.0 - 1.0;
    const float bEnd   = float(layerB) / float(8) * 2.0 - 1.0;

    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(aEnd, -1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(bEnd,  1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(bEnd, -1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(points, invocations = 12) in;
layout(triangle_strip, max_vertices = 6) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const int   layerA = gl_InvocationID;
    const int   layerB = (gl_InvocationID + 1) % 12;
    const float aEnd   = float(layerA) / float(12) * 2.0 - 1.0;
    const float bEnd   = float(layerB) / float(12) * 2.0 - 1.0;

    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(aEnd, -1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(bEnd,  1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(bEnd, -1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(binding = 0) readonly uniform Input {
    int pass;
} uInput;

layout(points) in;
layout(triangle_strip, max_vertices = 16) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));
    for (int layerNdx = 0; layerNdx < 4; ++layerNdx) {
        const int   colorNdx   = layerNdx % 6;
        const vec3  passColor0 = (uInput.pass == 0 ? 0.5 :  1.0) * vec3(colors[colorNdx]);
        const vec4  passColor  = vec4(passColor0, 1.0);
        const float posX       = (uInput.pass == 0 ? 0.0 : -0.5);
        const float posZ       = float(layerNdx + 1 - uInput.pass) / float(8);

        gl_Position = vec4(-1.0, -1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(posX, -1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(posX,  1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        EndPrimitive();
    }
}
#version 450

layout(binding = 0) readonly uniform Input {
    int pass;
} uInput;

layout(points) in;
layout(triangle_strip, max_vertices = 24) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));
    for (int layerNdx = 0; layerNdx < 6; ++layerNdx) {
        const int   colorNdx   = layerNdx % 6;
        const vec3  passColor0 = (uInput.pass == 0 ? 0.5 :  1.0) * vec3(colors[colorNdx]);
        const vec4  passColor  = vec4(passColor0, 1.0);
        const float posX       = (uInput.pass == 0 ? 0.0 : -0.5);
        const float posZ       = float(layerNdx + 1 - uInput.pass) / float(12);

        gl_Position = vec4(-1.0, -1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(posX, -1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(posX,  1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        EndPrimitive();
    }
}
#version 450

layout(binding = 0) readonly uniform Input {
    int pass;
} uInput;

layout(points) in;
layout(triangle_strip, max_vertices = 32) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));
    for (int layerNdx = 0; layerNdx < 8; ++layerNdx) {
        const int   colorNdx   = layerNdx % 6;
        const vec3  passColor0 = (uInput.pass == 0 ? 0.5 :  1.0) * vec3(colors[colorNdx]);
        const vec4  passColor  = vec4(passColor0, 1.0);
        const float posX       = (uInput.pass == 0 ? 0.0 : -0.5);
        const float posZ       = float(layerNdx + 1 - uInput.pass) / float(16);

        gl_Position = vec4(-1.0, -1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(posX, -1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(posX,  1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        EndPrimitive();
    }
}
#version 450

layout(binding = 0) readonly uniform Input {
    int pass;
} uInput;

layout(points) in;
layout(triangle_strip, max_vertices = 48) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));
    for (int layerNdx = 0; layerNdx < 12; ++layerNdx) {
        const int   colorNdx   = layerNdx % 6;
        const vec3  passColor0 = (uInput.pass == 0 ? 0.5 :  1.0) * vec3(colors[colorNdx]);
        const vec4  passColor  = vec4(passColor0, 1.0);
        const float posX       = (uInput.pass == 0 ? 0.0 : -0.5);
        const float posZ       = float(layerNdx + 1 - uInput.pass) / float(24);

        gl_Position = vec4(-1.0, -1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(posX, -1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(posX,  1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        EndPrimitive();
    }
}
#version 450

layout(location = 0) out vec4 o_color;
layout(location = 0) in  vec4 vert_color;
layout(set = 0, binding = 0, rgba8) uniform image1DArray storageImage;

void main(void)
{
    ivec2 coord = ivec2(int(gl_FragCoord.x), gl_Layer);
    vec4 src_color = imageLoad(storageImage, coord);
    o_color = (vert_color + src_color) / 2.0;
    imageStore(storageImage, coord, o_color);
}
#version 450

layout(location = 0) out vec4 o_color;
layout(location = 0) in  vec4 vert_color;
layout(set = 0, binding = 0, rgba8) uniform image2DArray storageImage;

void main(void)
{
    ivec3 coord = ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), gl_Layer);
    vec4 src_color = imageLoad(storageImage, coord);
    o_color = (vert_color + src_color) / 2.0;
    imageStore(storageImage, coord, o_color);
}
#version 450

layout(location = 0) out vec4 o_color;
layout(location = 0) in  vec4 vert_color;
layout(set = 0, binding = 0, rgba8) uniform imageCube storageImage;

void main(void)
{
    ivec3 coord = ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), gl_Layer);
    vec4 src_color = imageLoad(storageImage, coord);
    o_color = (vert_color + src_color) / 2.0;
    imageStore(storageImage, coord, o_color);
}
#version 450

layout(location = 0) out vec4 o_color;
layout(location = 0) in  vec4 vert_color;
layout(set = 0, binding = 0, rgba8) uniform imageCubeArray storageImage;

void main(void)
{
    ivec3 coord = ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), gl_Layer);
    vec4 src_color = imageLoad(storageImage, coord);
    o_color = (vert_color + src_color) / 2.0;
    imageStore(storageImage, coord, o_color);
}
#version 450

layout(location = 0) out vec4 o_color;
layout(location = 0) in  vec4 vert_color;
layout(set = 0, binding = 0, rgba8) uniform image3D storageImage;

void main(void)
{
    ivec3 coord = ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), gl_Layer);
    vec4 src_color = imageLoad(storageImage, coord);
    o_color = (vert_color + src_color) / 2.0;
    imageStore(storageImage, coord, o_color);
}
