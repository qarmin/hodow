#version 450
layout(location=0) in vec2 inPosition;
void main (void)
{
     gl_Position = vec4(inPosition, 0, 1);
}
#version 450
layout(location=0) in vec2 inPosition;
void main (void)
{
    gl_PointSize = 1.0;
     gl_Position = vec4(inPosition, 0, 1);
}
#version 450
layout(location=0) in vec2 inPosition;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
void main (void)
{
     gl_Position = vec4(inPosition, 0, 1);
    out0 = vec4(42);
}
#version 450
layout(location=0) in vec2 inPosition;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
void main (void)
{
    gl_PointSize = 1.0;
     gl_Position = vec4(inPosition, 0, 1);
    out0 = vec4(42);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
void main (void)
{
    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;
    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;
    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;
    gl_Position = p0 + p1 + p2;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(xfb_buffer = 0, xfb_offset = 0, location = 0) out vec4 out0;
void main (void)
{
    out0 = vec4(42);
    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;
    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;
    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;
    gl_Position = p0 + p1 + p2;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
void main (void)
{
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 2) out;
void main (void)
{
    gl_PointSize = 1.0;
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 0) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(points) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 0) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(lines) in;
layout(line_strip, max_vertices = 2) out;
void main (void)
{
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(lines) in;
layout(points, max_vertices = 2) out;
void main (void)
{
    gl_PointSize = 1.0;
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(lines) in;
layout(line_strip, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 0) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(lines) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(lines) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 0) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
#version 450
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;
void main (void)
{
    EmitVertex();
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(points, max_vertices = 2) out;
void main (void)
{
    gl_PointSize = 1.0;
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 0) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    EmitVertex();
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(triangles) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 0) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
#version 450
layout(triangles) in;
layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(lines_adjacency) in;
layout(line_strip, max_vertices = 2) out;
void main (void)
{
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(lines_adjacency) in;
layout(points, max_vertices = 2) out;
void main (void)
{
    gl_PointSize = 1.0;
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(lines_adjacency) in;
layout(line_strip, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 0) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(lines_adjacency) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(lines_adjacency) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 0) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
#version 450
layout(lines_adjacency) in;
layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(triangles_adjacency) in;
layout(triangle_strip, max_vertices = 3) out;
void main (void)
{
    EmitVertex();
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(triangles_adjacency) in;
layout(points, max_vertices = 2) out;
void main (void)
{
    gl_PointSize = 1.0;
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(triangles_adjacency) in;
layout(triangle_strip, max_vertices = 3) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 0) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    EmitVertex();
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(triangles_adjacency) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(triangles_adjacency) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 0) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
#version 450
layout(triangles_adjacency) in;
layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(location = 0) out vec4 out0;
void main (void)
{
    out0 = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 450
void main (void) {}
