#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
 mediump int ui_three;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump int one = int(v_one + 0.5);
    mediump vec4 res = coords;
	mediump int ndx = 0;
    while (ndx < ui_three*one)
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
