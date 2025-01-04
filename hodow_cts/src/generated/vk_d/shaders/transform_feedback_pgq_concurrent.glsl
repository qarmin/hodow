#version 450
layout(location=0) in vec2 inPosition;
void main (void)
{
    gl_Position = vec4(inPosition, 0, 1);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
#version 450
layout(location = 0) out vec4 out0;
void main (void)
{
    out0 = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(lines) in;
layout(points, max_vertices = 1) out;
void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
#version 450
layout(lines) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(triangles) in;
layout(points, max_vertices = 1) out;
void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
#version 450
layout(triangles) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(triangles) in;
layout(points, max_vertices = 1) out;
void main (void)
{
    gl_Position = abs(gl_in[0].gl_Position.y) < abs(gl_in[1].gl_Position.y) ? gl_in[0].gl_Position : gl_in[1].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
#version 450
layout(triangles) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    gl_Position = abs(gl_in[0].gl_Position.y) < abs(gl_in[1].gl_Position.y) ? gl_in[0].gl_Position : gl_in[1].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(lines_adjacency) in;
layout(points, max_vertices = 1) out;
void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
#version 450
layout(lines_adjacency) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(triangles_adjacency) in;
layout(points, max_vertices = 1) out;
void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
#version 450
layout(triangles_adjacency) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
#version 450
layout(triangles_adjacency) in;
layout(points, max_vertices = 1) out;
void main (void)
{
    const vec3 xCoords = vec3(gl_in[0].gl_Position.x, gl_in[2].gl_Position.x, gl_in[4].gl_Position.x);
    const vec3 yCoords = vec3(gl_in[0].gl_Position.y, gl_in[2].gl_Position.y, gl_in[4].gl_Position.y);
    const float maxX = max(max(xCoords.x, xCoords.y), xCoords.z);
    const float minX = min(min(xCoords.x, xCoords.y), xCoords.z);
    const float maxY = max(max(yCoords.x, yCoords.y), yCoords.z);
    const float minY = min(min(yCoords.x, yCoords.y), yCoords.z);
    gl_Position = vec4((maxX + minX) / 2.0, (maxY + minY) / 2.0, gl_in[0].gl_Position.z, gl_in[0].gl_Position.w);
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
#version 450
layout(triangles_adjacency) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    const vec3 xCoords = vec3(gl_in[0].gl_Position.x, gl_in[2].gl_Position.x, gl_in[4].gl_Position.x);
    const vec3 yCoords = vec3(gl_in[0].gl_Position.y, gl_in[2].gl_Position.y, gl_in[4].gl_Position.y);
    const float maxX = max(max(xCoords.x, xCoords.y), xCoords.z);
    const float minX = min(min(xCoords.x, xCoords.y), xCoords.z);
    const float maxY = max(max(yCoords.x, yCoords.y), yCoords.z);
    const float minY = min(min(yCoords.x, yCoords.y), yCoords.z);
    gl_Position = vec4((maxX + minX) / 2.0, (maxY + minY) / 2.0, gl_in[0].gl_Position.z, gl_in[0].gl_Position.w);
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
