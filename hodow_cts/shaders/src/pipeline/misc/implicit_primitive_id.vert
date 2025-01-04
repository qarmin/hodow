#version 450

void main ()
{
    switch (gl_VertexIndex) {
        case 0:
            gl_Position = vec4(-3.0, -1.0, 0.0, 1.0);
            break;
        case 1:
            gl_Position = vec4(0.0, 3.0, 0.0, 1.0);
            break;
        case 2:
            gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
            break;
        case 3:
            gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
            break;
        case 4:
            gl_Position = vec4(3.0, -1.0, 0.0, 1.0);
            break;
        case 5:
            gl_Position = vec4(0.0, 3.0, 0.0, 1.0);
            break;
    }
}
