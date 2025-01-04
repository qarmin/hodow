#version 440
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vec4(fract(gl_FragCoord.xy), 0.0, 1.0);
}
