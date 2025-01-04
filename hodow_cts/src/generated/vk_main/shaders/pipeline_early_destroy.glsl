#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, rgba8) writeonly uniform image2D u_image;
void main()
{
    imageStore(u_image, ivec2(gl_GlobalInvocationID.xy), vec4(0, 1, 0, 1));
}
#version 450
vec2 vertices[3];

void main()
{
   vertices[0] = vec2(-1.0, -1.0);
   vertices[1] = vec2( 1.0, -1.0);
   vertices[2] = vec2( 0.0,  1.0);
   gl_Position = vec4(vertices[gl_VertexIndex % 3], 0.0, 1.0);
}
#version 450

layout(location = 0) out vec4 uFragColor;

void main()
{
   uFragColor = vec4(0,1,0,1);
}
