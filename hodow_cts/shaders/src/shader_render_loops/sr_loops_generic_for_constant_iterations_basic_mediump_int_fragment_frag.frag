#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int ndx = 0; ndx < 3; ndx++)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
