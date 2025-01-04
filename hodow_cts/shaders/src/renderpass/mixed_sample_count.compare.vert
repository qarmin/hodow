#version 450
void main() {
    const vec3 positions[3] = vec3[3](
        vec3(-0.75,  0.5,  0.5), vec3(-0.50, -0.5,  0.5), vec3(-0.25,  0.5,  0.5)
    );
    gl_Position = vec4(positions[gl_VertexIndex], 1.0);
}
