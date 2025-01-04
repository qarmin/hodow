#version 460
const vec2 positions[4] = vec2[](
    vec2(-1.0 + 0.015625, -1.0 + 0.015625),
    vec2(-1.0 + 0.015625,  1.0 - 0.015625),
    vec2( 1.0 - 0.015625, -1.0 + 0.015625),
    vec2( 1.0 - 0.015625,  1.0 - 0.015625)
);
void main() {
    gl_Position  = vec4(positions[gl_VertexIndex % 4], 0.0, 1.0);
    gl_PointSize = 1.0;
}
#version 460
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
const vec2 positions[4] = vec2[](
    vec2(-1.0 + 0.015625, -1.0 + 0.015625),
    vec2(-1.0 + 0.015625,  1.0 - 0.015625),
    vec2( 1.0 - 0.015625, -1.0 + 0.015625),
    vec2( 1.0 - 0.015625,  1.0 - 0.015625)
);
layout (vertices=3) out;
void main() {
    if (gl_InvocationID >= gl_PatchVerticesIn) {
        gl_out[gl_InvocationID].gl_Position  = vec4(positions[3], 0.0, 1.0);
        gl_out[gl_InvocationID].gl_PointSize = 1.0;
    }
    else {
        gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position;
        gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
    }
    if (gl_InvocationID == 0) {
        gl_TessLevelOuter[0] = 3.25;
        gl_TessLevelOuter[1] = 5.25;
        gl_TessLevelOuter[2] = 7.25;
        gl_TessLevelOuter[3] = 9.25;
        gl_TessLevelInner[0] = 3.25;
        gl_TessLevelInner[1] = 5.25;
    }
}
#version 460
const vec2 positions[4] = vec2[](
    vec2(-1.0 + 0.015625, -1.0 + 0.015625),
    vec2(-1.0 + 0.015625,  1.0 - 0.015625),
    vec2( 1.0 - 0.015625, -1.0 + 0.015625),
    vec2( 1.0 - 0.015625,  1.0 - 0.015625)
);
layout (vertices=4) out;
void main() {
    if (gl_InvocationID >= gl_PatchVerticesIn) {
        gl_out[gl_InvocationID].gl_Position  = vec4(positions[3], 0.0, 1.0);
        gl_out[gl_InvocationID].gl_PointSize = 1.0;
    }
    else {
        gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position;
        gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
    }
    if (gl_InvocationID == 0) {
        gl_TessLevelOuter[0] = 3.25;
        gl_TessLevelOuter[1] = 5.25;
        gl_TessLevelOuter[2] = 7.25;
        gl_TessLevelOuter[3] = 9.25;
        gl_TessLevelInner[0] = 3.25;
        gl_TessLevelInner[1] = 5.25;
    }
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, equal_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    gl_Position = (u * gl_in[0].gl_Position) + (v * gl_in[1].gl_Position) + (w * gl_in[2].gl_Position);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, equal_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    const vec4 p1 = gl_in[0].gl_Position;
    const vec4 p2 = gl_in[1].gl_Position;
    const vec4 p3 = gl_in[2].gl_Position * 0.5 + gl_in[3].gl_Position * 0.5;
    gl_Position = (u * p1) + (v * p2) + (w * p3);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, fractional_odd_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    gl_Position = (u * gl_in[0].gl_Position) + (v * gl_in[1].gl_Position) + (w * gl_in[2].gl_Position);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, fractional_odd_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    const vec4 p1 = gl_in[0].gl_Position;
    const vec4 p2 = gl_in[1].gl_Position;
    const vec4 p3 = gl_in[2].gl_Position * 0.5 + gl_in[3].gl_Position * 0.5;
    gl_Position = (u * p1) + (v * p2) + (w * p3);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, fractional_even_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    gl_Position = (u * gl_in[0].gl_Position) + (v * gl_in[1].gl_Position) + (w * gl_in[2].gl_Position);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, fractional_even_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    const vec4 p1 = gl_in[0].gl_Position;
    const vec4 p2 = gl_in[1].gl_Position;
    const vec4 p3 = gl_in[2].gl_Position * 0.5 + gl_in[3].gl_Position * 0.5;
    gl_Position = (u * p1) + (v * p2) + (w * p3);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(isolines, equal_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(isolines, equal_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(isolines, fractional_odd_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(isolines, fractional_odd_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(isolines, fractional_even_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(isolines, fractional_even_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, equal_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, equal_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, fractional_odd_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, fractional_odd_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, fractional_even_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, fractional_even_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, equal_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    const vec4 p1 = gl_in[0].gl_Position;
    const vec4 p2 = gl_in[1].gl_Position;
    const vec4 p3 = gl_in[2].gl_Position * 0.5 + gl_in[3].gl_Position * 0.5;
    gl_Position = (u * p1) + (v * p2) + (w * p3);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, equal_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    gl_Position = (u * gl_in[0].gl_Position) + (v * gl_in[1].gl_Position) + (w * gl_in[2].gl_Position);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, fractional_odd_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    gl_Position = (u * gl_in[0].gl_Position) + (v * gl_in[1].gl_Position) + (w * gl_in[2].gl_Position);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, fractional_odd_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    const vec4 p1 = gl_in[0].gl_Position;
    const vec4 p2 = gl_in[1].gl_Position;
    const vec4 p3 = gl_in[2].gl_Position * 0.5 + gl_in[3].gl_Position * 0.5;
    gl_Position = (u * p1) + (v * p2) + (w * p3);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, fractional_even_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    gl_Position = (u * gl_in[0].gl_Position) + (v * gl_in[1].gl_Position) + (w * gl_in[2].gl_Position);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, fractional_even_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    const vec4 p1 = gl_in[0].gl_Position;
    const vec4 p2 = gl_in[1].gl_Position;
    const vec4 p3 = gl_in[2].gl_Position * 0.5 + gl_in[3].gl_Position * 0.5;
    gl_Position = (u * p1) + (v * p2) + (w * p3);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(isolines, equal_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(isolines, equal_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(isolines, fractional_odd_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(isolines, fractional_odd_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(isolines, fractional_even_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(isolines, fractional_even_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, equal_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, equal_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, fractional_odd_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, fractional_odd_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, fractional_even_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, fractional_even_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[3].gl_Position.y - gl_in[2].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (push_constant) uniform PCBlock { vec4 offset; } pc;
void main (void) {
    gl_Position = inPos + pc.offset;
    gl_PointSize = 1.0;
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = inColor;
}
#version 460
layout (vertices=4) out;
void main (void) {
    const bool goodPVI = (gl_PatchVerticesIn == 4);
    const float posOffset = (goodPVI ? 0.0 : 10.0);

    gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position + posOffset;
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;

    const float extraLevels = 0.0;
    if (gl_InvocationID == 0) {
        gl_TessLevelOuter[0] = 3.0 + extraLevels;
        gl_TessLevelOuter[1] = 5.0 + extraLevels;
        gl_TessLevelOuter[2] = 7.0 + extraLevels;
        gl_TessLevelOuter[3] = 9.0 + extraLevels;
        gl_TessLevelInner[0] = 3.0 + extraLevels;
        gl_TessLevelInner[1] = 5.0 + extraLevels;
    }
}
#version 460
layout (quads, point_mode) in;
layout (location=0) out vec4 vertColor;
void main (void) {
    const bool goodPVI = (gl_PatchVerticesIn == 4);
    const float posOffset = (goodPVI ? 0.0 : 10.0);

    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const vec4 p0 = gl_in[0].gl_Position;
    const vec4 p1 = gl_in[1].gl_Position;
    const vec4 p2 = gl_in[2].gl_Position;
    const vec4 p3 = gl_in[3].gl_Position;
    gl_Position = ((1 - u) * (1 - v) * p0 + (1 - u) * v * p1 + u * (1 - v) * p2 + u * v * p3) + posOffset;
    gl_PointSize = 1.0;
    vertColor = vec4(0.0, 1.0, 1.0, 1.0);
}
#version 460
layout (vertices=4) out;
void main (void) {
    const bool goodPVI = (gl_PatchVerticesIn == 4);
    const float posOffset = (goodPVI ? 0.0 : 10.0);

    gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position + posOffset;
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;

    const float extraLevels = 1.0;
    if (gl_InvocationID == 0) {
        gl_TessLevelOuter[0] = 3.0 + extraLevels;
        gl_TessLevelOuter[1] = 5.0 + extraLevels;
        gl_TessLevelOuter[2] = 7.0 + extraLevels;
        gl_TessLevelOuter[3] = 9.0 + extraLevels;
        gl_TessLevelInner[0] = 3.0 + extraLevels;
        gl_TessLevelInner[1] = 5.0 + extraLevels;
    }
}
#version 460
layout (quads, point_mode) in;
layout (location=0) out vec4 vertColor;
void main (void) {
    const bool goodPVI = (gl_PatchVerticesIn == 4);
    const float posOffset = (goodPVI ? 0.0 : 10.0);

    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const vec4 p0 = gl_in[0].gl_Position;
    const vec4 p1 = gl_in[1].gl_Position;
    const vec4 p2 = gl_in[2].gl_Position;
    const vec4 p3 = gl_in[3].gl_Position;
    gl_Position = ((1 - u) * (1 - v) * p0 + (1 - u) * v * p1 + u * (1 - v) * p2 + u * v * p3) + posOffset;
    gl_PointSize = 1.0;
    vertColor = vec4(1.0, 0.0, 1.0, 1.0);
}
#version 460
layout (vertices=4) out;
void main (void) {
    const bool goodPVI = (gl_PatchVerticesIn == 4);
    const float posOffset = (goodPVI ? 0.0 : 10.0);

    gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position + posOffset;
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;

    const float extraLevels = 2.0;
    if (gl_InvocationID == 0) {
        gl_TessLevelOuter[0] = 3.0 + extraLevels;
        gl_TessLevelOuter[1] = 5.0 + extraLevels;
        gl_TessLevelOuter[2] = 7.0 + extraLevels;
        gl_TessLevelOuter[3] = 9.0 + extraLevels;
        gl_TessLevelInner[0] = 3.0 + extraLevels;
        gl_TessLevelInner[1] = 5.0 + extraLevels;
    }
}
#version 460
layout (quads, point_mode) in;
layout (location=0) out vec4 vertColor;
void main (void) {
    const bool goodPVI = (gl_PatchVerticesIn == 4);
    const float posOffset = (goodPVI ? 0.0 : 10.0);

    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const vec4 p0 = gl_in[0].gl_Position;
    const vec4 p1 = gl_in[1].gl_Position;
    const vec4 p2 = gl_in[2].gl_Position;
    const vec4 p3 = gl_in[3].gl_Position;
    gl_Position = ((1 - u) * (1 - v) * p0 + (1 - u) * v * p1 + u * (1 - v) * p2 + u * v * p3) + posOffset;
    gl_PointSize = 1.0;
    vertColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 460
layout (vertices=4) out;
void main (void) {
    const bool goodPVI = (gl_PatchVerticesIn == 4);
    const float posOffset = (goodPVI ? 0.0 : 10.0);

    gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position + posOffset;
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;

    const float extraLevels = 3.0;
    if (gl_InvocationID == 0) {
        gl_TessLevelOuter[0] = 3.0 + extraLevels;
        gl_TessLevelOuter[1] = 5.0 + extraLevels;
        gl_TessLevelOuter[2] = 7.0 + extraLevels;
        gl_TessLevelOuter[3] = 9.0 + extraLevels;
        gl_TessLevelInner[0] = 3.0 + extraLevels;
        gl_TessLevelInner[1] = 5.0 + extraLevels;
    }
}
#version 460
layout (quads, point_mode) in;
layout (location=0) out vec4 vertColor;
void main (void) {
    const bool goodPVI = (gl_PatchVerticesIn == 4);
    const float posOffset = (goodPVI ? 0.0 : 10.0);

    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const vec4 p0 = gl_in[0].gl_Position;
    const vec4 p1 = gl_in[1].gl_Position;
    const vec4 p2 = gl_in[2].gl_Position;
    const vec4 p3 = gl_in[3].gl_Position;
    gl_Position = ((1 - u) * (1 - v) * p0 + (1 - u) * v * p1 + u * (1 - v) * p2 + u * v * p3) + posOffset;
    gl_PointSize = 1.0;
    vertColor = vec4(1.0, 1.0, 1.0, 1.0);
}
