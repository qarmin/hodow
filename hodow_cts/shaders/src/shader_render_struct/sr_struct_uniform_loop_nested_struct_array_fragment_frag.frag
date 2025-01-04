#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { mediump float uf_two; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_three; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_four; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_half; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_third; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_fourth; };
layout (std140, set = 0, binding = 9) uniform buffer9 { mediump float uf_sixth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};
layout (std140, set = 0, binding = 10) uniform buffer10 { S s[2]; };

void main (void)
{
    mediump float r = 0.0; // (x*3 + y*3) / 6.0
    mediump float g = 0.0; // (y*3 + z*3) / 6.0
    mediump float b = 0.0; // (z*3 + w*3) / 6.0
    mediump float a = 1.0;
    for (int i = 0; i < 2; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            r += s[0].b[j].b[i].y;
            g += s[i].b[j].b[0].x;
            b += s[i].b[j].b[1].x;
            a *= s[i].b[j].a;
        }
    }
    o_color = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);
    
}
