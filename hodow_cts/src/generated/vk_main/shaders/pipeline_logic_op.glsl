#version 430
vec2 vdata[] = vec2[] (
vec2(-1.0, -1.0),
vec2(1.0, -1.0),
vec2(-1.0, 1.0),
vec2(1.0, 1.0));
void main (void)
{
    gl_Position = vec4(vdata[gl_VertexIndex], 0.0, 1.0);
}
#version 430
layout(push_constant) uniform quadColor {
    uvec4 val;
} QUAD_COLOR;
layout(location = 0) out uvec4 fragColor;
void main (void)
{
    fragColor = QUAD_COLOR.val;
}
#version 430
layout(push_constant) uniform quadColor {
    vec4 val;
} QUAD_COLOR;
layout(location = 0) out float fragColor;
void main (void)
{
    fragColor = float(QUAD_COLOR.val.r);
}
#version 430
layout(push_constant) uniform quadColor {
    vec4 val;
} QUAD_COLOR;
layout(location = 0) out vec2 fragColor;
void main (void)
{
    fragColor = vec2(QUAD_COLOR.val.rg);
}
#version 430
layout(push_constant) uniform quadColor {
    vec4 val;
} QUAD_COLOR;
layout(location = 0) out vec3 fragColor;
void main (void)
{
    fragColor = vec3(QUAD_COLOR.val.rgb);
}
#version 430
layout(push_constant) uniform quadColor {
    vec4 val;
} QUAD_COLOR;
layout(location = 0) out vec4 fragColor;
void main (void)
{
    fragColor = vec4(QUAD_COLOR.val);
}
