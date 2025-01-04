#version 450

layout (location = 0) in vec3 position;
layout (location = 1) in mat4 projMatrix;

layout (location = 2, xfb_buffer = 0) out float xfbVal;
layout (location = 3) out vec2 texCoord;

void main()
{
    double dval = double(position.x);
    gl_Position = vec4(position, 1.0) * projMatrix;
    gl_ClipDistance[0] = 0.0;
    gl_CullDistance[0] = 0.0;

    xfbVal = 1.0;
    texCoord = vec2(0, 0);
}
