#version 450
layout(location = 0) flat out uint offset;
out gl_PerVertex { vec4 gl_Position; float gl_PointSize; };
void main() {
    offset = gl_VertexIndex;
    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
    gl_PointSize = 1.0f;
}
#version 450
layout(push_constant) uniform Constants { uvec2 params; } pc;
layout(std430, set = 0, binding = 0) buffer Data { uint elems[]; } data;
layout(location = 0) flat in uint offset;
void main() {
    data.elems[pc.params.x] = pc.params.y;
}
#version 450
layout(local_size_x = 1u, local_size_y = 1u, local_size_z = 1u) in;
layout(push_constant) uniform Constants { uvec2 params; } pc;
layout(std430, set = 0, binding = 0) buffer Data { uint elems[]; } data;
void main() {
    data.elems[pc.params.x] = pc.params.y;
}
