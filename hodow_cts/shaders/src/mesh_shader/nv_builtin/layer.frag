#version 460
#extension GL_NV_mesh_shader : enable

layout (location=0) out vec4 outColor;

vec4 colors[4] = vec4[](
    vec4(0.0, 0.0, 1.0, 1.0),
    vec4(1.0, 0.0, 1.0, 1.0),
    vec4(0.0, 1.0, 1.0, 1.0),
    vec4(1.0, 1.0, 0.0, 1.0)
);

void main ()
{
    outColor = colors[gl_Layer];
}
