#version 450
${extensions}layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

${spec_block}${ssbo_block}${global_block}
void main (void)
{
${main_code}
    gl_Position = position;
}
