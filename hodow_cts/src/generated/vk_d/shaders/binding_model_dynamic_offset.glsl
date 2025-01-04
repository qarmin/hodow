#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform InputBlock { vec4 color; } ib;
layout (set=0, binding=1) buffer OutputBlock { vec4 color; } ob;
void main(void) {
    vec4 color = ib.color;
    ob.color = color;
}
#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform InputBlock { vec4 color; } ib;
layout (set=0, binding=1) buffer OutputBlock { vec4 color; } ob;
layout (push_constant) uniform PCBlock { vec4 color[8]; } pc;
void main(void) {
    vec4 color = ib.color;
    color = pc.color[0];
    color = color + pc.color[1];
    color = color + pc.color[2];
    color = color + pc.color[3];
    color = color + pc.color[4];
    color = color + pc.color[5];
    color = color + pc.color[6];
    color = color + pc.color[7];
    ob.color = color;
}
#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform InputBlock { vec4 color; } ib;
layout (set=1, binding=0) buffer OutputBlock { vec4 color; } ob;
layout (push_constant) uniform PCBlock { vec4 color[8]; } pc;
void main(void) {
    vec4 color = ib.color;
    color = pc.color[0];
    color = color + pc.color[1];
    color = color + pc.color[2];
    color = color + pc.color[3];
    color = color + pc.color[4];
    color = color + pc.color[5];
    color = color + pc.color[6];
    color = color + pc.color[7];
    ob.color = color;
}
#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform InputBlock { vec4 color; } ib;
layout (set=0, binding=1) buffer OutputBlock { vec4 color; } ob;
layout (push_constant) uniform PCBlock { vec4 color[8]; } pc;
void main(void) {
    vec4 color = ib.color;
    ob.color = color;
}
