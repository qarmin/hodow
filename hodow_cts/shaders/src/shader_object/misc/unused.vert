#version 450
#if ${stage} == 1 && ${builtin} == 0
layout(location = 0) out vec4 unused;
#endif
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
#if ${stage} == 1
#if ${builtin} == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
