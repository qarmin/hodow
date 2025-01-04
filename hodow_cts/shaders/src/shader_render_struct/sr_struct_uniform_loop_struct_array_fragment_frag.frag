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
    mediump float rgb[3];
    int alpha = 0;
    for (int i = 0; i < 3; i++)
    {
        rgb[i] = s[2-i].a;
        alpha += s[i].b;
    }
    o_color = vec4(rgb[0], rgb[1], rgb[2], alpha);
    
}
