#version 450
layout(push_constant) uniform Constants { uvec2 params; } pc;
layout(std430, set = 0, binding = 0) buffer Data { uint elems[]; } data;
layout(location = 0) flat in uint offset;
void main() {
    data.elems[pc.params.x] = pc.params.y;
}
