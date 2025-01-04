#version 450
layout(location = 0) out int layerIndex;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1)) * 4.0f - 1.0f;
    gl_Position = vec4(pos, 0.0f, 1.0f);
    layerIndex = gl_InstanceIndex;
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f);
}
#version 450

layout(location = 0) in int layerIndex[];
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

void main() {
    for (int i = 0; i < 3; i++) {
        gl_Position = gl_in[i].gl_Position;
        gl_Layer = layerIndex[i];
        EmitVertex();
    }
    EndPrimitive();
}
