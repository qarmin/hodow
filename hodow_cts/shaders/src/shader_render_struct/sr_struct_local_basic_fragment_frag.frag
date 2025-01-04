#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S s = S(v_coords.x, vec3(0.0), ui_one);
    s.b = v_coords.yzw;
    o_color = vec4(s.a, s.b.x, s.b.y, s.c);
    
}
