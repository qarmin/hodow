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
#version 450
layout(location = 0) in vec3 inColor;
layout(location = 0) out vec4 outColor;
void main() {
    outColor = vec4(inColor, 1.0);
}
#version 450
void main() {
    const vec3 positions[3] = vec3[3](
        vec3(-0.75,  0.5,  0.5), vec3(-0.50, -0.5,  0.5), vec3(-0.25,  0.5,  0.5)
    );
    gl_Position = vec4(positions[gl_VertexIndex], 1.0);
}
#version 450
layout(location = 0) out vec4 outColor;
layout(set = 0, binding = 0) uniform sampler2D texRtvB;
layout(set = 0, binding = 1) uniform sampler2D texRtvA;
void main() {
    vec4 colorB = texelFetch(texRtvB, ivec2(gl_FragCoord.xy), 0);
    vec4 colorA = texelFetch(texRtvA, ivec2(gl_FragCoord.xy), 0);
    float dist = distance(colorA.rgb, colorB.rgb);
    vec3 clearColor = vec3(0.02, 0.02, 0.05);
    if (distance(colorA.rgb, clearColor) < 0.02 && distance(colorB.rgb, clearColor) < 0.02) {
        discard;
    }
    if (dist > 0.10) {
        outColor = vec4(1.0, 0.0, 0.0, 1.0); // Red Fail
    } else {
        outColor = vec4(0.0, 1.0, 0.0, 1.0); // Green Pass
    }
}
