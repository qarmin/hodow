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
