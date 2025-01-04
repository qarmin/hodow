#version 450

layout(location = 0) in vec4 v_position;

out gl_PerVertex {
    vec4  gl_Position;
};

void main (void)
{
    gl_Position = v_position;
}
#version 450

layout(location = 0) out vec4 o_color;

void main (void)
{
    o_color = vec4(1.0, gl_FragCoord.z, 0.0, 1.0);
}
#version 450

layout(location = 0) in vec4 v_position;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};

void main (void)
{
    gl_Position = v_position;
    gl_PointSize = 1.0;
}
#version 450

layout(location = 0) in vec4 v_position;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};

void main (void)
{
    gl_Position = v_position;
    gl_PointSize = 12.0;
}
#version 450

layout(location = 0) in vec4 v_position;    // we are passing ClipDistance in w component

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
};

void main (void)
{
    gl_Position        = vec4(v_position.xyz, 1.0);
    gl_ClipDistance[0] = v_position.w;
}
#version 450

layout(location = 0) out vec4 o_color;

void main (void)
{
    o_color = vec4(1.0, 1.0, 1.0, 0.5);
}
#version 450

layout(location = 0) in vec4 v_position;    // we are passing ClipDistance in w component

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
};

void main (void)
{
    gl_Position        = vec4(v_position.xyz, 1.0);
    gl_ClipDistance[0] = 0.0;
    gl_ClipDistance[1] = v_position.w;
}
#version 450

layout(location = 0) in vec4 v_position;    // we are passing ClipDistance in w component

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
};

void main (void)
{
    gl_Position        = vec4(v_position.xyz, 1.0);
    gl_ClipDistance[0] = 0.0;
    gl_ClipDistance[1] = 0.0;
    gl_ClipDistance[2] = v_position.w;
}
#version 450

layout(location = 0) in vec4 v_position;    // we are passing ClipDistance in w component

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
};

void main (void)
{
    gl_Position        = vec4(v_position.xyz, 1.0);
    gl_ClipDistance[0] = 0.0;
    gl_ClipDistance[1] = 0.0;
    gl_ClipDistance[2] = 0.0;
    gl_ClipDistance[3] = v_position.w;
}
#version 450

layout(location = 0) in vec4 v_position;    // we are passing ClipDistance in w component

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
};

void main (void)
{
    gl_Position        = vec4(v_position.xyz, 1.0);
    gl_ClipDistance[0] = 0.0;
    gl_ClipDistance[1] = 0.0;
    gl_ClipDistance[2] = 0.0;
    gl_ClipDistance[3] = 0.0;
    gl_ClipDistance[4] = v_position.w;
}
#version 450

layout(location = 0) in vec4 v_position;    // we are passing ClipDistance in w component

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
};

void main (void)
{
    gl_Position        = vec4(v_position.xyz, 1.0);
    gl_ClipDistance[0] = 0.0;
    gl_ClipDistance[1] = 0.0;
    gl_ClipDistance[2] = 0.0;
    gl_ClipDistance[3] = 0.0;
    gl_ClipDistance[4] = 0.0;
    gl_ClipDistance[5] = v_position.w;
}
#version 450

layout(location = 0) in vec4 v_position;    // we are passing ClipDistance in w component

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
};

void main (void)
{
    gl_Position        = vec4(v_position.xyz, 1.0);
    gl_ClipDistance[0] = 0.0;
    gl_ClipDistance[1] = 0.0;
    gl_ClipDistance[2] = 0.0;
    gl_ClipDistance[3] = 0.0;
    gl_ClipDistance[4] = 0.0;
    gl_ClipDistance[5] = 0.0;
    gl_ClipDistance[6] = v_position.w;
}
#version 450

layout(location = 0) in vec4 v_position;    // we are passing ClipDistance in w component

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
};

void main (void)
{
    gl_Position        = vec4(v_position.xyz, 1.0);
    gl_ClipDistance[0] = 0.0;
    gl_ClipDistance[1] = 0.0;
    gl_ClipDistance[2] = 0.0;
    gl_ClipDistance[3] = 0.0;
    gl_ClipDistance[4] = 0.0;
    gl_ClipDistance[5] = 0.0;
    gl_ClipDistance[6] = 0.0;
    gl_ClipDistance[7] = v_position.w;
}
#version 450
layout(location = 0) in vec4 v_position;
out gl_PerVertex {
  vec4  gl_Position;
  float gl_CullDistance[3];
};
void main (void)
{
  gl_Position = v_position;
  gl_CullDistance[0] = 0.0 - float(gl_VertexIndex == 2);
  gl_CullDistance[1] = 0.0 - float(gl_VertexIndex == 1);
  gl_CullDistance[2] = 0.0 - float(gl_VertexIndex == 0);
}
#version 450
layout(location = 0) out vec4 o_color;
void main (void)
{
  o_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;

void main (void)
{
    o_color = vec4(in_color.rgb + vec3(0.0, 0.0, 0.5), 1.0);
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[1];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[0], 0.0,  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[2];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[1], 0.0,  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[3];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[1], 0.0,  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[4];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[2], 0.0,  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[5];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[2], 0.0,  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
    gl_ClipDistance[5] = (barNdx == 5 ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[6];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[3], 0.0,  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
    gl_ClipDistance[5] = (barNdx == 5 ? v_position.y : 0.0);
    gl_ClipDistance[6] = (barNdx == 6 ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[7];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[3], 0.0,  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
    gl_ClipDistance[5] = (barNdx == 5 ? v_position.y : 0.0);
    gl_ClipDistance[6] = (barNdx == 6 ? v_position.y : 0.0);
    gl_ClipDistance[7] = (barNdx == 7 ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[8];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[4], 0.0,  1.0);
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[2];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[3];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[4]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[4]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[4];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
    gl_out[gl_InvocationID].gl_ClipDistance[5] = gl_in[gl_InvocationID].gl_ClipDistance[5];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[4]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[4]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[5]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[5]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[5];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
    gl_out[gl_InvocationID].gl_ClipDistance[5] = gl_in[gl_InvocationID].gl_ClipDistance[5];
    gl_out[gl_InvocationID].gl_ClipDistance[6] = gl_in[gl_InvocationID].gl_ClipDistance[6];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[4]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[4]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[5]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[5]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[6]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[6]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[6];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
    gl_out[gl_InvocationID].gl_ClipDistance[5] = gl_in[gl_InvocationID].gl_ClipDistance[5];
    gl_out[gl_InvocationID].gl_ClipDistance[6] = gl_in[gl_InvocationID].gl_ClipDistance[6];
    gl_out[gl_InvocationID].gl_ClipDistance[7] = gl_in[gl_InvocationID].gl_ClipDistance[7];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[4]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[4]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[5]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[5]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[6]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[6]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[6];
    gl_ClipDistance[7] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[7]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[7]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[7];
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[0].gl_ClipDistance[5];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[1].gl_ClipDistance[5];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[2].gl_ClipDistance[5];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[0].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[0].gl_ClipDistance[6];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[1].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[1].gl_ClipDistance[6];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[2].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[2].gl_ClipDistance[6];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[0].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[0].gl_ClipDistance[6];
    gl_ClipDistance[7] = gl_in[0].gl_ClipDistance[7];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[1].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[1].gl_ClipDistance[6];
    gl_ClipDistance[7] = gl_in[1].gl_ClipDistance[7];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[2].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[2].gl_ClipDistance[6];
    gl_ClipDistance[7] = gl_in[2].gl_ClipDistance[7];
    EmitVertex();
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 8; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 1; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 2; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 3; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 4; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 5; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 6; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 7; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 8; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 8; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[8];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 8; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 8; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 8; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    EmitVertex();
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[5] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[6] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[5] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[6] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[1];
in float gl_CullDistance[7];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[0], gl_CullDistance[3],  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[5] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[5] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[2];
in float gl_CullDistance[6];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[1], gl_CullDistance[3],  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[3];
in float gl_CullDistance[5];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[1], gl_CullDistance[2],  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[4];
in float gl_CullDistance[4];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[2], gl_CullDistance[2],  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[5];
in float gl_CullDistance[3];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[2], gl_CullDistance[1],  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
    gl_ClipDistance[5] = (barNdx == 5 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
    gl_ClipDistance[5] = (barNdx == 5 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.y < 0) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[6];
in float gl_CullDistance[2];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[3], gl_CullDistance[1],  1.0);
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
    gl_ClipDistance[5] = (barNdx == 5 ? v_position.y : 0.0);
    gl_ClipDistance[6] = (barNdx == 6 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
    gl_ClipDistance[5] = (barNdx == 5 ? v_position.y : 0.0);
    gl_ClipDistance[6] = (barNdx == 6 ? v_position.y : 0.0);
    gl_CullDistance[0] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;
in float gl_ClipDistance[7];
in float gl_CullDistance[1];

void main (void)
{
    o_color = vec4(in_color.r, gl_ClipDistance[3], gl_CullDistance[0],  1.0);
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[4] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[5] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[6] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_CullDistance[0] = gl_TessCoord.x * gl_in[0].gl_CullDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[0];
    gl_CullDistance[1] = gl_TessCoord.x * gl_in[0].gl_CullDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[1];
    gl_CullDistance[2] = gl_TessCoord.x * gl_in[0].gl_CullDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[2];
    gl_CullDistance[3] = gl_TessCoord.x * gl_in[0].gl_CullDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[3];
    gl_CullDistance[4] = gl_TessCoord.x * gl_in[0].gl_CullDistance[4]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[4]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[4];
    gl_CullDistance[5] = gl_TessCoord.x * gl_in[0].gl_CullDistance[5]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[5]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[5];
    gl_CullDistance[6] = gl_TessCoord.x * gl_in[0].gl_CullDistance[6]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[6]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[6];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_CullDistance[0] = 0.1f;
    gl_CullDistance[1] = 0.1f;
    gl_CullDistance[2] = 0.1f;
    gl_CullDistance[3] = 0.1f;
    gl_CullDistance[4] = 0.1f;
    gl_CullDistance[5] = 0.1f;
    gl_CullDistance[6] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_CullDistance[1] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_CullDistance[2] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_CullDistance[3] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[4] = (gl_in[gl_InvocationID].gl_CullDistance[4] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[5] = (gl_in[gl_InvocationID].gl_CullDistance[5] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[6] = (gl_in[gl_InvocationID].gl_CullDistance[6] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[4] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[5] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
    gl_CullDistance[0] = gl_TessCoord.x * gl_in[0].gl_CullDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[0];
    gl_CullDistance[1] = gl_TessCoord.x * gl_in[0].gl_CullDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[1];
    gl_CullDistance[2] = gl_TessCoord.x * gl_in[0].gl_CullDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[2];
    gl_CullDistance[3] = gl_TessCoord.x * gl_in[0].gl_CullDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[3];
    gl_CullDistance[4] = gl_TessCoord.x * gl_in[0].gl_CullDistance[4]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[4]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[4];
    gl_CullDistance[5] = gl_TessCoord.x * gl_in[0].gl_CullDistance[5]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[5]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[5];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_CullDistance[0] = 0.1f;
    gl_CullDistance[1] = 0.1f;
    gl_CullDistance[2] = 0.1f;
    gl_CullDistance[3] = 0.1f;
    gl_CullDistance[4] = 0.1f;
    gl_CullDistance[5] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_CullDistance[1] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_CullDistance[2] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_CullDistance[3] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[4] = (gl_in[gl_InvocationID].gl_CullDistance[4] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[5] = (gl_in[gl_InvocationID].gl_CullDistance[5] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[4] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[2];
    gl_CullDistance[0] = gl_TessCoord.x * gl_in[0].gl_CullDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[0];
    gl_CullDistance[1] = gl_TessCoord.x * gl_in[0].gl_CullDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[1];
    gl_CullDistance[2] = gl_TessCoord.x * gl_in[0].gl_CullDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[2];
    gl_CullDistance[3] = gl_TessCoord.x * gl_in[0].gl_CullDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[3];
    gl_CullDistance[4] = gl_TessCoord.x * gl_in[0].gl_CullDistance[4]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[4]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[4];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_CullDistance[0] = 0.1f;
    gl_CullDistance[1] = 0.1f;
    gl_CullDistance[2] = 0.1f;
    gl_CullDistance[3] = 0.1f;
    gl_CullDistance[4] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_CullDistance[1] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_CullDistance[2] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_CullDistance[3] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[4] = (gl_in[gl_InvocationID].gl_CullDistance[4] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[3];
    gl_CullDistance[0] = gl_TessCoord.x * gl_in[0].gl_CullDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[0];
    gl_CullDistance[1] = gl_TessCoord.x * gl_in[0].gl_CullDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[1];
    gl_CullDistance[2] = gl_TessCoord.x * gl_in[0].gl_CullDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[2];
    gl_CullDistance[3] = gl_TessCoord.x * gl_in[0].gl_CullDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[3];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_CullDistance[0] = 0.1f;
    gl_CullDistance[1] = 0.1f;
    gl_CullDistance[2] = 0.1f;
    gl_CullDistance[3] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_CullDistance[1] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_CullDistance[2] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_CullDistance[3] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[4]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[4]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[4];
    gl_CullDistance[0] = gl_TessCoord.x * gl_in[0].gl_CullDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[0];
    gl_CullDistance[1] = gl_TessCoord.x * gl_in[0].gl_CullDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[1];
    gl_CullDistance[2] = gl_TessCoord.x * gl_in[0].gl_CullDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[2];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
    gl_CullDistance[0] = 0.1f;
    gl_CullDistance[1] = 0.1f;
    gl_CullDistance[2] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_CullDistance[1] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_CullDistance[2] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
    gl_out[gl_InvocationID].gl_ClipDistance[5] = gl_in[gl_InvocationID].gl_ClipDistance[5];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[4]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[4]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[5]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[5]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[5];
    gl_CullDistance[0] = gl_TessCoord.x * gl_in[0].gl_CullDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[0];
    gl_CullDistance[1] = gl_TessCoord.x * gl_in[0].gl_CullDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[1];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
    gl_ClipDistance[5] = (barNdx == 5 ? v_position.y : 0.0);
    gl_CullDistance[0] = 0.1f;
    gl_CullDistance[1] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
    gl_out[gl_InvocationID].gl_ClipDistance[5] = gl_in[gl_InvocationID].gl_ClipDistance[5];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_CullDistance[1] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
    gl_out[gl_InvocationID].gl_ClipDistance[5] = gl_in[gl_InvocationID].gl_ClipDistance[5];
    gl_out[gl_InvocationID].gl_ClipDistance[6] = gl_in[gl_InvocationID].gl_ClipDistance[6];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    gl_ClipDistance[0] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[1]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[1]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[2]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[2]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[3]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[3]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[4]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[4]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[5]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[5]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[6]
                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[6]
                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[6];
    gl_CullDistance[0] = gl_TessCoord.x * gl_in[0].gl_CullDistance[0]
                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[0]
                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[0];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
    gl_ClipDistance[2] = (barNdx == 2 ? v_position.y : 0.0);
    gl_ClipDistance[3] = (barNdx == 3 ? v_position.y : 0.0);
    gl_ClipDistance[4] = (barNdx == 4 ? v_position.y : 0.0);
    gl_ClipDistance[5] = (barNdx == 5 ? v_position.y : 0.0);
    gl_ClipDistance[6] = (barNdx == 6 ? v_position.y : 0.0);
    gl_CullDistance[0] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
    gl_out[gl_InvocationID].gl_ClipDistance[5] = gl_in[gl_InvocationID].gl_ClipDistance[5];
    gl_out[gl_InvocationID].gl_ClipDistance[6] = gl_in[gl_InvocationID].gl_ClipDistance[6];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_CullDistance[0] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[5] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[6] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_CullDistance[0] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[5] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[6] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_CullDistance[0] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[5] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[6] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[0].gl_CullDistance[1] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[0].gl_CullDistance[2] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[0].gl_CullDistance[3] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[0].gl_CullDistance[4] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[5] = (gl_in[0].gl_CullDistance[5] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[6] = (gl_in[0].gl_CullDistance[6] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[1].gl_CullDistance[1] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[1].gl_CullDistance[2] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[1].gl_CullDistance[3] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[1].gl_CullDistance[4] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[5] = (gl_in[1].gl_CullDistance[5] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[6] = (gl_in[1].gl_CullDistance[6] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[2].gl_CullDistance[1] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[2].gl_CullDistance[2] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[2].gl_CullDistance[3] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[2].gl_CullDistance[4] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[5] = (gl_in[2].gl_CullDistance[5] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[6] = (gl_in[2].gl_CullDistance[6] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_CullDistance[0] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[5] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_CullDistance[0] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[5] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_CullDistance[0] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[5] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[0].gl_CullDistance[1] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[0].gl_CullDistance[2] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[0].gl_CullDistance[3] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[0].gl_CullDistance[4] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[5] = (gl_in[0].gl_CullDistance[5] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[1].gl_CullDistance[1] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[1].gl_CullDistance[2] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[1].gl_CullDistance[3] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[1].gl_CullDistance[4] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[5] = (gl_in[1].gl_CullDistance[5] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[2].gl_CullDistance[1] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[2].gl_CullDistance[2] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[2].gl_CullDistance[3] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[2].gl_CullDistance[4] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[5] = (gl_in[2].gl_CullDistance[5] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_CullDistance[0] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_CullDistance[0] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_CullDistance[0] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[4] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[0].gl_CullDistance[1] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[0].gl_CullDistance[2] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[0].gl_CullDistance[3] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[0].gl_CullDistance[4] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[1].gl_CullDistance[1] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[1].gl_CullDistance[2] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[1].gl_CullDistance[3] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[1].gl_CullDistance[4] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[2].gl_CullDistance[1] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[2].gl_CullDistance[2] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[2].gl_CullDistance[3] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[2].gl_CullDistance[4] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_CullDistance[0] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_CullDistance[0] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_CullDistance[0] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[3] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[0].gl_CullDistance[1] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[0].gl_CullDistance[2] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[0].gl_CullDistance[3] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[1].gl_CullDistance[1] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[1].gl_CullDistance[2] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[1].gl_CullDistance[3] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[2].gl_CullDistance[1] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[2].gl_CullDistance[2] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[2].gl_CullDistance[3] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
    gl_CullDistance[0] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
    gl_CullDistance[0] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
    gl_CullDistance[0] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[2] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[0].gl_CullDistance[1] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[0].gl_CullDistance[2] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[1].gl_CullDistance[1] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[1].gl_CullDistance[2] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[2].gl_CullDistance[1] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[2].gl_CullDistance[2] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[0].gl_ClipDistance[5];
    gl_CullDistance[0] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[1].gl_ClipDistance[5];
    gl_CullDistance[0] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[2].gl_ClipDistance[5];
    gl_CullDistance[0] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_CullDistance[1] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[0].gl_ClipDistance[5];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[0].gl_CullDistance[1] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[1].gl_ClipDistance[5];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[1].gl_CullDistance[1] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[2].gl_ClipDistance[5];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[2].gl_CullDistance[1] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[0].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[0].gl_ClipDistance[6];
    gl_CullDistance[0] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[1].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[1].gl_ClipDistance[6];
    gl_CullDistance[0] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[2].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[2].gl_ClipDistance[6];
    gl_CullDistance[0] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[0].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[0].gl_ClipDistance[6];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[1].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[1].gl_ClipDistance[6];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[2].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[2].gl_ClipDistance[6];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_CullDistance[1] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_CullDistance[2] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_CullDistance[3] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[4] = (gl_in[gl_InvocationID].gl_CullDistance[4] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[5] = (gl_in[gl_InvocationID].gl_CullDistance[5] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[6] = (gl_in[gl_InvocationID].gl_CullDistance[6] == 0.1f) ? 0.3f : 0.2f;
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[0].gl_CullDistance[1] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[0].gl_CullDistance[2] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[0].gl_CullDistance[3] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[0].gl_CullDistance[4] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[5] = (gl_in[0].gl_CullDistance[5] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[6] = (gl_in[0].gl_CullDistance[6] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[1].gl_CullDistance[1] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[1].gl_CullDistance[2] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[1].gl_CullDistance[3] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[1].gl_CullDistance[4] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[5] = (gl_in[1].gl_CullDistance[5] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[6] = (gl_in[1].gl_CullDistance[6] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[2].gl_CullDistance[1] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[2].gl_CullDistance[2] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[2].gl_CullDistance[3] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[2].gl_CullDistance[4] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[5] = (gl_in[2].gl_CullDistance[5] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[6] = (gl_in[2].gl_CullDistance[6] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_CullDistance[1] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_CullDistance[2] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_CullDistance[3] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[4] = (gl_in[gl_InvocationID].gl_CullDistance[4] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[5] = (gl_in[gl_InvocationID].gl_CullDistance[5] == 0.1f) ? 0.3f : 0.2f;
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[0].gl_CullDistance[1] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[0].gl_CullDistance[2] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[0].gl_CullDistance[3] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[0].gl_CullDistance[4] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[5] = (gl_in[0].gl_CullDistance[5] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[1].gl_CullDistance[1] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[1].gl_CullDistance[2] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[1].gl_CullDistance[3] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[1].gl_CullDistance[4] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[5] = (gl_in[1].gl_CullDistance[5] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[2].gl_CullDistance[1] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[2].gl_CullDistance[2] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[2].gl_CullDistance[3] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[2].gl_CullDistance[4] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[5] = (gl_in[2].gl_CullDistance[5] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_CullDistance[1] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_CullDistance[2] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_CullDistance[3] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[4] = (gl_in[gl_InvocationID].gl_CullDistance[4] == 0.1f) ? 0.3f : 0.2f;
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[0].gl_CullDistance[1] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[0].gl_CullDistance[2] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[0].gl_CullDistance[3] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[0].gl_CullDistance[4] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[1].gl_CullDistance[1] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[1].gl_CullDistance[2] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[1].gl_CullDistance[3] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[1].gl_CullDistance[4] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[2].gl_CullDistance[1] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[2].gl_CullDistance[2] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[2].gl_CullDistance[3] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[4] = (gl_in[2].gl_CullDistance[4] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_CullDistance[1] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_CullDistance[2] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_CullDistance[3] == 0.1f) ? 0.3f : 0.2f;
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[0].gl_CullDistance[1] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[0].gl_CullDistance[2] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[0].gl_CullDistance[3] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[1].gl_CullDistance[1] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[1].gl_CullDistance[2] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[1].gl_CullDistance[3] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[2].gl_CullDistance[1] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[2].gl_CullDistance[2] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[3] = (gl_in[2].gl_CullDistance[3] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_CullDistance[1] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_CullDistance[2] == 0.1f) ? 0.3f : 0.2f;
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[0].gl_CullDistance[1] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[0].gl_CullDistance[2] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[1].gl_CullDistance[1] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[1].gl_CullDistance[2] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[2].gl_CullDistance[1] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[2] = (gl_in[2].gl_CullDistance[2] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
    gl_out[gl_InvocationID].gl_ClipDistance[5] = gl_in[gl_InvocationID].gl_ClipDistance[5];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? 0.3f : 0.2f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_CullDistance[1] == 0.1f) ? 0.3f : 0.2f;
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[0].gl_ClipDistance[5];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[0].gl_CullDistance[1] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[1].gl_ClipDistance[5];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[1].gl_CullDistance[1] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[2].gl_ClipDistance[5];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
        gl_CullDistance[1] = (gl_in[2].gl_CullDistance[1] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_ClipDistance[4] = gl_in[gl_InvocationID].gl_ClipDistance[4];
    gl_out[gl_InvocationID].gl_ClipDistance[5] = gl_in[gl_InvocationID].gl_ClipDistance[5];
    gl_out[gl_InvocationID].gl_ClipDistance[6] = gl_in[gl_InvocationID].gl_ClipDistance[6];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_CullDistance[0] == 0.1f) ? 0.3f : 0.2f;
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    gl_ClipDistance[0] = gl_in[0].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[0].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[0].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[0].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[0].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[0].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[0].gl_ClipDistance[6];
        gl_CullDistance[0] = (gl_in[0].gl_CullDistance[0] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    gl_ClipDistance[0] = gl_in[1].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[1].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[1].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[1].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[1].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[1].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[1].gl_ClipDistance[6];
        gl_CullDistance[0] = (gl_in[1].gl_CullDistance[0] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    gl_ClipDistance[0] = gl_in[2].gl_ClipDistance[0];
    gl_ClipDistance[1] = gl_in[2].gl_ClipDistance[1];
    gl_ClipDistance[2] = gl_in[2].gl_ClipDistance[2];
    gl_ClipDistance[3] = gl_in[2].gl_ClipDistance[3];
    gl_ClipDistance[4] = gl_in[2].gl_ClipDistance[4];
    gl_ClipDistance[5] = gl_in[2].gl_ClipDistance[5];
    gl_ClipDistance[6] = gl_in[2].gl_ClipDistance[6];
        gl_CullDistance[0] = (gl_in[2].gl_CullDistance[0] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    EmitVertex();
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 7; ++i)
        gl_CullDistance[i] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 7; ++i)
        gl_CullDistance[i] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 6; ++i)
        gl_CullDistance[i] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 6; ++i)
        gl_CullDistance[i] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 5; ++i)
        gl_CullDistance[i] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 5; ++i)
        gl_CullDistance[i] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 4; ++i)
        gl_CullDistance[i] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 4; ++i)
        gl_CullDistance[i] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 3; ++i)
        gl_CullDistance[i] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 3; ++i)
        gl_CullDistance[i] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 2; ++i)
        gl_CullDistance[i] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 2; ++i)
        gl_CullDistance[i] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 1; ++i)
        gl_CullDistance[i] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 1; ++i)
        gl_CullDistance[i] = (gl_Position.y < 0) ? -0.5f : 0.5f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 1; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
    {
    gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
        gl_CullDistance[i] = gl_TessCoord.x * gl_in[0].gl_CullDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_CullDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_CullDistance[i];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 7; ++i)
        gl_CullDistance[i] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 1; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    }
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 2; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
    {
    gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
        gl_CullDistance[i] = gl_TessCoord.x * gl_in[0].gl_CullDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_CullDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_CullDistance[i];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 6; ++i)
        gl_CullDistance[i] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 2; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    }
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 3; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
    {
    gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
        gl_CullDistance[i] = gl_TessCoord.x * gl_in[0].gl_CullDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_CullDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_CullDistance[i];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 5; ++i)
        gl_CullDistance[i] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 3; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    }
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 4; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
    gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
        gl_CullDistance[i] = gl_TessCoord.x * gl_in[0].gl_CullDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_CullDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_CullDistance[i];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 4; ++i)
        gl_CullDistance[i] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 4; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    }
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 5; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
    {
    gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
        gl_CullDistance[i] = gl_TessCoord.x * gl_in[0].gl_CullDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_CullDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_CullDistance[i];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 3; ++i)
        gl_CullDistance[i] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 5; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    }
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 6; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
    {
    gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
        gl_CullDistance[i] = gl_TessCoord.x * gl_in[0].gl_CullDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_CullDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_CullDistance[i];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 2; ++i)
        gl_CullDistance[i] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 6; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    }
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 7; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
    {
    gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
}
#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
        gl_CullDistance[i] = gl_TessCoord.x * gl_in[0].gl_CullDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_CullDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_CullDistance[i];
}
#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 1; ++i)
        gl_CullDistance[i] = 0.1f;
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 7; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? ((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.2f;
    }
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
    {
    gl_CullDistance[i] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
    {
    gl_CullDistance[i] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
    {
    gl_CullDistance[i] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
    {
    gl_CullDistance[i] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
    {
    gl_CullDistance[i] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
    {
    gl_CullDistance[i] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
    {
    gl_CullDistance[i] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
    {
    gl_CullDistance[i] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
    {
    gl_CullDistance[i] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
    gl_CullDistance[i] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
    gl_CullDistance[i] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
    gl_CullDistance[i] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
    {
    gl_CullDistance[i] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
    {
    gl_CullDistance[i] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
    {
    gl_CullDistance[i] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
    {
    gl_CullDistance[i] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
    {
    gl_CullDistance[i] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
    {
    gl_CullDistance[i] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
    {
    gl_CullDistance[i] = (gl_in[0].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
    {
    gl_CullDistance[i] = (gl_in[1].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
    {
    gl_CullDistance[i] = (gl_in[2].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    }
    EmitVertex();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.1f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.1f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.1f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 1; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? 0.3f : 0.2f;
    }
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[1];
    float gl_CullDistance[7];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 1; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 7; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 2; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? 0.3f : 0.2f;
    }
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
    float gl_CullDistance[6];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 2; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 6; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 3; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? 0.3f : 0.2f;
    }
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[3];
    float gl_CullDistance[5];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 3; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 5; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 4; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? 0.3f : 0.2f;
    }
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 5; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? 0.3f : 0.2f;
    }
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
    float gl_CullDistance[3];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 3; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 6; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? 0.3f : 0.2f;
    }
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[6];
    float gl_CullDistance[2];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 6; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 2; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 7; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? 0.3f : 0.2f;
    }
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[7];
    float gl_CullDistance[1];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 7; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 1; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
