#version 450

layout(location = 0) in vec4 in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
${'gl_Position.z = 0.4;\n' if vtx_depth else ''}}
