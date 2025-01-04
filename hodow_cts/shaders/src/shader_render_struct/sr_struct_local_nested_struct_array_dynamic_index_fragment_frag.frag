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

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};

void main (void)
{
    S s[2];

    // S[0]
    s[0].a         = v_coords.x;
    s[0].b[0].a    = uf_half;
    s[0].b[0].b[0] = v_coords.xy;
    s[0].b[0].b[1] = v_coords.zw;
    s[0].b[1].a    = uf_third;
    s[0].b[1].b[0] = v_coords.zw;
    s[0].b[1].b[1] = v_coords.xy;
    s[0].b[2].a    = uf_fourth;
    s[0].b[2].b[0] = v_coords.xz;
    s[0].b[2].b[1] = v_coords.yw;
    s[0].c         = ui_zero;

    // S[1]
    s[1].a         = v_coords.w;
    s[1].b[0].a    = uf_two;
    s[1].b[0].b[0] = v_coords.xx;
    s[1].b[0].b[1] = v_coords.yy;
    s[1].b[1].a    = uf_three;
    s[1].b[1].b[0] = v_coords.zz;
    s[1].b[1].b[1] = v_coords.ww;
    s[1].b[2].a    = uf_four;
    s[1].b[2].b[0] = v_coords.yx;
    s[1].b[2].b[1] = v_coords.wz;
    s[1].c         = ui_one;

    mediump float r = (s[0].b[ui_one].b[ui_one-1].x + s[ui_one].b[ui_two].b[ui_zero+1].y) * s[0].b[0].a; // (z + z) * 0.5
    mediump float g = s[ui_two-1].b[ui_two-2].b[ui_zero].y * s[0].b[ui_two].a * s[ui_one].b[2].a; // x * 0.25 * 4
    mediump float b = (s[ui_zero].b[ui_one+1].b[1].y + s[0].b[ui_one*ui_one].b[0].y + s[ui_one].a) * s[0].b[ui_two-ui_one].a; // (w + w + w) * 0.333
    mediump float a = float(s[ui_zero].c) + s[ui_one-ui_zero].b[ui_two].a - s[ui_zero+ui_one].b[ui_two-ui_one].a; // 0 + 4.0 - 3.0
    o_color = vec4(r, g, b, a);
    
}
