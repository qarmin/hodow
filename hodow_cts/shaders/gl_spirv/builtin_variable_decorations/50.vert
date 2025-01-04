#version 450

layout (location = 0) in vec3 position;

layout (location = 1) out vec4 vColor;

void main()
{
    gl_PointSize = 10.0f;
    gl_Position = vec4(position.x, position.y + 0.3 * gl_InstanceID, position.z, 1.0);
    gl_ClipDistance[0] = 1.0;
    gl_CullDistance[0] = 1.0;
    vColor = vec4(1.0, 1.0, 1.0, 1.0);
}
