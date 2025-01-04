#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) readonly uniform Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
