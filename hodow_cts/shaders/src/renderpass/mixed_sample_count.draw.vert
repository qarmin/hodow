#version 450
layout(location = 0) out vec3 outColor;
const vec3 positions[6] = vec3[6](
    vec3(-0.75,  0.5,  0.5), vec3(-0.50, -0.5,  0.5), vec3(-0.25,  0.5,  0.5),
    vec3( 0.25,  0.5,  0.5), vec3( 0.50, -0.5,  0.5), vec3( 0.75,  0.5,  0.5)
);
const vec3 colors[6] = vec3[6](
    vec3(1.0, 0.0, 0.0), vec3(0.0, 0.0, 1.0), vec3(0.0, 1.0, 0.0),
    vec3(0.0, 1.0, 0.0), vec3(1.0, 0.0, 0.0), vec3(0.0, 0.0, 1.0)
);
void main() {
    outColor = colors[gl_VertexIndex];
    gl_Position = vec4(positions[gl_VertexIndex], 1.0);
}
