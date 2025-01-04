#version 450 core
vec2 coords[4] = {ivec2(-1,-1), ivec2(-1, 1), ivec2(1, -1), ivec2(1, 1)};
void main() { gl_Position = vec4(coords[gl_VertexIndex], 0, 1); }
