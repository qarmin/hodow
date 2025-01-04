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
#version 430
layout(location = 0) out vec4 my_FragColor;
void main() {
my_FragColor = vec4(0,1,0,1);
}
