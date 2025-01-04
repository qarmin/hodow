#version 450
layout (local_size_x = 2, local_size_y = 2, local_size_z = 2) in;
layout(binding = 0) writeonly buffer Output {
    uint values[];
} sb_out;

void main (void) {
    uvec3 indexUvec3 = uvec3 (gl_GlobalInvocationID.x,
                              gl_GlobalInvocationID.y * gl_NumWorkGroups.x * gl_WorkGroupSize.x,
                              gl_GlobalInvocationID.z * gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupSize.x * gl_WorkGroupSize.y);
    uint index = indexUvec3.x + indexUvec3.y + indexUvec3.z;
    sb_out.values[index] += index;
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) writeonly buffer Output {
    uint values[];
} sb_out;

void main (void) {
    uvec3 indexUvec3 = uvec3 (gl_GlobalInvocationID.x,
                              gl_GlobalInvocationID.y * gl_NumWorkGroups.x * gl_WorkGroupSize.x,
                              gl_GlobalInvocationID.z * gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupSize.x * gl_WorkGroupSize.y);
    uint index = indexUvec3.x + indexUvec3.y + indexUvec3.z;
    sb_out.values[index] += index;
}
#version 450
layout (local_size_x = 3, local_size_y = 7, local_size_z = 3) in;
layout(binding = 0) writeonly buffer Output {
    uint values[];
} sb_out;

void main (void) {
    uvec3 indexUvec3 = uvec3 (gl_GlobalInvocationID.x,
                              gl_GlobalInvocationID.y * gl_NumWorkGroups.x * gl_WorkGroupSize.x,
                              gl_GlobalInvocationID.z * gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupSize.x * gl_WorkGroupSize.y);
    uint index = indexUvec3.x + indexUvec3.y + indexUvec3.z;
    sb_out.values[index] += index;
}
#version 450
vec4 positions[4] = vec4[](
    vec4(-1.0f, -1.0f, 0.0f, 1.0f),
    vec4( 1.0f, -1.0f, 0.0f, 1.0f),
    vec4(-1.0f,  1.0f, 0.0f, 1.0f),
    vec4( 1.0f,  1.0f, 0.0f, 1.0f)
);

layout(location = 0) out vec4 out_color;

void main() {
    gl_Position = positions[gl_VertexIndex % 3];
    gl_PointSize = 1.0f;
    out_color = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
vec4 positions[3] = vec4[](
    vec4(-0.5f, -0.5f, 0.0f, 1.0f),
    vec4( 0.5f, -0.5f, 0.0f, 1.0f),
    vec4( 0.0f,  0.5f, 0.0f, 1.0f)
);
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if( gl_InvocationID == 0 )
    {
        gl_TessLevelInner[0] = 4.0f;
        gl_TessLevelOuter[0] = 4.0f;
        gl_TessLevelOuter[1] = 4.0f;
        gl_TessLevelOuter[2] = 4.0f;
    }
        out_color[gl_InvocationID] = in_color[gl_InvocationID];
        gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, equal_spacing, ccw) in;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    gl_Position = u * gl_in[0].gl_Position + v * gl_in[1].gl_Position + w * gl_in[2].gl_Position;
    out_color = in_color[0];
}
#version 450
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main()
{
    out_color = in_color;
}
#version 450
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
layout (set=0, binding=0, std430) readonly buffer DepthsBlock { float depths[5]; } depthsBuffer;
void main()
{
    out_color = in_color;
    gl_FragDepth = depthsBuffer.depths[((int(gl_FragCoord.x) + int(gl_FragCoord.y)) % 5)];
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 16) out;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    out_color = in_color[0];
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, equal_spacing, ccw) in;
layout(point_mode) in;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    gl_Position = u * gl_in[0].gl_Position + v * gl_in[1].gl_Position + w * gl_in[2].gl_Position;
    gl_PointSize = 1.0;
    out_color = in_color[0];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
vec4 positions[3] = vec4[](
    vec4(-0.5f, -0.5f, 0.0f, 1.0f),
    vec4( 0.5f, -0.5f, 0.0f, 1.0f),
    vec4( 0.0f,  0.5f, 0.0f, 1.0f)
);
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if( gl_InvocationID == 0 )
    {
        gl_TessLevelInner[0] = 4.0f;
        gl_TessLevelOuter[0] = 4.0f;
        gl_TessLevelOuter[1] = 4.0f;
        gl_TessLevelOuter[2] = 4.0f;
    }

    if (gl_InvocationID < 1)
    {
        out_color[gl_InvocationID] = in_color[gl_InvocationID];
        gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    }
    else
    {
        out_color[gl_InvocationID] = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue
        gl_out[gl_InvocationID].gl_Position = positions[gl_InvocationID];
    }
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
vec4 positions[3] = vec4[](
    vec4(-0.5f, -0.5f, 0.0f, 1.0f),
    vec4( 0.5f, -0.5f, 0.0f, 1.0f),
    vec4( 0.0f,  0.5f, 0.0f, 1.0f)
);
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if( gl_InvocationID == 0 )
    {
        gl_TessLevelInner[0] = 4.0f;
        gl_TessLevelOuter[0] = 4.0f;
        gl_TessLevelOuter[1] = 4.0f;
        gl_TessLevelOuter[2] = 4.0f;
    }

    if (gl_InvocationID < 2)
    {
        out_color[gl_InvocationID] = in_color[gl_InvocationID];
        gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    }
    else
    {
        out_color[gl_InvocationID] = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue
        gl_out[gl_InvocationID].gl_Position = positions[gl_InvocationID];
    }
}
#version 450
vec4 positions[4] = vec4[](
    vec4(-1.0f, -1.0f, 0.0f, 1.0f),
    vec4( 1.0f, -1.0f, 0.0f, 1.0f),
    vec4(-1.0f,  1.0f, 0.0f, 1.0f),
    vec4( 1.0f,  1.0f, 0.0f, 1.0f)
);

layout(location = 0) out vec4 out_color;

void main() {
    gl_Position = positions[gl_VertexIndex % 4];
    gl_PointSize = 1.0f;
    out_color = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 2) out;
vec4 positions[2] = vec4[](
    vec4(-0.5f,  0.0f, 0.0f, 1.0f),
    vec4( 0.5f,  0.0f, 0.0f, 1.0f)
);
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if( gl_InvocationID == 0 )
    {
        gl_TessLevelOuter[0] = 4.0f; // Number of lines
        gl_TessLevelOuter[1] = 4.0f; // Number of segments per line
    }
        out_color[gl_InvocationID] = in_color[gl_InvocationID];
        gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(isolines, equal_spacing) in;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    const float u = gl_TessCoord.x; // Position along the line
    const float v = gl_TessCoord.y; // Which line
    gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, u);
    out_color = in_color[0];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(isolines, equal_spacing) in;
layout(point_mode) in;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    const float u = gl_TessCoord.x; // Position along the line
    const float v = gl_TessCoord.y; // Which line
    gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, u);
    gl_PointSize = 1.0;
    out_color = in_color[0];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 2) out;
vec4 positions[2] = vec4[](
    vec4(-0.5f,  0.0f, 0.0f, 1.0f),
    vec4( 0.5f,  0.0f, 0.0f, 1.0f)
);
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if( gl_InvocationID == 0 )
    {
        gl_TessLevelOuter[0] = 4.0f; // Number of lines
        gl_TessLevelOuter[1] = 4.0f; // Number of segments per line
    }

    if (gl_InvocationID < 1)
    {
        out_color[gl_InvocationID] = in_color[gl_InvocationID];
        gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    }
    else
    {
        out_color[gl_InvocationID] = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue
        gl_out[gl_InvocationID].gl_Position = positions[gl_InvocationID];
    }
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 4) out;
vec4 positions[4] = vec4[](
    vec4(-1.0f, -1.0f, 0.0f, 1.0f),
    vec4( 1.0f, -1.0f, 0.0f, 1.0f),
    vec4(-1.0f,  1.0f, 0.0f, 1.0f),
    vec4( 1.0f,  1.0f, 0.0f, 1.0f)
);
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if( gl_InvocationID == 0 )
    {
        gl_TessLevelInner[0] = 4.0f;
        gl_TessLevelInner[1] = 4.0f;
        gl_TessLevelOuter[0] = 4.0f;
        gl_TessLevelOuter[1] = 4.0f;
        gl_TessLevelOuter[2] = 4.0f;
        gl_TessLevelOuter[3] = 4.0f;
    }
        out_color[gl_InvocationID] = in_color[gl_InvocationID];
        gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(quads, equal_spacing, ccw) in;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    gl_Position = (1 - u) * (1 - v) * gl_in[0].gl_Position + (1 - u) * v * gl_in[1].gl_Position + u * (1 - v) * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position;
    out_color = in_color[0];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(quads, equal_spacing, ccw) in;
layout(point_mode) in;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    gl_Position = (1 - u) * (1 - v) * gl_in[0].gl_Position + (1 - u) * v * gl_in[1].gl_Position + u * (1 - v) * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position;
    gl_PointSize = 1.0;
    out_color = in_color[0];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 4) out;
vec4 positions[4] = vec4[](
    vec4(-1.0f, -1.0f, 0.0f, 1.0f),
    vec4( 1.0f, -1.0f, 0.0f, 1.0f),
    vec4(-1.0f,  1.0f, 0.0f, 1.0f),
    vec4( 1.0f,  1.0f, 0.0f, 1.0f)
);
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if( gl_InvocationID == 0 )
    {
        gl_TessLevelInner[0] = 4.0f;
        gl_TessLevelInner[1] = 4.0f;
        gl_TessLevelOuter[0] = 4.0f;
        gl_TessLevelOuter[1] = 4.0f;
        gl_TessLevelOuter[2] = 4.0f;
        gl_TessLevelOuter[3] = 4.0f;
    }

    if (gl_InvocationID < 1)
    {
        out_color[gl_InvocationID] = in_color[gl_InvocationID];
        gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    }
    else
    {
        out_color[gl_InvocationID] = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue
        gl_out[gl_InvocationID].gl_Position = positions[gl_InvocationID];
    }
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 4) out;
vec4 positions[4] = vec4[](
    vec4(-1.0f, -1.0f, 0.0f, 1.0f),
    vec4( 1.0f, -1.0f, 0.0f, 1.0f),
    vec4(-1.0f,  1.0f, 0.0f, 1.0f),
    vec4( 1.0f,  1.0f, 0.0f, 1.0f)
);
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if( gl_InvocationID == 0 )
    {
        gl_TessLevelInner[0] = 4.0f;
        gl_TessLevelInner[1] = 4.0f;
        gl_TessLevelOuter[0] = 4.0f;
        gl_TessLevelOuter[1] = 4.0f;
        gl_TessLevelOuter[2] = 4.0f;
        gl_TessLevelOuter[3] = 4.0f;
    }

    if (gl_InvocationID < 2)
    {
        out_color[gl_InvocationID] = in_color[gl_InvocationID];
        gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    }
    else
    {
        out_color[gl_InvocationID] = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue
        gl_out[gl_InvocationID].gl_Position = positions[gl_InvocationID];
    }
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 4) out;
vec4 positions[4] = vec4[](
    vec4(-1.0f, -1.0f, 0.0f, 1.0f),
    vec4( 1.0f, -1.0f, 0.0f, 1.0f),
    vec4(-1.0f,  1.0f, 0.0f, 1.0f),
    vec4( 1.0f,  1.0f, 0.0f, 1.0f)
);
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if( gl_InvocationID == 0 )
    {
        gl_TessLevelInner[0] = 4.0f;
        gl_TessLevelInner[1] = 4.0f;
        gl_TessLevelOuter[0] = 4.0f;
        gl_TessLevelOuter[1] = 4.0f;
        gl_TessLevelOuter[2] = 4.0f;
        gl_TessLevelOuter[3] = 4.0f;
    }

    if (gl_InvocationID < 3)
    {
        out_color[gl_InvocationID] = in_color[gl_InvocationID];
        gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    }
    else
    {
        out_color[gl_InvocationID] = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue
        gl_out[gl_InvocationID].gl_Position = positions[gl_InvocationID];
    }
}
#version 450
layout(location = 0) in highp vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(push_constant, std430) uniform PCBlock { float verticalOffset; } pc;
void main (void)
{
    gl_PointSize = 1.0;
    const float yOffset = pc.verticalOffset;
    gl_Position = vec4(in_position.x, in_position.y + yOffset, in_position.z, in_position.w);
    out_color = in_color;
}
#version 450
layout(lines_adjacency) in;
layout(line_strip, max_vertices = 16) out;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    out_color = in_color[0];
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(lines) in;
layout(line_strip, max_vertices = 16) out;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    out_color = in_color[0];
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 16) out;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    out_color = in_color[0];
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 16) out;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    out_color = in_color[0];
    gl_PointSize = gl_in[0].gl_PointSize;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_PointSize = gl_in[0].gl_PointSize;
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_PointSize = gl_in[0].gl_PointSize;
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_PointSize = gl_in[0].gl_PointSize;
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_PointSize = gl_in[0].gl_PointSize;
    gl_Position = vec4(1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_PointSize = gl_in[0].gl_PointSize;
    gl_Position = vec4(-1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_PointSize = gl_in[0].gl_PointSize;
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(triangles_adjacency) in;
layout(triangle_strip, max_vertices = 16) out;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    out_color = in_color[0];
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 16) out;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    out_color = in_color[0];
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();


    out_color = in_color[0];
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    out_color = in_color[0];
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();
    out_color = in_color[0];
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(gl_in[2].gl_Position.x, gl_in[1].gl_Position.y, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) in highp vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main (void)
{
    gl_PointSize = 1.0;
    const float yOffset = 0.0;
    gl_Position = vec4(in_position.x, in_position.y + yOffset, in_position.z, in_position.w);
    out_color = in_color;
}
#version 450
layout(location = 0) in highp vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main (void)
{
    gl_PointSize = 1.0;
    gl_Position = in_position;
    out_color = in_color;
}
#version 460
layout (location=0) in vec4 inPos;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void) {
    gl_Position = inPos;
}
#version 450
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main() {
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
