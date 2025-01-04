#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
