#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};
layout (std140, set = 0, binding = 3) uniform buffer3 { S s[3]; };

void main (void)
{
    o_color = vec4(s[2].a, s[1].a, s[0].a, s[2].b - s[1].b + s[0].b);
    
}
