#version 430

layout(location = 0) out vec4 out_color;

void main()
{
        gl_PointSize = 1;
        gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        out_color = vec4(0.0, 0.0, 0.0, 1.0);
}
