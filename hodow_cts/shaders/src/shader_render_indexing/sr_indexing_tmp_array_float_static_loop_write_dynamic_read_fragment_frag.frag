#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
