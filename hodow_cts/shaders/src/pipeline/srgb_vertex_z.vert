#version 460
layout (location=0) in vec4 inCoords;
// These XY coords below are normalized to 0..1 and will be transformed to -1..1 later
// Value 10.0 in this array will be replaced with something that's expected to alternate
// between 0 and 0.5 in the vertex buffer to form a quad that covers the top half
vec4 vertices[4] = vec4[](
    vec4(0.0, 10.0, 0.0, 1.0),
    vec4(0.0, 10.0, 0.0, 1.0),
    vec4(1.0, 10.0, 0.0, 1.0),
    vec4(1.0, 10.0, 0.0, 1.0)
);
void main(void) {
    vec4 position = vertices[gl_VertexIndex % 4];
    position.y = inCoords.z;
    position = position * vec4(2.0, 2.0, 1.0, 1.0) - vec4(1.0, 1.0, 0.0, 0.0); // XY from 0..1 to -1..1
    gl_Position = position;
}
