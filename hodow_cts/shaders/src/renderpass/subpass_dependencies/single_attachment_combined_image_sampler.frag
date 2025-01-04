#version 450
layout(set = 0, binding = 0) uniform highp sampler2D tex;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    vec2 uv = vec2(gl_FragCoord) / 255.0;
    vec4 inputColor = texture(tex, uv);
    fragColor = inputColor + vec4(0.1, 0.2, 0.0, 0.0);
}
