#version 450
${extensions}layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

${spec_block}${ssbo_block}${global_block}
void main (void)
{
${main_code}
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
