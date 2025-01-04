#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
    mediump float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    mediump float uf_one;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump float one = a_one;
    mediump vec4 res = coords;
	mediump float ndx = 0.05;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third*one;
    } while (ndx < uf_one*one);
    res -= vec4(3);
    v_color = res.rgb;
}
