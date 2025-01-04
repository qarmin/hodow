#version 450
layout (local_size_x = 1) in;
layout(binding = 0) writeonly buffer Output {
    uint v[];
};
void main (void) {
    v[gl_WorkGroupID.x] = gl_WorkGroupID.x;
}
#version 450
layout (local_size_x = 1) in;
layout(binding = 0) buffer Output {
    uint v[];
};
void main (void) {
    v[gl_WorkGroupID.y] += 3;
}
#version 450
layout(location = 0) in vec2 position;
void main()
{
    gl_Position = vec4(position, 0.0, 1.0);
}
#version 450
layout(location = 0) out vec4 out_color;
void main()
{
    out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
