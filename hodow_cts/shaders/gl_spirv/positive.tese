#version 450

layout (triangles) in;

layout (location = 2) in vec4 tcColor[];
layout (location = 3) out vec4 teColor;

void main()
{
    teColor = tcColor[0];
    teColor.g = 1.0;

    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position +
                  gl_TessCoord.y * gl_in[1].gl_Position +
                  gl_TessCoord.z * gl_in[2].gl_Position;
}
