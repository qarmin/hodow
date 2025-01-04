#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
 mediump int ui_three;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
	mediump int ndx = 0;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    } while (ndx < ui_three);
    res -= vec4(3);
    v_color = res.rgb;
}
