#version 430
layout(std430, binding = 0) buffer BufferPos {
vec4 p[100];
} pos;
out gl_PerVertex{
vec4 gl_Position;
};
void main() {
gl_Position = pos.p[gl_VertexIndex];
}
