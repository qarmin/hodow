#version 450

layout(location = 0) in vec4 in_position;

out gl_PerVertex {
    vec4  gl_Position;
};

void main(void)
{
    gl_Position = in_position;
}
#version 450

layout(location = 0) out vec4 out_color;

void main(void)
{
    if (gl_FrontFacing)
        out_color = vec4(1.0);
    else
        out_color = vec4(vec3(0.5), 1.0);
}
#version 460
const int vertexCount = 4;
vec2 positions[vertexCount] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  1.0),
    vec2( 1.0, -1.0),
    vec2( 1.0,  1.0)
);
void main (void) { gl_Position = vec4(positions[gl_VertexIndex % vertexCount], 0.0, 1.0); }
#version 460
layout (location=0) out vec4 outColor;
void main (void) { outColor = vec4(0.0, 0.0, 1.0, 1.0); }
