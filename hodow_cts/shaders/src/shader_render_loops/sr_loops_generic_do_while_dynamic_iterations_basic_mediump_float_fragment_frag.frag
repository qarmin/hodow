#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
    mediump float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    mediump float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump float one = v_one;
    mediump vec4 res = coords;
	mediump float ndx = 0.05;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third*one;
    } while (ndx < uf_one*one);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
