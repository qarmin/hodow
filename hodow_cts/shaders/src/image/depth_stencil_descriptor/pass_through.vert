#version 450

layout(push_constant, std430) uniform PushConstantBlock {
    float colorR;
    float colorG;
    float colorB;
    float colorA;
    float depth;
} pc;

vec2 vertexPositions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  3.0),
    vec2( 3.0, -1.0));

void main () {
    gl_Position = vec4(vertexPositions[gl_VertexIndex], pc.depth, 1.0);
}
