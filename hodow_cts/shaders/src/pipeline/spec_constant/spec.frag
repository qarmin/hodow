#version 450
${extensions}layout(location = 0) out highp vec4 fragColor;

${spec_block}${ssbo_block}${global_block}
void main (void)
{
${main_code}
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
