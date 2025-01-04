#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_one;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
	highp float ndx = 0.05;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx += 0.333333;
    } while (ndx < 1.0);
    res -= vec4(3);
    v_color = res.rgb;
}
