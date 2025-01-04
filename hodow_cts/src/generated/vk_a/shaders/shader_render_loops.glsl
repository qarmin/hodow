#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int ndx = 0; ndx < 3; ndx++)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec3 v_color;

void main()
{
    o_color = vec4(v_color.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec4 v_coords;

void main()
{
    gl_Position = a_position;
    v_coords = a_coords;
}
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
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
    mediump float uf_one;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump float ndx = 0.05; ndx < 1.0; ndx += 0.333333)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
    mediump float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump float ndx = 0.05; ndx < 1.0; ndx += 0.333333)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (highp int ndx = 0; ndx < 3; ndx++)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (highp int ndx = 0; ndx < 3; ndx++)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
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
    for (highp float ndx = 0.05; ndx < 1.0; ndx += 0.333333)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (highp float ndx = 0.05; ndx < 1.0; ndx += 0.333333)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) {}
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) {}
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (;;) { break; res = res.yzwx + vec4(1.0); }
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (;;) { break; res = res.yzwx + vec4(1.0); }
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (;;) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (;;) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    for (;;) { res = res.yzwx + vec4(1.0); if (i == 1) break; i++; }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    for (;;) { res = res.yzwx + vec4(1.0); if (i == 1) break; i++; }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 2; i++) { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 2; i++) { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 2; i++) res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 2; i++) res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 0; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 0; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 1; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 1; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (int i = 0; i < (ub_true ? 3 : 0); i++) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (int i = 0; i < (ub_true ? 3 : 0); i++) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { if (i == 2) continue; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { if (i == 2) continue; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { continue; }
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { continue; }
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { if (i == 2) continue; res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { if (i == 2) continue; res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { if (i == 2) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { if (i == 2) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (int i = 0; i < 3; ++i) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (int i = 0; i < 3; ++i) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 5; i++) { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 5; i++) { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump ivec4 i = ivec4(0, 1, 3, 0); i.x < i.z; i.x += i.y) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump ivec4 i = ivec4(0, 1, 3, 0); i.x < i.z; i.x += i.y) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 101; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(101);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 101; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(101);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i;
    for (i = 0; i < 2; i++) { res = res.yzwx + vec4(1.0); }
    for (; i < 5; i++) { res = res.yzwx + vec4(1.0); }
    res -= vec4(5);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i;
    for (i = 0; i < 2; i++) { res = res.yzwx + vec4(1.0); }
    for (; i < 5; i++) { res = res.yzwx + vec4(1.0); }
    res -= vec4(5);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 2; i++)
    {
        for (mediump int j = 0; j < 3; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 2; i++)
    {
        for (mediump int j = 0; j < 3; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++)
    {
        for (mediump int j = 0; j < 2; j++)
            res = res.yzwx + vec4(1.0);
        for (mediump int j = 0; j < 1; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(9);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++)
    {
        for (mediump int j = 0; j < 2; j++)
            res = res.yzwx + vec4(1.0);
        for (mediump int j = 0; j < 1; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(9);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++)
    {
        res = coords; // ignore outer loop effect 
        for (mediump int j = 0; j < 2; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++)
    {
        res = coords; // ignore outer loop effect 
        for (mediump int j = 0; j < 2; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++)
    {
        res = coords.wxyz - vec4(1.0);
        for (mediump int j = 0; j < 2; j++)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++)
    {
        res = coords.wxyz - vec4(1.0);
        for (mediump int j = 0; j < 2; j++)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        for (mediump int i = 0; i < 3; i++)
            res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        for (mediump int i = 0; i < 3; i++)
            res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        for (mediump int i = 0; i < 3; i++)
            res = res.yzwx + vec4(1.0);
    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        for (mediump int i = 0; i < 3; i++)
            res = res.yzwx + vec4(1.0);
    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++)
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i >= 3);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < 3; i++)
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i >= 3);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == 3)
    {
        for (mediump int i = 0; i < 3; i++)
            res = res.yzwx + vec4(1.0);
    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == 3)
    {
        for (mediump int i = 0; i < 3; i++)
            res = res.yzwx + vec4(1.0);
    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == 3)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        for (mediump int i = 0; i < 3; i++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == 3)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        for (mediump int i = 0; i < 3; i++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
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
    for (mediump int ndx = 0; ndx < ui_three; ndx++)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
 mediump int ui_three;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int ndx = 0; ndx < ui_three; ndx++)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
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
    mediump vec4 res = coords;
    for (mediump float ndx = 0.05; ndx < uf_one; ndx += uf_third)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
    mediump float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    mediump float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump float ndx = 0.05; ndx < uf_one; ndx += uf_third)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
 highp int ui_three;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (highp int ndx = 0; ndx < ui_three; ndx++)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
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
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    highp float uf_one;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (highp float ndx = 0.05; ndx < uf_one; ndx += uf_third)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    highp float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (highp float ndx = 0.05; ndx < uf_one; ndx += uf_third)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) {}
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) {}
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    for (;;) { res = res.yzwx + vec4(1.0); if (i == ui_one) break; i++; }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    for (;;) { res = res.yzwx + vec4(1.0); if (i == ui_one) break; i++; }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_two; i++) { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_two; i++) { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_two; i++) res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_two; i++) res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_zero; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_zero; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_one; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_one; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (int i = 0; i < (ub_true ? ui_three : 0); i++) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (int i = 0; i < (ub_true ? ui_three : 0); i++) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { if (i == ui_two) continue; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { if (i == ui_two) continue; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { continue; }
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { continue; }
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { if (i == ui_two) continue; res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { if (i == ui_two) continue; res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { if (i == ui_two) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { if (i == ui_two) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (int i = 0; i < ui_three; ++i) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (int i = 0; i < ui_three; ++i) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_five; i++) { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_five; i++) { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump ivec4 i = ivec4(0, 1, ui_three, 0); i.x < i.z; i.x += i.y) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump ivec4 i = ivec4(0, 1, ui_three, 0); i.x < i.z; i.x += i.y) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_oneHundredOne; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(101);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_oneHundredOne; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(101);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i;
    for (i = 0; i < ui_two; i++) { res = res.yzwx + vec4(1.0); }
    for (; i < ui_five; i++) { res = res.yzwx + vec4(1.0); }
    res -= vec4(5);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i;
    for (i = 0; i < ui_two; i++) { res = res.yzwx + vec4(1.0); }
    for (; i < ui_five; i++) { res = res.yzwx + vec4(1.0); }
    res -= vec4(5);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_two; i++)
    {
        for (mediump int j = 0; j < ui_three; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_two; i++)
    {
        for (mediump int j = 0; j < ui_three; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++)
    {
        for (mediump int j = 0; j < ui_two; j++)
            res = res.yzwx + vec4(1.0);
        for (mediump int j = 0; j < ui_one; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(9);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++)
    {
        for (mediump int j = 0; j < ui_two; j++)
            res = res.yzwx + vec4(1.0);
        for (mediump int j = 0; j < ui_one; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(9);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++)
    {
        res = coords; // ignore outer loop effect 
        for (mediump int j = 0; j < ui_two; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++)
    {
        res = coords; // ignore outer loop effect 
        for (mediump int j = 0; j < ui_two; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++)
    {
        res = coords.wxyz - vec4(1.0);
        for (mediump int j = 0; j < ui_two; j++)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++)
    {
        res = coords.wxyz - vec4(1.0);
        for (mediump int j = 0; j < ui_two; j++)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        for (mediump int i = 0; i < ui_three; i++)
            res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        for (mediump int i = 0; i < ui_three; i++)
            res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        for (mediump int i = 0; i < ui_three; i++)
            res = res.yzwx + vec4(1.0);
    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        for (mediump int i = 0; i < ui_three; i++)
            res = res.yzwx + vec4(1.0);
    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++)
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i >= ui_three);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < ui_three; i++)
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i >= ui_three);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == ui_three)
    {
        for (mediump int i = 0; i < ui_three; i++)
            res = res.yzwx + vec4(1.0);
    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == ui_three)
    {
        for (mediump int i = 0; i < ui_three; i++)
            res = res.yzwx + vec4(1.0);
    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == ui_three)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        for (mediump int i = 0; i < ui_three; i++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == ui_three)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        for (mediump int i = 0; i < ui_three; i++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
 mediump int ui_three;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump int one = int(a_one + 0.5);
    mediump vec4 res = coords;
    for (mediump int ndx = 0; ndx < ui_three*one; ndx++)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec4 v_coords;
layout(location=1) out mediump float v_one;

void main()
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_one = a_one;
}
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
    for (mediump int ndx = 0; ndx < ui_three*one; ndx++)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
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
    for (mediump float ndx = 0.05; ndx < uf_one*one; ndx += uf_third*one)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
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
    for (mediump float ndx = 0.05; ndx < uf_one*one; ndx += uf_third*one)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
 highp int ui_three;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    highp int one = int(a_one + 0.5);
    mediump vec4 res = coords;
    for (highp int ndx = 0; ndx < ui_three*one; ndx++)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
 highp int ui_three;
};

void main()
{
    mediump vec4 coords = v_coords;
    highp int one = int(v_one + 0.5);
    mediump vec4 res = coords;
    for (highp int ndx = 0; ndx < ui_three*one; ndx++)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    highp float uf_one;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    highp float one = a_one;
    mediump vec4 res = coords;
    for (highp float ndx = 0.05; ndx < uf_one*one; ndx += uf_third*one)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    highp float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    highp float one = v_one;
    mediump vec4 res = coords;
    for (highp float ndx = 0.05; ndx < uf_one*one; ndx += uf_third*one)
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) {}
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) {}
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (;;) { break; res = res.yzwx + vec4(1.0); }
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (;;) { break; res = res.yzwx + vec4(1.0); }
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (;;) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (;;) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    for (;;) { res = res.yzwx + vec4(1.0); if (i == one*ui_one) break; i++; }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    for (;;) { res = res.yzwx + vec4(1.0); if (i == one*ui_one) break; i++; }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_two; i++) { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_two; i++) { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_two; i++) res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_two; i++) res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_zero; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_zero; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_one; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_one; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (int i = 0; i < (ub_true ? one*ui_three : 0); i++) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (int i = 0; i < (ub_true ? one*ui_three : 0); i++) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { if (i == one*ui_two) continue; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { if (i == one*ui_two) continue; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { continue; }
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { continue; }
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { if (i == one*ui_two) continue; res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { if (i == one*ui_two) continue; res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { if (i == one*ui_two) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { if (i == one*ui_two) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (int i = 0; i < one*ui_three; ++i) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (int i = 0; i < one*ui_three; ++i) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_five; i++) { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_five; i++) { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump ivec4 i = ivec4(0, 1, one*ui_three, 0); i.x < i.z; i.x += i.y) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump ivec4 i = ivec4(0, 1, one*ui_three, 0); i.x < i.z; i.x += i.y) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_oneHundredOne; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(101);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_oneHundredOne; i++) res = res.yzwx + vec4(1.0);
    res -= vec4(101);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i;
    for (i = 0; i < one*ui_two; i++) { res = res.yzwx + vec4(1.0); }
    for (; i < one*ui_five; i++) { res = res.yzwx + vec4(1.0); }
    res -= vec4(5);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i;
    for (i = 0; i < one*ui_two; i++) { res = res.yzwx + vec4(1.0); }
    for (; i < one*ui_five; i++) { res = res.yzwx + vec4(1.0); }
    res -= vec4(5);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_two; i++)
    {
        for (mediump int j = 0; j < one*ui_three; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_two; i++)
    {
        for (mediump int j = 0; j < one*ui_three; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++)
    {
        for (mediump int j = 0; j < one*ui_two; j++)
            res = res.yzwx + vec4(1.0);
        for (mediump int j = 0; j < one*ui_one; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(9);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++)
    {
        for (mediump int j = 0; j < one*ui_two; j++)
            res = res.yzwx + vec4(1.0);
        for (mediump int j = 0; j < one*ui_one; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(9);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++)
    {
        res = coords; // ignore outer loop effect 
        for (mediump int j = 0; j < one*ui_two; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++)
    {
        res = coords; // ignore outer loop effect 
        for (mediump int j = 0; j < one*ui_two; j++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++)
    {
        res = coords.wxyz - vec4(1.0);
        for (mediump int j = 0; j < one*ui_two; j++)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++)
    {
        res = coords.wxyz - vec4(1.0);
        for (mediump int j = 0; j < one*ui_two; j++)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        for (mediump int i = 0; i < one*ui_three; i++)
            res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        for (mediump int i = 0; i < one*ui_three; i++)
            res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        for (mediump int i = 0; i < one*ui_three; i++)
            res = res.yzwx + vec4(1.0);
    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        for (mediump int i = 0; i < one*ui_three; i++)
            res = res.yzwx + vec4(1.0);
    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++)
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i >= one*ui_three);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    for (mediump int i = 0; i < one*ui_three; i++)
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i >= one*ui_three);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == one*ui_three)
    {
        for (mediump int i = 0; i < one*ui_three; i++)
            res = res.yzwx + vec4(1.0);
    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == one*ui_three)
    {
        for (mediump int i = 0; i < one*ui_three; i++)
            res = res.yzwx + vec4(1.0);
    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == one*ui_three)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        for (mediump int i = 0; i < one*ui_three; i++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == one*ui_three)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        for (mediump int i = 0; i < one*ui_three; i++)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
	mediump int ndx = 0;
    while (ndx < 3)
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	mediump int ndx = 0;
    while (ndx < 3)
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
    mediump float uf_one;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
	mediump float ndx = 0.05;
    while (ndx < 1.0)
    {
        res = res.yzwx + vec4(1.0);
		ndx += 0.333333;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
    mediump float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	mediump float ndx = 0.05;
    while (ndx < 1.0)
    {
        res = res.yzwx + vec4(1.0);
		ndx += 0.333333;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
	highp int ndx = 0;
    while (ndx < 3)
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	highp int ndx = 0;
    while (ndx < 3)
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
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
    while (ndx < 1.0)
    {
        res = res.yzwx + vec4(1.0);
		ndx += 0.333333;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	highp float ndx = 0.05;
    while (ndx < 1.0)
    {
        res = res.yzwx + vec4(1.0);
		ndx += 0.333333;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) {}
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) {}
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    while (true) { break; res = res.yzwx + vec4(1.0); }
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    while (true) { break; res = res.yzwx + vec4(1.0); }
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    while (true) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    while (true) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (true) { res = res.yzwx + vec4(1.0); if (i == 1) break; i++; }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (true) { res = res.yzwx + vec4(1.0); if (i == 1) break; i++; }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 2) { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 2) { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 2) res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 2) res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 0) res = res.yzwx + vec4(1.0);
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 0) res = res.yzwx + vec4(1.0);
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 1) res = res.yzwx + vec4(1.0);
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 1) res = res.yzwx + vec4(1.0);
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i < (ub_true ? 3 : 0)) { res = res.yzwx + vec4(1.0); i++; }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i < (ub_true ? 3 : 0)) { res = res.yzwx + vec4(1.0); i++; }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) { if (i == 2) continue; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) { if (i == 2) continue; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) { res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) { res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) { continue; }
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) { continue; }
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) { if (i == 1) continue; res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) { if (i == 1) continue; res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) { if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) { if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (++i < 3) { res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (++i < 3) { res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < 3) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < 3) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 5) { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 5) { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump ivec4 i = ivec4(0, 1, 3, 0);
    while (i.x < i.z) { res = res.yzwx + vec4(1.0); i.x += i.y; }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump ivec4 i = ivec4(0, 1, 3, 0);
    while (i.x < i.z) { res = res.yzwx + vec4(1.0); i.x += i.y; }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 101) res = res.yzwx + vec4(1.0);
    res -= vec4(101);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 101) res = res.yzwx + vec4(1.0);
    res -= vec4(101);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < 2) { res = res.yzwx + vec4(1.0); }
    while (i++ < 6) { res = res.yzwx + vec4(1.0); }
    res -= vec4(5);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < 2) { res = res.yzwx + vec4(1.0); }
    while (i++ < 6) { res = res.yzwx + vec4(1.0); }
    res -= vec4(5);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < 2)
    {
        mediump int j = 0;
        while (j++ < 3)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < 2)
    {
        mediump int j = 0;
        while (j++ < 3)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < 3)
    {
        mediump int j = 0;
        while (j++ < 1)
            res = res.yzwx + vec4(1.0);
        while (j++ < 3)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < 3)
    {
        mediump int j = 0;
        while (j++ < 1)
            res = res.yzwx + vec4(1.0);
        while (j++ < 3)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3)
    {
        res = coords; // ignore outer loop effect 
        mediump int j = 0;
        while (j++ < 2)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3)
    {
        res = coords; // ignore outer loop effect 
        mediump int j = 0;
        while (j++ < 2)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3)
    {
        res = coords.wxyz - vec4(1.0);
        mediump int j = 0;
        while (j++ < 2)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3)
    {
        res = coords.wxyz - vec4(1.0);
        mediump int j = 0;
        while (j++ < 2)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        	mediump int i = 0;
    while(i++ < 3)
            res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        	mediump int i = 0;
    while(i++ < 3)
            res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        	mediump int i = 0;
    while(i++ < 3)
            res = res.yzwx + vec4(1.0);
    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        	mediump int i = 0;
    while(i++ < 3)
            res = res.yzwx + vec4(1.0);
    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3)
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i > 3);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < 3)
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i > 3);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == 3)
    {
        	mediump int i = 0;
    while(i++ < 3)
            res = res.yzwx + vec4(1.0);
    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == 3)
    {
        	mediump int i = 0;
    while(i++ < 3)
            res = res.yzwx + vec4(1.0);
    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == 3)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        	mediump int i = 0;
    while(i++ < 3)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == 3)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        	mediump int i = 0;
    while(i++ < 3)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
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
    while (ndx < ui_three)
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
 mediump int ui_three;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	mediump int ndx = 0;
    while (ndx < ui_three)
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
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
    mediump vec4 res = coords;
	mediump float ndx = 0.05;
    while (ndx < uf_one)
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
    mediump float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    mediump float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	mediump float ndx = 0.05;
    while (ndx < uf_one)
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
 highp int ui_three;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
	highp int ndx = 0;
    while (ndx < ui_three)
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
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
	highp int ndx = 0;
    while (ndx < ui_three)
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    highp float uf_one;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
	highp float ndx = 0.05;
    while (ndx < uf_one)
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    highp float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	highp float ndx = 0.05;
    while (ndx < uf_one)
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) {}
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) {}
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (true) { res = res.yzwx + vec4(1.0); if (i == ui_one) break; i++; }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (true) { res = res.yzwx + vec4(1.0); if (i == ui_one) break; i++; }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_two) { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_two) { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_two) res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_two) res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_zero) res = res.yzwx + vec4(1.0);
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_zero) res = res.yzwx + vec4(1.0);
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_one) res = res.yzwx + vec4(1.0);
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_one) res = res.yzwx + vec4(1.0);
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i < (ub_true ? ui_three : 0)) { res = res.yzwx + vec4(1.0); i++; }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i < (ub_true ? ui_three : 0)) { res = res.yzwx + vec4(1.0); i++; }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) { if (i == ui_two) continue; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) { if (i == ui_two) continue; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) { res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) { res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) { continue; }
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) { continue; }
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) { if (i == ui_one) continue; res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) { if (i == ui_one) continue; res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) { if (i == ui_three) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) { if (i == ui_three) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (++i < ui_three) { res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (++i < ui_three) { res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < ui_three) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < ui_three) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_five) { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_five) { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump ivec4 i = ivec4(0, 1, ui_three, 0);
    while (i.x < i.z) { res = res.yzwx + vec4(1.0); i.x += i.y; }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump ivec4 i = ivec4(0, 1, ui_three, 0);
    while (i.x < i.z) { res = res.yzwx + vec4(1.0); i.x += i.y; }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_oneHundredOne) res = res.yzwx + vec4(1.0);
    res -= vec4(101);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_oneHundredOne) res = res.yzwx + vec4(1.0);
    res -= vec4(101);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < ui_two) { res = res.yzwx + vec4(1.0); }
    while (i++ < ui_six) { res = res.yzwx + vec4(1.0); }
    res -= vec4(5);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < ui_two) { res = res.yzwx + vec4(1.0); }
    while (i++ < ui_six) { res = res.yzwx + vec4(1.0); }
    res -= vec4(5);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < ui_two)
    {
        mediump int j = 0;
        while (j++ < ui_three)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < ui_two)
    {
        mediump int j = 0;
        while (j++ < ui_three)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < ui_three)
    {
        mediump int j = 0;
        while (j++ < ui_one)
            res = res.yzwx + vec4(1.0);
        while (j++ < ui_three)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < ui_three)
    {
        mediump int j = 0;
        while (j++ < ui_one)
            res = res.yzwx + vec4(1.0);
        while (j++ < ui_three)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three)
    {
        res = coords; // ignore outer loop effect 
        mediump int j = 0;
        while (j++ < ui_two)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three)
    {
        res = coords; // ignore outer loop effect 
        mediump int j = 0;
        while (j++ < ui_two)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three)
    {
        res = coords.wxyz - vec4(1.0);
        mediump int j = 0;
        while (j++ < ui_two)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three)
    {
        res = coords.wxyz - vec4(1.0);
        mediump int j = 0;
        while (j++ < ui_two)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        	mediump int i = 0;
    while(i++ < ui_three)
            res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        	mediump int i = 0;
    while(i++ < ui_three)
            res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        	mediump int i = 0;
    while(i++ < ui_three)
            res = res.yzwx + vec4(1.0);
    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        	mediump int i = 0;
    while(i++ < ui_three)
            res = res.yzwx + vec4(1.0);
    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three)
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i > ui_three);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < ui_three)
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i > ui_three);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == ui_three)
    {
        	mediump int i = 0;
    while(i++ < ui_three)
            res = res.yzwx + vec4(1.0);
    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == ui_three)
    {
        	mediump int i = 0;
    while(i++ < ui_three)
            res = res.yzwx + vec4(1.0);
    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == ui_three)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        	mediump int i = 0;
    while(i++ < ui_three)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == ui_three)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        	mediump int i = 0;
    while(i++ < ui_three)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
 mediump int ui_three;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump int one = int(a_one + 0.5);
    mediump vec4 res = coords;
	mediump int ndx = 0;
    while (ndx < ui_three*one)
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
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
    while (ndx < uf_one*one)
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third*one;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
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
    while (ndx < uf_one*one)
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third*one;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
 highp int ui_three;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    highp int one = int(a_one + 0.5);
    mediump vec4 res = coords;
	highp int ndx = 0;
    while (ndx < ui_three*one)
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
 highp int ui_three;
};

void main()
{
    mediump vec4 coords = v_coords;
    highp int one = int(v_one + 0.5);
    mediump vec4 res = coords;
	highp int ndx = 0;
    while (ndx < ui_three*one)
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    highp float uf_one;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    highp float one = a_one;
    mediump vec4 res = coords;
	highp float ndx = 0.05;
    while (ndx < uf_one*one)
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third*one;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    highp float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    highp float one = v_one;
    mediump vec4 res = coords;
	highp float ndx = 0.05;
    while (ndx < uf_one*one)
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third*one;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) {}
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) {}
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    while (true) { break; res = res.yzwx + vec4(1.0); }
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    while (true) { break; res = res.yzwx + vec4(1.0); }
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    while (true) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    while (true) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (true) { res = res.yzwx + vec4(1.0); if (i == one*ui_one) break; i++; }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (true) { res = res.yzwx + vec4(1.0); if (i == one*ui_one) break; i++; }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) res = res.yzwx + vec4(1.0);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_two) { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_two) { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_two) res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_two) res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_zero) res = res.yzwx + vec4(1.0);
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_zero) res = res.yzwx + vec4(1.0);
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_one) res = res.yzwx + vec4(1.0);
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_one) res = res.yzwx + vec4(1.0);
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i < (ub_true ? one*ui_three : 0)) { res = res.yzwx + vec4(1.0); i++; }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i < (ub_true ? one*ui_three : 0)) { res = res.yzwx + vec4(1.0); i++; }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) { if (i == one*ui_two) continue; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) { if (i == one*ui_two) continue; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) { res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) { res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) { continue; }
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) { continue; }
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) { if (i == one*ui_one) continue; res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) { if (i == one*ui_one) continue; res = res.yzwx + vec4(1.0); continue; }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) { if (i == one*ui_three) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) { if (i == one*ui_three) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (++i < one*ui_three) { res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (++i < one*ui_three) { res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < one*ui_three) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < one*ui_three) { res = res.yzwx + vec4(1.0); }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_five) { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_five) { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump ivec4 i = ivec4(0, 1, one*ui_three, 0);
    while (i.x < i.z) { res = res.yzwx + vec4(1.0); i.x += i.y; }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump ivec4 i = ivec4(0, 1, one*ui_three, 0);
    while (i.x < i.z) { res = res.yzwx + vec4(1.0); i.x += i.y; }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_oneHundredOne) res = res.yzwx + vec4(1.0);
    res -= vec4(101);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_oneHundredOne) res = res.yzwx + vec4(1.0);
    res -= vec4(101);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < one*ui_two) { res = res.yzwx + vec4(1.0); }
    while (i++ < one*ui_six) { res = res.yzwx + vec4(1.0); }
    res -= vec4(5);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < one*ui_two) { res = res.yzwx + vec4(1.0); }
    while (i++ < one*ui_six) { res = res.yzwx + vec4(1.0); }
    res -= vec4(5);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < one*ui_two)
    {
        mediump int j = 0;
        while (j++ < one*ui_three)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < one*ui_two)
    {
        mediump int j = 0;
        while (j++ < one*ui_three)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < one*ui_three)
    {
        mediump int j = 0;
        while (j++ < one*ui_one)
            res = res.yzwx + vec4(1.0);
        while (j++ < one*ui_three)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    while (i++ < one*ui_three)
    {
        mediump int j = 0;
        while (j++ < one*ui_one)
            res = res.yzwx + vec4(1.0);
        while (j++ < one*ui_three)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(6);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three)
    {
        res = coords; // ignore outer loop effect 
        mediump int j = 0;
        while (j++ < one*ui_two)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three)
    {
        res = coords; // ignore outer loop effect 
        mediump int j = 0;
        while (j++ < one*ui_two)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three)
    {
        res = coords.wxyz - vec4(1.0);
        mediump int j = 0;
        while (j++ < one*ui_two)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three)
    {
        res = coords.wxyz - vec4(1.0);
        mediump int j = 0;
        while (j++ < one*ui_two)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        	mediump int i = 0;
    while(i++ < one*ui_three)
            res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        	mediump int i = 0;
    while(i++ < one*ui_three)
            res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        	mediump int i = 0;
    while(i++ < one*ui_three)
            res = res.yzwx + vec4(1.0);
    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        	mediump int i = 0;
    while(i++ < one*ui_three)
            res = res.yzwx + vec4(1.0);
    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three)
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i > one*ui_three);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
    while(i++ < one*ui_three)
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i > one*ui_three);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == one*ui_three)
    {
        	mediump int i = 0;
    while(i++ < one*ui_three)
            res = res.yzwx + vec4(1.0);
    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == one*ui_three)
    {
        	mediump int i = 0;
    while(i++ < one*ui_three)
            res = res.yzwx + vec4(1.0);
    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == one*ui_three)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        	mediump int i = 0;
    while(i++ < one*ui_three)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == one*ui_three)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        	mediump int i = 0;
    while(i++ < one*ui_three)
            res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;

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
    } while (ndx < 3);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	mediump int ndx = 0;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    } while (ndx < 3);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
    mediump float uf_one;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
	mediump float ndx = 0.05;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx += 0.333333;
    } while (ndx < 1.0);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
    mediump float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	mediump float ndx = 0.05;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx += 0.333333;
    } while (ndx < 1.0);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
	highp int ndx = 0;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    } while (ndx < 3);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	highp int ndx = 0;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    } while (ndx < 3);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
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
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	highp float ndx = 0.05;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx += 0.333333;
    } while (ndx < 1.0);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  {}  while (++i < 3);

    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  {}  while (++i < 3);

    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    do { break; res = res.yzwx + vec4(1.0); } while (true);
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    do { break; res = res.yzwx + vec4(1.0); } while (true);
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    do { res = res.yzwx + vec4(1.0); break; } while (true);
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    do { res = res.yzwx + vec4(1.0); break; } while (true);
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); if (i == 1) break; i++; } while (true);
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); if (i == 1) break; i++; } while (true);
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < 3);

    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < 3);

    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }  while (++i < 2);

    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }  while (++i < 2);

    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);  while (++i < 2);

    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);  while (++i < 2);

    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < 1);

    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < 1);

    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < (ub_true ? 3 : 0));
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < (ub_true ? 3 : 0));
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == 2) continue; res = res.yzwx + vec4(1.0); }  while (++i < 3);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == 2) continue; res = res.yzwx + vec4(1.0); }  while (++i < 3);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); continue; }  while (++i < 3);

    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); continue; }  while (++i < 3);

    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { continue; }  while (++i < 3);

    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { continue; }  while (++i < 3);

    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == 2) continue; res = res.yzwx + vec4(1.0); continue; }  while (++i < 3);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == 2) continue; res = res.yzwx + vec4(1.0); continue; }  while (++i < 3);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); if (i == 1) break; }  while (++i < 3);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); if (i == 1) break; }  while (++i < 3);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); break; }  while (++i < 3);

    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); break; }  while (++i < 3);

    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < 3);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < 3);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (i++ < 3);
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (i++ < 3);
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }  while (++i < 5);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }  while (++i < 5);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump ivec4 i = ivec4(0, 1, 3, 0);
    do { res = res.yzwx + vec4(1.0); } while ((i.x += i.y) < i.z);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump ivec4 i = ivec4(0, 1, 3, 0);
    do { res = res.yzwx + vec4(1.0); } while ((i.x += i.y) < i.z);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < 101);

    res -= vec4(101);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < 101);

    res -= vec4(101);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < 2);
    do { res = res.yzwx + vec4(1.0); } while (++i < 5);
    res -= vec4(5);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < 2);
    do { res = res.yzwx + vec4(1.0); } while (++i < 5);
    res -= vec4(5);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do
    {
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < 3);
    } while (++i < 2);
    res -= vec4(6);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do
    {
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < 3);
    } while (++i < 2);
    res -= vec4(6);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do
    {
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < 2);
        do
            res = res.yzwx + vec4(1.0);
        while (++j < 3);
    } while (++i < 3);
    res -= vec4(9);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do
    {
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < 2);
        do
            res = res.yzwx + vec4(1.0);
        while (++j < 3);
    } while (++i < 3);
    res -= vec4(9);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        res = coords; // ignore outer loop effect 
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < 2);
    }  while (++i < 3);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        res = coords; // ignore outer loop effect 
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < 2);
    }  while (++i < 3);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        res = coords.wxyz - vec4(1.0);
        mediump int j = 0;
        while (j++ < 2)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }  while (++i < 3);

    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        res = coords.wxyz - vec4(1.0);
        mediump int j = 0;
        while (j++ < 2)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }  while (++i < 3);

    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < 3);

        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < 3);

        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < 3);

    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < 3);

    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i >= 3);
    }  while (++i < 3);

    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i >= 3);
    }  while (++i < 3);

    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == 3)
    {
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < 3);

    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == 3)
    {
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < 3);

    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == 3)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < 3);

    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == 3)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < 3);

    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
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
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
 mediump int ui_three;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	mediump int ndx = 0;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    } while (ndx < ui_three);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
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
    mediump vec4 res = coords;
	mediump float ndx = 0.05;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third;
    } while (ndx < uf_one);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
    mediump float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    mediump float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	mediump float ndx = 0.05;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third;
    } while (ndx < uf_one);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
 highp int ui_three;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
	highp int ndx = 0;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    } while (ndx < ui_three);
    res -= vec4(3);
    v_color = res.rgb;
}
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
	highp int ndx = 0;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    } while (ndx < ui_three);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
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
		ndx += uf_third;
    } while (ndx < uf_one);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    highp float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
	highp float ndx = 0.05;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third;
    } while (ndx < uf_one);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  {}  while (++i < ui_three);

    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  {}  while (++i < ui_three);

    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); if (i == ui_one) break; i++; } while (true);
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); if (i == ui_one) break; i++; } while (true);
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < ui_three);

    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < ui_three);

    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }  while (++i < ui_two);

    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }  while (++i < ui_two);

    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);  while (++i < ui_two);

    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);  while (++i < ui_two);

    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < ui_one);

    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < ui_one);

    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < (ub_true ? ui_three : 0));
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < (ub_true ? ui_three : 0));
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == ui_two) continue; res = res.yzwx + vec4(1.0); }  while (++i < ui_three);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == ui_two) continue; res = res.yzwx + vec4(1.0); }  while (++i < ui_three);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); continue; }  while (++i < ui_three);

    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); continue; }  while (++i < ui_three);

    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { continue; }  while (++i < ui_three);

    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { continue; }  while (++i < ui_three);

    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == ui_two) continue; res = res.yzwx + vec4(1.0); continue; }  while (++i < ui_three);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == ui_two) continue; res = res.yzwx + vec4(1.0); continue; }  while (++i < ui_three);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); if (i == ui_one) break; }  while (++i < ui_three);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); if (i == ui_one) break; }  while (++i < ui_three);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); break; }  while (++i < ui_three);

    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); break; }  while (++i < ui_three);

    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < ui_three);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < ui_three);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (i++ < ui_three);
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (i++ < ui_three);
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }  while (++i < ui_five);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }  while (++i < ui_five);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump ivec4 i = ivec4(0, 1, ui_three, 0);
    do { res = res.yzwx + vec4(1.0); } while ((i.x += i.y) < i.z);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump ivec4 i = ivec4(0, 1, ui_three, 0);
    do { res = res.yzwx + vec4(1.0); } while ((i.x += i.y) < i.z);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < ui_oneHundredOne);

    res -= vec4(101);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < ui_oneHundredOne);

    res -= vec4(101);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < ui_two);
    do { res = res.yzwx + vec4(1.0); } while (++i < ui_five);
    res -= vec4(5);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < ui_two);
    do { res = res.yzwx + vec4(1.0); } while (++i < ui_five);
    res -= vec4(5);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do
    {
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < ui_three);
    } while (++i < ui_two);
    res -= vec4(6);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do
    {
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < ui_three);
    } while (++i < ui_two);
    res -= vec4(6);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do
    {
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < ui_two);
        do
            res = res.yzwx + vec4(1.0);
        while (++j < ui_three);
    } while (++i < ui_three);
    res -= vec4(9);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do
    {
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < ui_two);
        do
            res = res.yzwx + vec4(1.0);
        while (++j < ui_three);
    } while (++i < ui_three);
    res -= vec4(9);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        res = coords; // ignore outer loop effect 
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < ui_two);
    }  while (++i < ui_three);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        res = coords; // ignore outer loop effect 
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < ui_two);
    }  while (++i < ui_three);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        res = coords.wxyz - vec4(1.0);
        mediump int j = 0;
        while (j++ < ui_two)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }  while (++i < ui_three);

    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        res = coords.wxyz - vec4(1.0);
        mediump int j = 0;
        while (j++ < ui_two)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }  while (++i < ui_three);

    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < ui_three);

        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < ui_three);

        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < ui_three);

    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < ui_three);

    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i >= ui_three);
    }  while (++i < ui_three);

    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i >= ui_three);
    }  while (++i < ui_three);

    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == ui_three)
    {
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < ui_three);

    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == ui_three)
    {
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < ui_three);

    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == ui_three)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < ui_three);

    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == ui_three)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < ui_three);

    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
 mediump int ui_three;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump int one = int(a_one + 0.5);
    mediump vec4 res = coords;
	mediump int ndx = 0;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    } while (ndx < ui_three*one);
    res -= vec4(3);
    v_color = res.rgb;
}
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
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    } while (ndx < ui_three*one);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
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
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
 highp int ui_three;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    highp int one = int(a_one + 0.5);
    mediump vec4 res = coords;
	highp int ndx = 0;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    } while (ndx < ui_three*one);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
 highp int ui_three;
};

void main()
{
    mediump vec4 coords = v_coords;
    highp int one = int(v_one + 0.5);
    mediump vec4 res = coords;
	highp int ndx = 0;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx++;
    } while (ndx < ui_three*one);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    highp float uf_one;
};

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    highp float one = a_one;
    mediump vec4 res = coords;
	highp float ndx = 0.05;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third*one;
    } while (ndx < uf_one*one);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
    highp float uf_third;
};
layout(std140, set=0, binding=1) uniform buff1 {
    highp float uf_one;
};

void main()
{
    mediump vec4 coords = v_coords;
    highp float one = v_one;
    mediump vec4 res = coords;
	highp float ndx = 0.05;
    do
    {
        res = res.yzwx + vec4(1.0);
		ndx += uf_third*one;
    } while (ndx < uf_one*one);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  {}  while (++i < one*ui_three);

    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  {}  while (++i < one*ui_three);

    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    do { break; res = res.yzwx + vec4(1.0); } while (true);
    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    do { break; res = res.yzwx + vec4(1.0); } while (true);
    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    do { res = res.yzwx + vec4(1.0); break; } while (true);
    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    do { res = res.yzwx + vec4(1.0); break; } while (true);
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); if (i == one*ui_one) break; i++; } while (true);
    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); if (i == one*ui_one) break; i++; } while (true);
    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < one*ui_three);

    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < one*ui_three);

    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }  while (++i < one*ui_two);

    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); res = res.yzwx + vec4(1.0); }  while (++i < one*ui_two);

    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);  while (++i < one*ui_two);

    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0), res = res.yzwx + vec4(1.0);  while (++i < one*ui_two);

    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < one*ui_one);

    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < one*ui_one);

    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < (ub_true ? one*ui_three : 0));
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  bool ub_true;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_one;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_two;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_three;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_four;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_five;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < (ub_true ? one*ui_three : 0));
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == one*ui_two) continue; res = res.yzwx + vec4(1.0); }  while (++i < one*ui_three);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == one*ui_two) continue; res = res.yzwx + vec4(1.0); }  while (++i < one*ui_three);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); continue; }  while (++i < one*ui_three);

    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); continue; }  while (++i < one*ui_three);

    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { continue; }  while (++i < one*ui_three);

    res -= vec4(0);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { continue; }  while (++i < one*ui_three);

    res -= vec4(0);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == one*ui_two) continue; res = res.yzwx + vec4(1.0); continue; }  while (++i < one*ui_three);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == one*ui_two) continue; res = res.yzwx + vec4(1.0); continue; }  while (++i < one*ui_three);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); if (i == one*ui_one) break; }  while (++i < one*ui_three);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); if (i == one*ui_one) break; }  while (++i < one*ui_three);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); break; }  while (++i < one*ui_three);

    res -= vec4(1);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { res = res.yzwx + vec4(1.0); break; }  while (++i < one*ui_three);

    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < one*ui_three);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < one*ui_three);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (i++ < one*ui_three);
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (i++ < one*ui_three);
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }  while (++i < one*ui_five);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  { if (i == 0) continue; else if (i == 3) break; res = res.yzwx + vec4(1.0); }  while (++i < one*ui_five);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump ivec4 i = ivec4(0, 1, one*ui_three, 0);
    do { res = res.yzwx + vec4(1.0); } while ((i.x += i.y) < i.z);
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump ivec4 i = ivec4(0, 1, one*ui_three, 0);
    do { res = res.yzwx + vec4(1.0); } while ((i.x += i.y) < i.z);
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < one*ui_oneHundredOne);

    res -= vec4(101);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};
layout(std140, set=0, binding=7) uniform buff7 {
  mediump int ui_oneHundredOne;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do  res = res.yzwx + vec4(1.0);  while (++i < one*ui_oneHundredOne);

    res -= vec4(101);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < one*ui_two);
    do { res = res.yzwx + vec4(1.0); } while (++i < one*ui_five);
    res -= vec4(5);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do { res = res.yzwx + vec4(1.0); } while (++i < one*ui_two);
    do { res = res.yzwx + vec4(1.0); } while (++i < one*ui_five);
    res -= vec4(5);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do
    {
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < one*ui_three);
    } while (++i < one*ui_two);
    res -= vec4(6);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do
    {
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < one*ui_three);
    } while (++i < one*ui_two);
    res -= vec4(6);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do
    {
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < one*ui_two);
        do
            res = res.yzwx + vec4(1.0);
        while (++j < one*ui_three);
    } while (++i < one*ui_three);
    res -= vec4(9);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    mediump int i = 0;
    do
    {
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < one*ui_two);
        do
            res = res.yzwx + vec4(1.0);
        while (++j < one*ui_three);
    } while (++i < one*ui_three);
    res -= vec4(9);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        res = coords; // ignore outer loop effect 
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < one*ui_two);
    }  while (++i < one*ui_three);

    res -= vec4(2);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        res = coords; // ignore outer loop effect 
        mediump int j = 0;
        do
            res = res.yzwx + vec4(1.0);
        while (++j < one*ui_two);
    }  while (++i < one*ui_three);

    res -= vec4(2);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        res = coords.wxyz - vec4(1.0);
        mediump int j = 0;
        while (j++ < one*ui_two)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }  while (++i < one*ui_three);

    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        res = coords.wxyz - vec4(1.0);
        mediump int j = 0;
        while (j++ < one*ui_two)
            res = res.yzwx + vec4(1.0);
        coords = res;
    }  while (++i < one*ui_three);

    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < one*ui_three);

        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        res = res.yzwx + vec4(1.0);
    case 4:
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < one*ui_three);

        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < one*ui_three);

    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    switch (j)
    {
    case 3:
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < one*ui_three);

    case 4:
        res = res.yzwx + vec4(1.0);
        break;
    }
    res -= vec4(4);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i >= one*ui_three);
    }  while (++i < one*ui_three);

    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    	mediump int i = 0;
	do 
    {
        do
        {
            res = res.yzwx + vec4(1.0);
        } while (i >= one*ui_three);
    }  while (++i < one*ui_three);

    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == one*ui_three)
    {
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < one*ui_three);

    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 3;
    if (j == one*ui_three)
    {
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < one*ui_three);

    }
    else
    {
        res = res.yzwx + vec4(1.0);
    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec3 v_color;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    gl_Position = a_position;
    mediump int one = int(a_one + 0.5);
    mediump vec4 coords = a_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == one*ui_three)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < one*ui_three);

    }
    res -= vec4(3);
    v_color = res.rgb;
}
#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(location=1) in mediump float v_one;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump int one = int(v_one + 0.5);
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    int j = 2;
    if (j == one*ui_three)
    {
        res = res.yzwx + vec4(1.0);
    }
    else
    {
        	mediump int i = 0;
	do 
        {
            res = res.yzwx + vec4(1.0);
        }  while (++i < one*ui_three);

    }
    res -= vec4(3);
    o_color = vec4(res.rgb, 1.0);
}
