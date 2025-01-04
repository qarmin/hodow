#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S s = S(v_coords.x, v_coords.yzw, ui_zero);
    for (int i = 0; i < 3; i++)
    {
        if (i == 1)
            s = S(v_coords.w, v_coords.zyx, ui_one);
    }
    o_color = vec4(s.a, s.b.xy, s.c);
    
}
