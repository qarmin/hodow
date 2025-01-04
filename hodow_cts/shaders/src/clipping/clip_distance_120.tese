#version 450

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[5];
};

void main (void)
{
    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;

    for (int i = 0; i < 5; ++i)
        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]
                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]
                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];
}
