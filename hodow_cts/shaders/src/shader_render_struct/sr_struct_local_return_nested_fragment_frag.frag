#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

S myFunc (void)
{
    S s = S(v_coords.x, T(0, vec2(0.0)), ui_one);
    s.b = T(ui_zero, v_coords.yz);
    return s;
}

void main (void)
{
    S s = myFunc();
    o_color = vec4(s.a, s.b.b, s.b.a + s.c);
    
}
