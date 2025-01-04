#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 1.0);
}
