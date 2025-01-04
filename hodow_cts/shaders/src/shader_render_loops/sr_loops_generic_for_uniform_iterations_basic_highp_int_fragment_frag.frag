#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
 highp int ui_three;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (highp int ndx = 0; ndx < ui_three; ndx++)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
