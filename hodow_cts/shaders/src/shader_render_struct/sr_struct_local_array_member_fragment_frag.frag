#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump float    b[3];
    int                c;
};

void main (void)
{
    S s;
    s.a = v_coords.w;
    s.c = ui_one;
    s.b[0] = v_coords.z;
    s.b[1] = v_coords.y;
    s.b[2] = v_coords.x;
    o_color = vec4(s.a, s.b[0], s.b[1], s.c);
    
}
