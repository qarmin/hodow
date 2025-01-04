#version 460
layout (location=0) out flat int zCoord;
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2( 3.0, -1.0),
    vec2(-1.0,  3.0)
);
void main() {
    gl_Position = vec4(positions[gl_VertexIndex % 3], 0.0, 1.0);
    zCoord = int(gl_InstanceIndex);
}
