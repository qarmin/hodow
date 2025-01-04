#version 450
#extension GL_ARB_shader_viewport_layer_array : require

layout(location = 0) in  vec4 in_position;
layout(location = 1) in  vec4 in_color;
layout(location = 0) out vec4 out_color;

void main(void)
{
    gl_ViewportIndex = gl_VertexIndex / 6;
    gl_Position = in_position;
    out_color = in_color;
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;

void main(void)
{
    out_color = in_color;
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[1];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[2];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[3];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[4];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[5];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[6];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[7];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[8];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[9];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[10];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[11];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[12];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[13];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[14];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[15];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(set=0, binding=0) uniform Colors {
    vec4 color[16];
};

void main(void)
{
    out_color = color[gl_ViewportIndex];
}
#version 450
#extension GL_ARB_shader_viewport_layer_array : require

layout(location = 0) in  vec4 in_position;
layout(location = 1) in  vec4 in_color;
layout(location = 0) out vec4 out_color;

void main(void)
{
    gl_Position = in_position;
    out_color = in_color;
}
#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 1) in  vec4 in_color;
layout(location = 0) out vec4 out_color;

void main(void)
{
    gl_Position = in_position;
    out_color = in_color;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main(void)
{
    if (gl_InvocationID == 0) {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID] = in_color[gl_InvocationID];
}
#version 450
#extension GL_ARB_shader_viewport_layer_array : require

layout(triangles, equal_spacing, cw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

void main(void)
{
    gl_ViewportIndex = gl_PrimitiveID / 2;
    gl_Position = gl_in[0].gl_Position * gl_TessCoord.x +
                  gl_in[1].gl_Position * gl_TessCoord.y +
                  gl_in[2].gl_Position * gl_TessCoord.z;

    out_color = in_color[0] * gl_TessCoord.x +
                in_color[1] * gl_TessCoord.y +
                in_color[2] * gl_TessCoord.z;
}
