#version 450
layout(location = 0) flat out uint offset;
out gl_PerVertex { vec4 gl_Position; float gl_PointSize; };
void main() {
    offset = gl_VertexIndex;
    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
    gl_PointSize = 1.0f;
}
