#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump float var[4];

void main()
{
    gl_Position = a_position;
    var[0] = float(a_coords);
    var[1] = float(a_coords) * 0.5;
    var[2] = float(a_coords) * 0.25;
    var[3] = float(a_coords) * 0.125;
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump float var[4];

void main()
{
    mediump float res = float(0.0);
    res += var[0];
    res += var[1];
    res += var[2];
    res += var[3];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(location = 0) in mediump float var[4];

void main()
{
    mediump float res = float(0.0);
    res += var[ui_zero];
    res += var[ui_one];
    res += var[ui_two];
    res += var[ui_three];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump float var[4];

void main()
{
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += var[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(location = 0) in mediump float var[4];

void main()
{
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += var[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(location = 0) out mediump float var[4];

void main()
{
    gl_Position = a_position;
    var[ui_zero]  = float(a_coords);
    var[ui_one]   = float(a_coords) * 0.5;
    var[ui_two]   = float(a_coords) * 0.25;
    var[ui_three] = float(a_coords) * 0.125;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump float var[4];

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    for (int i = 0; i < 4; i++)
    {
        var[i] = float(coords);
        coords = coords * 0.5;
    }
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(std140, binding = 4) uniform something { mediump int ui_four; };
layout(location = 0) out mediump float var[4];

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    for (int i = 0; i < ui_four; i++)
    {
        var[i] = float(coords);
        coords = coords * 0.5;
    }
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec2 var[4];

void main()
{
    gl_Position = a_position;
    var[0] = vec2(a_coords);
    var[1] = vec2(a_coords) * 0.5;
    var[2] = vec2(a_coords) * 0.25;
    var[3] = vec2(a_coords) * 0.125;
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec2 var[4];

void main()
{
    mediump vec2 res = vec2(0.0);
    res += var[0];
    res += var[1];
    res += var[2];
    res += var[3];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(location = 0) in mediump vec2 var[4];

void main()
{
    mediump vec2 res = vec2(0.0);
    res += var[ui_zero];
    res += var[ui_one];
    res += var[ui_two];
    res += var[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec2 var[4];

void main()
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += var[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(location = 0) in mediump vec2 var[4];

void main()
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += var[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(location = 0) out mediump vec2 var[4];

void main()
{
    gl_Position = a_position;
    var[ui_zero]  = vec2(a_coords);
    var[ui_one]   = vec2(a_coords) * 0.5;
    var[ui_two]   = vec2(a_coords) * 0.25;
    var[ui_three] = vec2(a_coords) * 0.125;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec2 var[4];

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    for (int i = 0; i < 4; i++)
    {
        var[i] = vec2(coords);
        coords = coords * 0.5;
    }
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(std140, binding = 4) uniform something { mediump int ui_four; };
layout(location = 0) out mediump vec2 var[4];

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    for (int i = 0; i < ui_four; i++)
    {
        var[i] = vec2(coords);
        coords = coords * 0.5;
    }
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 var[4];

void main()
{
    gl_Position = a_position;
    var[0] = vec3(a_coords);
    var[1] = vec3(a_coords) * 0.5;
    var[2] = vec3(a_coords) * 0.25;
    var[3] = vec3(a_coords) * 0.125;
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec3 var[4];

void main()
{
    mediump vec3 res = vec3(0.0);
    res += var[0];
    res += var[1];
    res += var[2];
    res += var[3];
    o_color = vec4(res, 1.0);
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(location = 0) in mediump vec3 var[4];

void main()
{
    mediump vec3 res = vec3(0.0);
    res += var[ui_zero];
    res += var[ui_one];
    res += var[ui_two];
    res += var[ui_three];
    o_color = vec4(res, 1.0);
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec3 var[4];

void main()
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += var[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(location = 0) in mediump vec3 var[4];

void main()
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += var[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(location = 0) out mediump vec3 var[4];

void main()
{
    gl_Position = a_position;
    var[ui_zero]  = vec3(a_coords);
    var[ui_one]   = vec3(a_coords) * 0.5;
    var[ui_two]   = vec3(a_coords) * 0.25;
    var[ui_three] = vec3(a_coords) * 0.125;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 var[4];

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    for (int i = 0; i < 4; i++)
    {
        var[i] = vec3(coords);
        coords = coords * 0.5;
    }
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(std140, binding = 4) uniform something { mediump int ui_four; };
layout(location = 0) out mediump vec3 var[4];

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    for (int i = 0; i < ui_four; i++)
    {
        var[i] = vec3(coords);
        coords = coords * 0.5;
    }
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 var[4];

void main()
{
    gl_Position = a_position;
    var[0] = vec4(a_coords);
    var[1] = vec4(a_coords) * 0.5;
    var[2] = vec4(a_coords) * 0.25;
    var[3] = vec4(a_coords) * 0.125;
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 var[4];

void main()
{
    mediump vec4 res = vec4(0.0);
    res += var[0];
    res += var[1];
    res += var[2];
    res += var[3];
    o_color = vec4(res);
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(location = 0) in mediump vec4 var[4];

void main()
{
    mediump vec4 res = vec4(0.0);
    res += var[ui_zero];
    res += var[ui_one];
    res += var[ui_two];
    res += var[ui_three];
    o_color = vec4(res);
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 var[4];

void main()
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += var[i];
    o_color = vec4(res);
}
#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(location = 0) in mediump vec4 var[4];

void main()
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += var[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(location = 0) out mediump vec4 var[4];

void main()
{
    gl_Position = a_position;
    var[ui_zero]  = vec4(a_coords);
    var[ui_one]   = vec4(a_coords) * 0.5;
    var[ui_two]   = vec4(a_coords) * 0.25;
    var[ui_three] = vec4(a_coords) * 0.125;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 var[4];

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    for (int i = 0; i < 4; i++)
    {
        var[i] = vec4(coords);
        coords = coords * 0.5;
    }
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(std140, binding = 4) uniform something { mediump int ui_four; };
layout(location = 0) out mediump vec4 var[4];

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    for (int i = 0; i < ui_four; i++)
    {
        var[i] = vec4(coords);
        coords = coords * 0.5;
    }
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 5) uniform something5 { mediump float u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump float res = float(0.0);
    res += u_arr[0];
    res += u_arr[1];
    res += u_arr[2];
    res += u_arr[3];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_color;

void main()
{
    o_color = v_color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_coords;

void main()
{
    gl_Position = a_position;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 5) uniform something5 { mediump float u_arr[4]; };

void main()
{
    mediump float res = float(0.0);
    res += u_arr[0];
    res += u_arr[1];
    res += u_arr[2];
    res += u_arr[3];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 5) uniform something5 { mediump float u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump float res = float(0.0);
    res += u_arr[ui_zero];
    res += u_arr[ui_one];
    res += u_arr[ui_two];
    res += u_arr[ui_three];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 5) uniform something5 { mediump float u_arr[4]; };

void main()
{
    mediump float res = float(0.0);
    res += u_arr[ui_zero];
    res += u_arr[ui_one];
    res += u_arr[ui_two];
    res += u_arr[ui_three];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 5) uniform something5 { mediump float u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += u_arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 5) uniform something5 { mediump float u_arr[4]; };

void main()
{
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += u_arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(std140, binding = 5) uniform something5 { mediump float u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += u_arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(std140, binding = 5) uniform something5 { mediump float u_arr[4]; };

void main()
{
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += u_arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 5) uniform something5 { mediump vec2 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec2 res = vec2(0.0);
    res += u_arr[0];
    res += u_arr[1];
    res += u_arr[2];
    res += u_arr[3];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 5) uniform something5 { mediump vec2 u_arr[4]; };

void main()
{
    mediump vec2 res = vec2(0.0);
    res += u_arr[0];
    res += u_arr[1];
    res += u_arr[2];
    res += u_arr[3];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 5) uniform something5 { mediump vec2 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec2 res = vec2(0.0);
    res += u_arr[ui_zero];
    res += u_arr[ui_one];
    res += u_arr[ui_two];
    res += u_arr[ui_three];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 5) uniform something5 { mediump vec2 u_arr[4]; };

void main()
{
    mediump vec2 res = vec2(0.0);
    res += u_arr[ui_zero];
    res += u_arr[ui_one];
    res += u_arr[ui_two];
    res += u_arr[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 5) uniform something5 { mediump vec2 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += u_arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 5) uniform something5 { mediump vec2 u_arr[4]; };

void main()
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += u_arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(std140, binding = 5) uniform something5 { mediump vec2 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += u_arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(std140, binding = 5) uniform something5 { mediump vec2 u_arr[4]; };

void main()
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += u_arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 5) uniform something5 { mediump vec3 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec3 res = vec3(0.0);
    res += u_arr[0];
    res += u_arr[1];
    res += u_arr[2];
    res += u_arr[3];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 5) uniform something5 { mediump vec3 u_arr[4]; };

void main()
{
    mediump vec3 res = vec3(0.0);
    res += u_arr[0];
    res += u_arr[1];
    res += u_arr[2];
    res += u_arr[3];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 5) uniform something5 { mediump vec3 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec3 res = vec3(0.0);
    res += u_arr[ui_zero];
    res += u_arr[ui_one];
    res += u_arr[ui_two];
    res += u_arr[ui_three];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 5) uniform something5 { mediump vec3 u_arr[4]; };

void main()
{
    mediump vec3 res = vec3(0.0);
    res += u_arr[ui_zero];
    res += u_arr[ui_one];
    res += u_arr[ui_two];
    res += u_arr[ui_three];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 5) uniform something5 { mediump vec3 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += u_arr[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 5) uniform something5 { mediump vec3 u_arr[4]; };

void main()
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += u_arr[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(std140, binding = 5) uniform something5 { mediump vec3 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += u_arr[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(std140, binding = 5) uniform something5 { mediump vec3 u_arr[4]; };

void main()
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += u_arr[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 5) uniform something5 { mediump vec4 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec4 res = vec4(0.0);
    res += u_arr[0];
    res += u_arr[1];
    res += u_arr[2];
    res += u_arr[3];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 5) uniform something5 { mediump vec4 u_arr[4]; };

void main()
{
    mediump vec4 res = vec4(0.0);
    res += u_arr[0];
    res += u_arr[1];
    res += u_arr[2];
    res += u_arr[3];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 5) uniform something5 { mediump vec4 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec4 res = vec4(0.0);
    res += u_arr[ui_zero];
    res += u_arr[ui_one];
    res += u_arr[ui_two];
    res += u_arr[ui_three];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 5) uniform something5 { mediump vec4 u_arr[4]; };

void main()
{
    mediump vec4 res = vec4(0.0);
    res += u_arr[ui_zero];
    res += u_arr[ui_one];
    res += u_arr[ui_two];
    res += u_arr[ui_three];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 5) uniform something5 { mediump vec4 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += u_arr[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 5) uniform something5 { mediump vec4 u_arr[4]; };

void main()
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += u_arr[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(std140, binding = 5) uniform something5 { mediump vec4 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += u_arr[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(std140, binding = 5) uniform something5 { mediump vec4 u_arr[4]; };

void main()
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += u_arr[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    arr[0] = float(coords);
    arr[1] = float(coords) * 0.5;
    arr[2] = float(coords) * 0.25;
    arr[3] = float(coords) * 0.125;
    mediump float res = float(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    arr[0] = float(coords);
    arr[1] = float(coords) * 0.5;
    arr[2] = float(coords) * 0.25;
    arr[3] = float(coords) * 0.125;
    mediump float res = float(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    arr[0] = float(coords);
    arr[1] = float(coords) * 0.5;
    arr[2] = float(coords) * 0.25;
    arr[3] = float(coords) * 0.125;
    mediump float res = float(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    arr[0] = float(coords);
    arr[1] = float(coords) * 0.5;
    arr[2] = float(coords) * 0.25;
    arr[3] = float(coords) * 0.125;
    mediump float res = float(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    arr[0] = float(coords);
    arr[1] = float(coords) * 0.5;
    arr[2] = float(coords) * 0.25;
    arr[3] = float(coords) * 0.125;
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    arr[0] = float(coords);
    arr[1] = float(coords) * 0.5;
    arr[2] = float(coords) * 0.25;
    arr[3] = float(coords) * 0.125;
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    arr[0] = float(coords);
    arr[1] = float(coords) * 0.5;
    arr[2] = float(coords) * 0.25;
    arr[3] = float(coords) * 0.125;
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    arr[0] = float(coords);
    arr[1] = float(coords) * 0.5;
    arr[2] = float(coords) * 0.25;
    arr[3] = float(coords) * 0.125;
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    arr[ui_zero]  = float(coords);
    arr[ui_one]   = float(coords) * 0.5;
    arr[ui_two]   = float(coords) * 0.25;
    arr[ui_three] = float(coords) * 0.125;
    mediump float res = float(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    arr[ui_zero]  = float(coords);
    arr[ui_one]   = float(coords) * 0.5;
    arr[ui_two]   = float(coords) * 0.25;
    arr[ui_three] = float(coords) * 0.125;
    mediump float res = float(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    arr[ui_zero]  = float(coords);
    arr[ui_one]   = float(coords) * 0.5;
    arr[ui_two]   = float(coords) * 0.25;
    arr[ui_three] = float(coords) * 0.125;
    mediump float res = float(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    arr[ui_zero]  = float(coords);
    arr[ui_one]   = float(coords) * 0.5;
    arr[ui_two]   = float(coords) * 0.25;
    arr[ui_three] = float(coords) * 0.125;
    mediump float res = float(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    arr[ui_zero]  = float(coords);
    arr[ui_one]   = float(coords) * 0.5;
    arr[ui_two]   = float(coords) * 0.25;
    arr[ui_three] = float(coords) * 0.125;
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    arr[ui_zero]  = float(coords);
    arr[ui_one]   = float(coords) * 0.5;
    arr[ui_two]   = float(coords) * 0.25;
    arr[ui_three] = float(coords) * 0.125;
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    arr[ui_zero]  = float(coords);
    arr[ui_one]   = float(coords) * 0.5;
    arr[ui_two]   = float(coords) * 0.25;
    arr[ui_three] = float(coords) * 0.125;
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    arr[ui_zero]  = float(coords);
    arr[ui_one]   = float(coords) * 0.5;
    arr[ui_two]   = float(coords) * 0.25;
    arr[ui_three] = float(coords) * 0.125;
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[40];
    arr[0] = float(0.125);
    arr[1] = float(0.125) * 0.5;
    arr[2] = float(0.125) * 0.25;
    arr[3] = float(0.125) * 0.125;
    int i = 4;
    arr[i++] = float(4.0);
    arr[i++] = float(5.0);
    arr[i++] = float(6.0);
    arr[i++] = float(7.0);
    arr[i++] = float(8.0);
    arr[i++] = float(9.0);
    arr[i++] = float(10.0);
    arr[i++] = float(11.0);
    arr[i++] = float(12.0);
    arr[i++] = float(13.0);
    arr[i++] = float(14.0);
    arr[i++] = float(15.0);
    arr[i++] = float(16.0);
    arr[i++] = float(17.0);
    arr[i++] = float(18.0);
    arr[i++] = float(19.0);
    arr[i++] = float(20.0);
    arr[i++] = float(21.0);
    arr[i++] = float(22.0);
    arr[i++] = float(23.0);
    arr[i++] = float(24.0);
    arr[i++] = float(25.0);
    arr[i++] = float(26.0);
    arr[i++] = float(27.0);
    arr[i++] = float(28.0);
    arr[i++] = float(29.0);
    arr[i++] = float(30.0);
    arr[i++] = float(31.0);
    arr[i++] = float(32.0);
    arr[i++] = float(33.0);
    arr[i++] = float(34.0);
    arr[i++] = float(35.0);
    arr[i++] = float(36.0);
    arr[i++] = float(37.0);
    arr[i++] = float(38.0);
    arr[i++] = float(39.0);
    mediump float res = float(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_coords;

void main()
{
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump float arr[40];
    arr[0] = float(0.125);
    arr[1] = float(0.125) * 0.5;
    arr[2] = float(0.125) * 0.25;
    arr[3] = float(0.125) * 0.125;
    int i = 4;
    arr[i++] = float(4.0);
    arr[i++] = float(5.0);
    arr[i++] = float(6.0);
    arr[i++] = float(7.0);
    arr[i++] = float(8.0);
    arr[i++] = float(9.0);
    arr[i++] = float(10.0);
    arr[i++] = float(11.0);
    arr[i++] = float(12.0);
    arr[i++] = float(13.0);
    arr[i++] = float(14.0);
    arr[i++] = float(15.0);
    arr[i++] = float(16.0);
    arr[i++] = float(17.0);
    arr[i++] = float(18.0);
    arr[i++] = float(19.0);
    arr[i++] = float(20.0);
    arr[i++] = float(21.0);
    arr[i++] = float(22.0);
    arr[i++] = float(23.0);
    arr[i++] = float(24.0);
    arr[i++] = float(25.0);
    arr[i++] = float(26.0);
    arr[i++] = float(27.0);
    arr[i++] = float(28.0);
    arr[i++] = float(29.0);
    arr[i++] = float(30.0);
    arr[i++] = float(31.0);
    arr[i++] = float(32.0);
    arr[i++] = float(33.0);
    arr[i++] = float(34.0);
    arr[i++] = float(35.0);
    arr[i++] = float(36.0);
    arr[i++] = float(37.0);
    arr[i++] = float(38.0);
    arr[i++] = float(39.0);
    mediump float res = float(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[40];
    arr[0] = float(0.125);
    arr[1] = float(0.125) * 0.5;
    arr[2] = float(0.125) * 0.25;
    arr[3] = float(0.125) * 0.125;
    int i = 4;
    arr[i++] = float(4.0);
    arr[i++] = float(5.0);
    arr[i++] = float(6.0);
    arr[i++] = float(7.0);
    arr[i++] = float(8.0);
    arr[i++] = float(9.0);
    arr[i++] = float(10.0);
    arr[i++] = float(11.0);
    arr[i++] = float(12.0);
    arr[i++] = float(13.0);
    arr[i++] = float(14.0);
    arr[i++] = float(15.0);
    arr[i++] = float(16.0);
    arr[i++] = float(17.0);
    arr[i++] = float(18.0);
    arr[i++] = float(19.0);
    arr[i++] = float(20.0);
    arr[i++] = float(21.0);
    arr[i++] = float(22.0);
    arr[i++] = float(23.0);
    arr[i++] = float(24.0);
    arr[i++] = float(25.0);
    arr[i++] = float(26.0);
    arr[i++] = float(27.0);
    arr[i++] = float(28.0);
    arr[i++] = float(29.0);
    arr[i++] = float(30.0);
    arr[i++] = float(31.0);
    arr[i++] = float(32.0);
    arr[i++] = float(33.0);
    arr[i++] = float(34.0);
    arr[i++] = float(35.0);
    arr[i++] = float(36.0);
    arr[i++] = float(37.0);
    arr[i++] = float(38.0);
    arr[i++] = float(39.0);
    mediump float res = float(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump float arr[40];
    arr[0] = float(0.125);
    arr[1] = float(0.125) * 0.5;
    arr[2] = float(0.125) * 0.25;
    arr[3] = float(0.125) * 0.125;
    int i = 4;
    arr[i++] = float(4.0);
    arr[i++] = float(5.0);
    arr[i++] = float(6.0);
    arr[i++] = float(7.0);
    arr[i++] = float(8.0);
    arr[i++] = float(9.0);
    arr[i++] = float(10.0);
    arr[i++] = float(11.0);
    arr[i++] = float(12.0);
    arr[i++] = float(13.0);
    arr[i++] = float(14.0);
    arr[i++] = float(15.0);
    arr[i++] = float(16.0);
    arr[i++] = float(17.0);
    arr[i++] = float(18.0);
    arr[i++] = float(19.0);
    arr[i++] = float(20.0);
    arr[i++] = float(21.0);
    arr[i++] = float(22.0);
    arr[i++] = float(23.0);
    arr[i++] = float(24.0);
    arr[i++] = float(25.0);
    arr[i++] = float(26.0);
    arr[i++] = float(27.0);
    arr[i++] = float(28.0);
    arr[i++] = float(29.0);
    arr[i++] = float(30.0);
    arr[i++] = float(31.0);
    arr[i++] = float(32.0);
    arr[i++] = float(33.0);
    arr[i++] = float(34.0);
    arr[i++] = float(35.0);
    arr[i++] = float(36.0);
    arr[i++] = float(37.0);
    arr[i++] = float(38.0);
    arr[i++] = float(39.0);
    mediump float res = float(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[40];
    arr[0] = float(0.125);
    arr[1] = float(0.125) * 0.5;
    arr[2] = float(0.125) * 0.25;
    arr[3] = float(0.125) * 0.125;
    int i = 4;
    arr[i++] = float(4.0);
    arr[i++] = float(5.0);
    arr[i++] = float(6.0);
    arr[i++] = float(7.0);
    arr[i++] = float(8.0);
    arr[i++] = float(9.0);
    arr[i++] = float(10.0);
    arr[i++] = float(11.0);
    arr[i++] = float(12.0);
    arr[i++] = float(13.0);
    arr[i++] = float(14.0);
    arr[i++] = float(15.0);
    arr[i++] = float(16.0);
    arr[i++] = float(17.0);
    arr[i++] = float(18.0);
    arr[i++] = float(19.0);
    arr[i++] = float(20.0);
    arr[i++] = float(21.0);
    arr[i++] = float(22.0);
    arr[i++] = float(23.0);
    arr[i++] = float(24.0);
    arr[i++] = float(25.0);
    arr[i++] = float(26.0);
    arr[i++] = float(27.0);
    arr[i++] = float(28.0);
    arr[i++] = float(29.0);
    arr[i++] = float(30.0);
    arr[i++] = float(31.0);
    arr[i++] = float(32.0);
    arr[i++] = float(33.0);
    arr[i++] = float(34.0);
    arr[i++] = float(35.0);
    arr[i++] = float(36.0);
    arr[i++] = float(37.0);
    arr[i++] = float(38.0);
    arr[i++] = float(39.0);
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump float arr[40];
    arr[0] = float(0.125);
    arr[1] = float(0.125) * 0.5;
    arr[2] = float(0.125) * 0.25;
    arr[3] = float(0.125) * 0.125;
    int i = 4;
    arr[i++] = float(4.0);
    arr[i++] = float(5.0);
    arr[i++] = float(6.0);
    arr[i++] = float(7.0);
    arr[i++] = float(8.0);
    arr[i++] = float(9.0);
    arr[i++] = float(10.0);
    arr[i++] = float(11.0);
    arr[i++] = float(12.0);
    arr[i++] = float(13.0);
    arr[i++] = float(14.0);
    arr[i++] = float(15.0);
    arr[i++] = float(16.0);
    arr[i++] = float(17.0);
    arr[i++] = float(18.0);
    arr[i++] = float(19.0);
    arr[i++] = float(20.0);
    arr[i++] = float(21.0);
    arr[i++] = float(22.0);
    arr[i++] = float(23.0);
    arr[i++] = float(24.0);
    arr[i++] = float(25.0);
    arr[i++] = float(26.0);
    arr[i++] = float(27.0);
    arr[i++] = float(28.0);
    arr[i++] = float(29.0);
    arr[i++] = float(30.0);
    arr[i++] = float(31.0);
    arr[i++] = float(32.0);
    arr[i++] = float(33.0);
    arr[i++] = float(34.0);
    arr[i++] = float(35.0);
    arr[i++] = float(36.0);
    arr[i++] = float(37.0);
    arr[i++] = float(38.0);
    arr[i++] = float(39.0);
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[40];
    arr[0] = float(0.125);
    arr[1] = float(0.125) * 0.5;
    arr[2] = float(0.125) * 0.25;
    arr[3] = float(0.125) * 0.125;
    int i = 4;
    arr[i++] = float(4.0);
    arr[i++] = float(5.0);
    arr[i++] = float(6.0);
    arr[i++] = float(7.0);
    arr[i++] = float(8.0);
    arr[i++] = float(9.0);
    arr[i++] = float(10.0);
    arr[i++] = float(11.0);
    arr[i++] = float(12.0);
    arr[i++] = float(13.0);
    arr[i++] = float(14.0);
    arr[i++] = float(15.0);
    arr[i++] = float(16.0);
    arr[i++] = float(17.0);
    arr[i++] = float(18.0);
    arr[i++] = float(19.0);
    arr[i++] = float(20.0);
    arr[i++] = float(21.0);
    arr[i++] = float(22.0);
    arr[i++] = float(23.0);
    arr[i++] = float(24.0);
    arr[i++] = float(25.0);
    arr[i++] = float(26.0);
    arr[i++] = float(27.0);
    arr[i++] = float(28.0);
    arr[i++] = float(29.0);
    arr[i++] = float(30.0);
    arr[i++] = float(31.0);
    arr[i++] = float(32.0);
    arr[i++] = float(33.0);
    arr[i++] = float(34.0);
    arr[i++] = float(35.0);
    arr[i++] = float(36.0);
    arr[i++] = float(37.0);
    arr[i++] = float(38.0);
    arr[i++] = float(39.0);
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump float arr[40];
    arr[0] = float(0.125);
    arr[1] = float(0.125) * 0.5;
    arr[2] = float(0.125) * 0.25;
    arr[3] = float(0.125) * 0.125;
    int i = 4;
    arr[i++] = float(4.0);
    arr[i++] = float(5.0);
    arr[i++] = float(6.0);
    arr[i++] = float(7.0);
    arr[i++] = float(8.0);
    arr[i++] = float(9.0);
    arr[i++] = float(10.0);
    arr[i++] = float(11.0);
    arr[i++] = float(12.0);
    arr[i++] = float(13.0);
    arr[i++] = float(14.0);
    arr[i++] = float(15.0);
    arr[i++] = float(16.0);
    arr[i++] = float(17.0);
    arr[i++] = float(18.0);
    arr[i++] = float(19.0);
    arr[i++] = float(20.0);
    arr[i++] = float(21.0);
    arr[i++] = float(22.0);
    arr[i++] = float(23.0);
    arr[i++] = float(24.0);
    arr[i++] = float(25.0);
    arr[i++] = float(26.0);
    arr[i++] = float(27.0);
    arr[i++] = float(28.0);
    arr[i++] = float(29.0);
    arr[i++] = float(30.0);
    arr[i++] = float(31.0);
    arr[i++] = float(32.0);
    arr[i++] = float(33.0);
    arr[i++] = float(34.0);
    arr[i++] = float(35.0);
    arr[i++] = float(36.0);
    arr[i++] = float(37.0);
    arr[i++] = float(38.0);
    arr[i++] = float(39.0);
    mediump float res = float(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    arr[0] = vec2(coords);
    arr[1] = vec2(coords) * 0.5;
    arr[2] = vec2(coords) * 0.25;
    arr[3] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    arr[0] = vec2(coords);
    arr[1] = vec2(coords) * 0.5;
    arr[2] = vec2(coords) * 0.25;
    arr[3] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    arr[0] = vec2(coords);
    arr[1] = vec2(coords) * 0.5;
    arr[2] = vec2(coords) * 0.25;
    arr[3] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    arr[0] = vec2(coords);
    arr[1] = vec2(coords) * 0.5;
    arr[2] = vec2(coords) * 0.25;
    arr[3] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    arr[0] = vec2(coords);
    arr[1] = vec2(coords) * 0.5;
    arr[2] = vec2(coords) * 0.25;
    arr[3] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    arr[0] = vec2(coords);
    arr[1] = vec2(coords) * 0.5;
    arr[2] = vec2(coords) * 0.25;
    arr[3] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    arr[0] = vec2(coords);
    arr[1] = vec2(coords) * 0.5;
    arr[2] = vec2(coords) * 0.25;
    arr[3] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    arr[0] = vec2(coords);
    arr[1] = vec2(coords) * 0.5;
    arr[2] = vec2(coords) * 0.25;
    arr[3] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    arr[ui_zero]  = vec2(coords);
    arr[ui_one]   = vec2(coords) * 0.5;
    arr[ui_two]   = vec2(coords) * 0.25;
    arr[ui_three] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    arr[ui_zero]  = vec2(coords);
    arr[ui_one]   = vec2(coords) * 0.5;
    arr[ui_two]   = vec2(coords) * 0.25;
    arr[ui_three] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    arr[ui_zero]  = vec2(coords);
    arr[ui_one]   = vec2(coords) * 0.5;
    arr[ui_two]   = vec2(coords) * 0.25;
    arr[ui_three] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    arr[ui_zero]  = vec2(coords);
    arr[ui_one]   = vec2(coords) * 0.5;
    arr[ui_two]   = vec2(coords) * 0.25;
    arr[ui_three] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    arr[ui_zero]  = vec2(coords);
    arr[ui_one]   = vec2(coords) * 0.5;
    arr[ui_two]   = vec2(coords) * 0.25;
    arr[ui_three] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    arr[ui_zero]  = vec2(coords);
    arr[ui_one]   = vec2(coords) * 0.5;
    arr[ui_two]   = vec2(coords) * 0.25;
    arr[ui_three] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    arr[ui_zero]  = vec2(coords);
    arr[ui_one]   = vec2(coords) * 0.5;
    arr[ui_two]   = vec2(coords) * 0.25;
    arr[ui_three] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    arr[ui_zero]  = vec2(coords);
    arr[ui_one]   = vec2(coords) * 0.5;
    arr[ui_two]   = vec2(coords) * 0.25;
    arr[ui_three] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[40];
    arr[0] = vec2(0.125, 0.25);
    arr[1] = vec2(0.125, 0.25) * 0.5;
    arr[2] = vec2(0.125, 0.25) * 0.25;
    arr[3] = vec2(0.125, 0.25) * 0.125;
    int i = 4;
    arr[i++] = vec2(4.0);
    arr[i++] = vec2(5.0);
    arr[i++] = vec2(6.0);
    arr[i++] = vec2(7.0);
    arr[i++] = vec2(8.0);
    arr[i++] = vec2(9.0);
    arr[i++] = vec2(10.0);
    arr[i++] = vec2(11.0);
    arr[i++] = vec2(12.0);
    arr[i++] = vec2(13.0);
    arr[i++] = vec2(14.0);
    arr[i++] = vec2(15.0);
    arr[i++] = vec2(16.0);
    arr[i++] = vec2(17.0);
    arr[i++] = vec2(18.0);
    arr[i++] = vec2(19.0);
    arr[i++] = vec2(20.0);
    arr[i++] = vec2(21.0);
    arr[i++] = vec2(22.0);
    arr[i++] = vec2(23.0);
    arr[i++] = vec2(24.0);
    arr[i++] = vec2(25.0);
    arr[i++] = vec2(26.0);
    arr[i++] = vec2(27.0);
    arr[i++] = vec2(28.0);
    arr[i++] = vec2(29.0);
    arr[i++] = vec2(30.0);
    arr[i++] = vec2(31.0);
    arr[i++] = vec2(32.0);
    arr[i++] = vec2(33.0);
    arr[i++] = vec2(34.0);
    arr[i++] = vec2(35.0);
    arr[i++] = vec2(36.0);
    arr[i++] = vec2(37.0);
    arr[i++] = vec2(38.0);
    arr[i++] = vec2(39.0);
    mediump vec2 res = vec2(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 arr[40];
    arr[0] = vec2(0.125, 0.25);
    arr[1] = vec2(0.125, 0.25) * 0.5;
    arr[2] = vec2(0.125, 0.25) * 0.25;
    arr[3] = vec2(0.125, 0.25) * 0.125;
    int i = 4;
    arr[i++] = vec2(4.0);
    arr[i++] = vec2(5.0);
    arr[i++] = vec2(6.0);
    arr[i++] = vec2(7.0);
    arr[i++] = vec2(8.0);
    arr[i++] = vec2(9.0);
    arr[i++] = vec2(10.0);
    arr[i++] = vec2(11.0);
    arr[i++] = vec2(12.0);
    arr[i++] = vec2(13.0);
    arr[i++] = vec2(14.0);
    arr[i++] = vec2(15.0);
    arr[i++] = vec2(16.0);
    arr[i++] = vec2(17.0);
    arr[i++] = vec2(18.0);
    arr[i++] = vec2(19.0);
    arr[i++] = vec2(20.0);
    arr[i++] = vec2(21.0);
    arr[i++] = vec2(22.0);
    arr[i++] = vec2(23.0);
    arr[i++] = vec2(24.0);
    arr[i++] = vec2(25.0);
    arr[i++] = vec2(26.0);
    arr[i++] = vec2(27.0);
    arr[i++] = vec2(28.0);
    arr[i++] = vec2(29.0);
    arr[i++] = vec2(30.0);
    arr[i++] = vec2(31.0);
    arr[i++] = vec2(32.0);
    arr[i++] = vec2(33.0);
    arr[i++] = vec2(34.0);
    arr[i++] = vec2(35.0);
    arr[i++] = vec2(36.0);
    arr[i++] = vec2(37.0);
    arr[i++] = vec2(38.0);
    arr[i++] = vec2(39.0);
    mediump vec2 res = vec2(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[40];
    arr[0] = vec2(0.125, 0.25);
    arr[1] = vec2(0.125, 0.25) * 0.5;
    arr[2] = vec2(0.125, 0.25) * 0.25;
    arr[3] = vec2(0.125, 0.25) * 0.125;
    int i = 4;
    arr[i++] = vec2(4.0);
    arr[i++] = vec2(5.0);
    arr[i++] = vec2(6.0);
    arr[i++] = vec2(7.0);
    arr[i++] = vec2(8.0);
    arr[i++] = vec2(9.0);
    arr[i++] = vec2(10.0);
    arr[i++] = vec2(11.0);
    arr[i++] = vec2(12.0);
    arr[i++] = vec2(13.0);
    arr[i++] = vec2(14.0);
    arr[i++] = vec2(15.0);
    arr[i++] = vec2(16.0);
    arr[i++] = vec2(17.0);
    arr[i++] = vec2(18.0);
    arr[i++] = vec2(19.0);
    arr[i++] = vec2(20.0);
    arr[i++] = vec2(21.0);
    arr[i++] = vec2(22.0);
    arr[i++] = vec2(23.0);
    arr[i++] = vec2(24.0);
    arr[i++] = vec2(25.0);
    arr[i++] = vec2(26.0);
    arr[i++] = vec2(27.0);
    arr[i++] = vec2(28.0);
    arr[i++] = vec2(29.0);
    arr[i++] = vec2(30.0);
    arr[i++] = vec2(31.0);
    arr[i++] = vec2(32.0);
    arr[i++] = vec2(33.0);
    arr[i++] = vec2(34.0);
    arr[i++] = vec2(35.0);
    arr[i++] = vec2(36.0);
    arr[i++] = vec2(37.0);
    arr[i++] = vec2(38.0);
    arr[i++] = vec2(39.0);
    mediump vec2 res = vec2(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec2 arr[40];
    arr[0] = vec2(0.125, 0.25);
    arr[1] = vec2(0.125, 0.25) * 0.5;
    arr[2] = vec2(0.125, 0.25) * 0.25;
    arr[3] = vec2(0.125, 0.25) * 0.125;
    int i = 4;
    arr[i++] = vec2(4.0);
    arr[i++] = vec2(5.0);
    arr[i++] = vec2(6.0);
    arr[i++] = vec2(7.0);
    arr[i++] = vec2(8.0);
    arr[i++] = vec2(9.0);
    arr[i++] = vec2(10.0);
    arr[i++] = vec2(11.0);
    arr[i++] = vec2(12.0);
    arr[i++] = vec2(13.0);
    arr[i++] = vec2(14.0);
    arr[i++] = vec2(15.0);
    arr[i++] = vec2(16.0);
    arr[i++] = vec2(17.0);
    arr[i++] = vec2(18.0);
    arr[i++] = vec2(19.0);
    arr[i++] = vec2(20.0);
    arr[i++] = vec2(21.0);
    arr[i++] = vec2(22.0);
    arr[i++] = vec2(23.0);
    arr[i++] = vec2(24.0);
    arr[i++] = vec2(25.0);
    arr[i++] = vec2(26.0);
    arr[i++] = vec2(27.0);
    arr[i++] = vec2(28.0);
    arr[i++] = vec2(29.0);
    arr[i++] = vec2(30.0);
    arr[i++] = vec2(31.0);
    arr[i++] = vec2(32.0);
    arr[i++] = vec2(33.0);
    arr[i++] = vec2(34.0);
    arr[i++] = vec2(35.0);
    arr[i++] = vec2(36.0);
    arr[i++] = vec2(37.0);
    arr[i++] = vec2(38.0);
    arr[i++] = vec2(39.0);
    mediump vec2 res = vec2(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[40];
    arr[0] = vec2(0.125, 0.25);
    arr[1] = vec2(0.125, 0.25) * 0.5;
    arr[2] = vec2(0.125, 0.25) * 0.25;
    arr[3] = vec2(0.125, 0.25) * 0.125;
    int i = 4;
    arr[i++] = vec2(4.0);
    arr[i++] = vec2(5.0);
    arr[i++] = vec2(6.0);
    arr[i++] = vec2(7.0);
    arr[i++] = vec2(8.0);
    arr[i++] = vec2(9.0);
    arr[i++] = vec2(10.0);
    arr[i++] = vec2(11.0);
    arr[i++] = vec2(12.0);
    arr[i++] = vec2(13.0);
    arr[i++] = vec2(14.0);
    arr[i++] = vec2(15.0);
    arr[i++] = vec2(16.0);
    arr[i++] = vec2(17.0);
    arr[i++] = vec2(18.0);
    arr[i++] = vec2(19.0);
    arr[i++] = vec2(20.0);
    arr[i++] = vec2(21.0);
    arr[i++] = vec2(22.0);
    arr[i++] = vec2(23.0);
    arr[i++] = vec2(24.0);
    arr[i++] = vec2(25.0);
    arr[i++] = vec2(26.0);
    arr[i++] = vec2(27.0);
    arr[i++] = vec2(28.0);
    arr[i++] = vec2(29.0);
    arr[i++] = vec2(30.0);
    arr[i++] = vec2(31.0);
    arr[i++] = vec2(32.0);
    arr[i++] = vec2(33.0);
    arr[i++] = vec2(34.0);
    arr[i++] = vec2(35.0);
    arr[i++] = vec2(36.0);
    arr[i++] = vec2(37.0);
    arr[i++] = vec2(38.0);
    arr[i++] = vec2(39.0);
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 arr[40];
    arr[0] = vec2(0.125, 0.25);
    arr[1] = vec2(0.125, 0.25) * 0.5;
    arr[2] = vec2(0.125, 0.25) * 0.25;
    arr[3] = vec2(0.125, 0.25) * 0.125;
    int i = 4;
    arr[i++] = vec2(4.0);
    arr[i++] = vec2(5.0);
    arr[i++] = vec2(6.0);
    arr[i++] = vec2(7.0);
    arr[i++] = vec2(8.0);
    arr[i++] = vec2(9.0);
    arr[i++] = vec2(10.0);
    arr[i++] = vec2(11.0);
    arr[i++] = vec2(12.0);
    arr[i++] = vec2(13.0);
    arr[i++] = vec2(14.0);
    arr[i++] = vec2(15.0);
    arr[i++] = vec2(16.0);
    arr[i++] = vec2(17.0);
    arr[i++] = vec2(18.0);
    arr[i++] = vec2(19.0);
    arr[i++] = vec2(20.0);
    arr[i++] = vec2(21.0);
    arr[i++] = vec2(22.0);
    arr[i++] = vec2(23.0);
    arr[i++] = vec2(24.0);
    arr[i++] = vec2(25.0);
    arr[i++] = vec2(26.0);
    arr[i++] = vec2(27.0);
    arr[i++] = vec2(28.0);
    arr[i++] = vec2(29.0);
    arr[i++] = vec2(30.0);
    arr[i++] = vec2(31.0);
    arr[i++] = vec2(32.0);
    arr[i++] = vec2(33.0);
    arr[i++] = vec2(34.0);
    arr[i++] = vec2(35.0);
    arr[i++] = vec2(36.0);
    arr[i++] = vec2(37.0);
    arr[i++] = vec2(38.0);
    arr[i++] = vec2(39.0);
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[40];
    arr[0] = vec2(0.125, 0.25);
    arr[1] = vec2(0.125, 0.25) * 0.5;
    arr[2] = vec2(0.125, 0.25) * 0.25;
    arr[3] = vec2(0.125, 0.25) * 0.125;
    int i = 4;
    arr[i++] = vec2(4.0);
    arr[i++] = vec2(5.0);
    arr[i++] = vec2(6.0);
    arr[i++] = vec2(7.0);
    arr[i++] = vec2(8.0);
    arr[i++] = vec2(9.0);
    arr[i++] = vec2(10.0);
    arr[i++] = vec2(11.0);
    arr[i++] = vec2(12.0);
    arr[i++] = vec2(13.0);
    arr[i++] = vec2(14.0);
    arr[i++] = vec2(15.0);
    arr[i++] = vec2(16.0);
    arr[i++] = vec2(17.0);
    arr[i++] = vec2(18.0);
    arr[i++] = vec2(19.0);
    arr[i++] = vec2(20.0);
    arr[i++] = vec2(21.0);
    arr[i++] = vec2(22.0);
    arr[i++] = vec2(23.0);
    arr[i++] = vec2(24.0);
    arr[i++] = vec2(25.0);
    arr[i++] = vec2(26.0);
    arr[i++] = vec2(27.0);
    arr[i++] = vec2(28.0);
    arr[i++] = vec2(29.0);
    arr[i++] = vec2(30.0);
    arr[i++] = vec2(31.0);
    arr[i++] = vec2(32.0);
    arr[i++] = vec2(33.0);
    arr[i++] = vec2(34.0);
    arr[i++] = vec2(35.0);
    arr[i++] = vec2(36.0);
    arr[i++] = vec2(37.0);
    arr[i++] = vec2(38.0);
    arr[i++] = vec2(39.0);
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec2 arr[40];
    arr[0] = vec2(0.125, 0.25);
    arr[1] = vec2(0.125, 0.25) * 0.5;
    arr[2] = vec2(0.125, 0.25) * 0.25;
    arr[3] = vec2(0.125, 0.25) * 0.125;
    int i = 4;
    arr[i++] = vec2(4.0);
    arr[i++] = vec2(5.0);
    arr[i++] = vec2(6.0);
    arr[i++] = vec2(7.0);
    arr[i++] = vec2(8.0);
    arr[i++] = vec2(9.0);
    arr[i++] = vec2(10.0);
    arr[i++] = vec2(11.0);
    arr[i++] = vec2(12.0);
    arr[i++] = vec2(13.0);
    arr[i++] = vec2(14.0);
    arr[i++] = vec2(15.0);
    arr[i++] = vec2(16.0);
    arr[i++] = vec2(17.0);
    arr[i++] = vec2(18.0);
    arr[i++] = vec2(19.0);
    arr[i++] = vec2(20.0);
    arr[i++] = vec2(21.0);
    arr[i++] = vec2(22.0);
    arr[i++] = vec2(23.0);
    arr[i++] = vec2(24.0);
    arr[i++] = vec2(25.0);
    arr[i++] = vec2(26.0);
    arr[i++] = vec2(27.0);
    arr[i++] = vec2(28.0);
    arr[i++] = vec2(29.0);
    arr[i++] = vec2(30.0);
    arr[i++] = vec2(31.0);
    arr[i++] = vec2(32.0);
    arr[i++] = vec2(33.0);
    arr[i++] = vec2(34.0);
    arr[i++] = vec2(35.0);
    arr[i++] = vec2(36.0);
    arr[i++] = vec2(37.0);
    arr[i++] = vec2(38.0);
    arr[i++] = vec2(39.0);
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    arr[0] = vec3(coords);
    arr[1] = vec3(coords) * 0.5;
    arr[2] = vec3(coords) * 0.25;
    arr[3] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    arr[0] = vec3(coords);
    arr[1] = vec3(coords) * 0.5;
    arr[2] = vec3(coords) * 0.25;
    arr[3] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    arr[0] = vec3(coords);
    arr[1] = vec3(coords) * 0.5;
    arr[2] = vec3(coords) * 0.25;
    arr[3] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    arr[0] = vec3(coords);
    arr[1] = vec3(coords) * 0.5;
    arr[2] = vec3(coords) * 0.25;
    arr[3] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    arr[0] = vec3(coords);
    arr[1] = vec3(coords) * 0.5;
    arr[2] = vec3(coords) * 0.25;
    arr[3] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    arr[0] = vec3(coords);
    arr[1] = vec3(coords) * 0.5;
    arr[2] = vec3(coords) * 0.25;
    arr[3] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    arr[0] = vec3(coords);
    arr[1] = vec3(coords) * 0.5;
    arr[2] = vec3(coords) * 0.25;
    arr[3] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    arr[0] = vec3(coords);
    arr[1] = vec3(coords) * 0.5;
    arr[2] = vec3(coords) * 0.25;
    arr[3] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    arr[ui_zero]  = vec3(coords);
    arr[ui_one]   = vec3(coords) * 0.5;
    arr[ui_two]   = vec3(coords) * 0.25;
    arr[ui_three] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    arr[ui_zero]  = vec3(coords);
    arr[ui_one]   = vec3(coords) * 0.5;
    arr[ui_two]   = vec3(coords) * 0.25;
    arr[ui_three] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    arr[ui_zero]  = vec3(coords);
    arr[ui_one]   = vec3(coords) * 0.5;
    arr[ui_two]   = vec3(coords) * 0.25;
    arr[ui_three] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    arr[ui_zero]  = vec3(coords);
    arr[ui_one]   = vec3(coords) * 0.5;
    arr[ui_two]   = vec3(coords) * 0.25;
    arr[ui_three] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    arr[ui_zero]  = vec3(coords);
    arr[ui_one]   = vec3(coords) * 0.5;
    arr[ui_two]   = vec3(coords) * 0.25;
    arr[ui_three] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    arr[ui_zero]  = vec3(coords);
    arr[ui_one]   = vec3(coords) * 0.5;
    arr[ui_two]   = vec3(coords) * 0.25;
    arr[ui_three] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    arr[ui_zero]  = vec3(coords);
    arr[ui_one]   = vec3(coords) * 0.5;
    arr[ui_two]   = vec3(coords) * 0.25;
    arr[ui_three] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    arr[ui_zero]  = vec3(coords);
    arr[ui_one]   = vec3(coords) * 0.5;
    arr[ui_two]   = vec3(coords) * 0.25;
    arr[ui_three] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 1.0);
}
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
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
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
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 1.0);
}
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
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 1.0);
}
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
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[40];
    arr[0] = vec3(0.125, 0.25, 0.5);
    arr[1] = vec3(0.125, 0.25, 0.5) * 0.5;
    arr[2] = vec3(0.125, 0.25, 0.5) * 0.25;
    arr[3] = vec3(0.125, 0.25, 0.5) * 0.125;
    int i = 4;
    arr[i++] = vec3(4.0);
    arr[i++] = vec3(5.0);
    arr[i++] = vec3(6.0);
    arr[i++] = vec3(7.0);
    arr[i++] = vec3(8.0);
    arr[i++] = vec3(9.0);
    arr[i++] = vec3(10.0);
    arr[i++] = vec3(11.0);
    arr[i++] = vec3(12.0);
    arr[i++] = vec3(13.0);
    arr[i++] = vec3(14.0);
    arr[i++] = vec3(15.0);
    arr[i++] = vec3(16.0);
    arr[i++] = vec3(17.0);
    arr[i++] = vec3(18.0);
    arr[i++] = vec3(19.0);
    arr[i++] = vec3(20.0);
    arr[i++] = vec3(21.0);
    arr[i++] = vec3(22.0);
    arr[i++] = vec3(23.0);
    arr[i++] = vec3(24.0);
    arr[i++] = vec3(25.0);
    arr[i++] = vec3(26.0);
    arr[i++] = vec3(27.0);
    arr[i++] = vec3(28.0);
    arr[i++] = vec3(29.0);
    arr[i++] = vec3(30.0);
    arr[i++] = vec3(31.0);
    arr[i++] = vec3(32.0);
    arr[i++] = vec3(33.0);
    arr[i++] = vec3(34.0);
    arr[i++] = vec3(35.0);
    arr[i++] = vec3(36.0);
    arr[i++] = vec3(37.0);
    arr[i++] = vec3(38.0);
    arr[i++] = vec3(39.0);
    mediump vec3 res = vec3(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 arr[40];
    arr[0] = vec3(0.125, 0.25, 0.5);
    arr[1] = vec3(0.125, 0.25, 0.5) * 0.5;
    arr[2] = vec3(0.125, 0.25, 0.5) * 0.25;
    arr[3] = vec3(0.125, 0.25, 0.5) * 0.125;
    int i = 4;
    arr[i++] = vec3(4.0);
    arr[i++] = vec3(5.0);
    arr[i++] = vec3(6.0);
    arr[i++] = vec3(7.0);
    arr[i++] = vec3(8.0);
    arr[i++] = vec3(9.0);
    arr[i++] = vec3(10.0);
    arr[i++] = vec3(11.0);
    arr[i++] = vec3(12.0);
    arr[i++] = vec3(13.0);
    arr[i++] = vec3(14.0);
    arr[i++] = vec3(15.0);
    arr[i++] = vec3(16.0);
    arr[i++] = vec3(17.0);
    arr[i++] = vec3(18.0);
    arr[i++] = vec3(19.0);
    arr[i++] = vec3(20.0);
    arr[i++] = vec3(21.0);
    arr[i++] = vec3(22.0);
    arr[i++] = vec3(23.0);
    arr[i++] = vec3(24.0);
    arr[i++] = vec3(25.0);
    arr[i++] = vec3(26.0);
    arr[i++] = vec3(27.0);
    arr[i++] = vec3(28.0);
    arr[i++] = vec3(29.0);
    arr[i++] = vec3(30.0);
    arr[i++] = vec3(31.0);
    arr[i++] = vec3(32.0);
    arr[i++] = vec3(33.0);
    arr[i++] = vec3(34.0);
    arr[i++] = vec3(35.0);
    arr[i++] = vec3(36.0);
    arr[i++] = vec3(37.0);
    arr[i++] = vec3(38.0);
    arr[i++] = vec3(39.0);
    mediump vec3 res = vec3(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[40];
    arr[0] = vec3(0.125, 0.25, 0.5);
    arr[1] = vec3(0.125, 0.25, 0.5) * 0.5;
    arr[2] = vec3(0.125, 0.25, 0.5) * 0.25;
    arr[3] = vec3(0.125, 0.25, 0.5) * 0.125;
    int i = 4;
    arr[i++] = vec3(4.0);
    arr[i++] = vec3(5.0);
    arr[i++] = vec3(6.0);
    arr[i++] = vec3(7.0);
    arr[i++] = vec3(8.0);
    arr[i++] = vec3(9.0);
    arr[i++] = vec3(10.0);
    arr[i++] = vec3(11.0);
    arr[i++] = vec3(12.0);
    arr[i++] = vec3(13.0);
    arr[i++] = vec3(14.0);
    arr[i++] = vec3(15.0);
    arr[i++] = vec3(16.0);
    arr[i++] = vec3(17.0);
    arr[i++] = vec3(18.0);
    arr[i++] = vec3(19.0);
    arr[i++] = vec3(20.0);
    arr[i++] = vec3(21.0);
    arr[i++] = vec3(22.0);
    arr[i++] = vec3(23.0);
    arr[i++] = vec3(24.0);
    arr[i++] = vec3(25.0);
    arr[i++] = vec3(26.0);
    arr[i++] = vec3(27.0);
    arr[i++] = vec3(28.0);
    arr[i++] = vec3(29.0);
    arr[i++] = vec3(30.0);
    arr[i++] = vec3(31.0);
    arr[i++] = vec3(32.0);
    arr[i++] = vec3(33.0);
    arr[i++] = vec3(34.0);
    arr[i++] = vec3(35.0);
    arr[i++] = vec3(36.0);
    arr[i++] = vec3(37.0);
    arr[i++] = vec3(38.0);
    arr[i++] = vec3(39.0);
    mediump vec3 res = vec3(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 arr[40];
    arr[0] = vec3(0.125, 0.25, 0.5);
    arr[1] = vec3(0.125, 0.25, 0.5) * 0.5;
    arr[2] = vec3(0.125, 0.25, 0.5) * 0.25;
    arr[3] = vec3(0.125, 0.25, 0.5) * 0.125;
    int i = 4;
    arr[i++] = vec3(4.0);
    arr[i++] = vec3(5.0);
    arr[i++] = vec3(6.0);
    arr[i++] = vec3(7.0);
    arr[i++] = vec3(8.0);
    arr[i++] = vec3(9.0);
    arr[i++] = vec3(10.0);
    arr[i++] = vec3(11.0);
    arr[i++] = vec3(12.0);
    arr[i++] = vec3(13.0);
    arr[i++] = vec3(14.0);
    arr[i++] = vec3(15.0);
    arr[i++] = vec3(16.0);
    arr[i++] = vec3(17.0);
    arr[i++] = vec3(18.0);
    arr[i++] = vec3(19.0);
    arr[i++] = vec3(20.0);
    arr[i++] = vec3(21.0);
    arr[i++] = vec3(22.0);
    arr[i++] = vec3(23.0);
    arr[i++] = vec3(24.0);
    arr[i++] = vec3(25.0);
    arr[i++] = vec3(26.0);
    arr[i++] = vec3(27.0);
    arr[i++] = vec3(28.0);
    arr[i++] = vec3(29.0);
    arr[i++] = vec3(30.0);
    arr[i++] = vec3(31.0);
    arr[i++] = vec3(32.0);
    arr[i++] = vec3(33.0);
    arr[i++] = vec3(34.0);
    arr[i++] = vec3(35.0);
    arr[i++] = vec3(36.0);
    arr[i++] = vec3(37.0);
    arr[i++] = vec3(38.0);
    arr[i++] = vec3(39.0);
    mediump vec3 res = vec3(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[40];
    arr[0] = vec3(0.125, 0.25, 0.5);
    arr[1] = vec3(0.125, 0.25, 0.5) * 0.5;
    arr[2] = vec3(0.125, 0.25, 0.5) * 0.25;
    arr[3] = vec3(0.125, 0.25, 0.5) * 0.125;
    int i = 4;
    arr[i++] = vec3(4.0);
    arr[i++] = vec3(5.0);
    arr[i++] = vec3(6.0);
    arr[i++] = vec3(7.0);
    arr[i++] = vec3(8.0);
    arr[i++] = vec3(9.0);
    arr[i++] = vec3(10.0);
    arr[i++] = vec3(11.0);
    arr[i++] = vec3(12.0);
    arr[i++] = vec3(13.0);
    arr[i++] = vec3(14.0);
    arr[i++] = vec3(15.0);
    arr[i++] = vec3(16.0);
    arr[i++] = vec3(17.0);
    arr[i++] = vec3(18.0);
    arr[i++] = vec3(19.0);
    arr[i++] = vec3(20.0);
    arr[i++] = vec3(21.0);
    arr[i++] = vec3(22.0);
    arr[i++] = vec3(23.0);
    arr[i++] = vec3(24.0);
    arr[i++] = vec3(25.0);
    arr[i++] = vec3(26.0);
    arr[i++] = vec3(27.0);
    arr[i++] = vec3(28.0);
    arr[i++] = vec3(29.0);
    arr[i++] = vec3(30.0);
    arr[i++] = vec3(31.0);
    arr[i++] = vec3(32.0);
    arr[i++] = vec3(33.0);
    arr[i++] = vec3(34.0);
    arr[i++] = vec3(35.0);
    arr[i++] = vec3(36.0);
    arr[i++] = vec3(37.0);
    arr[i++] = vec3(38.0);
    arr[i++] = vec3(39.0);
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 arr[40];
    arr[0] = vec3(0.125, 0.25, 0.5);
    arr[1] = vec3(0.125, 0.25, 0.5) * 0.5;
    arr[2] = vec3(0.125, 0.25, 0.5) * 0.25;
    arr[3] = vec3(0.125, 0.25, 0.5) * 0.125;
    int i = 4;
    arr[i++] = vec3(4.0);
    arr[i++] = vec3(5.0);
    arr[i++] = vec3(6.0);
    arr[i++] = vec3(7.0);
    arr[i++] = vec3(8.0);
    arr[i++] = vec3(9.0);
    arr[i++] = vec3(10.0);
    arr[i++] = vec3(11.0);
    arr[i++] = vec3(12.0);
    arr[i++] = vec3(13.0);
    arr[i++] = vec3(14.0);
    arr[i++] = vec3(15.0);
    arr[i++] = vec3(16.0);
    arr[i++] = vec3(17.0);
    arr[i++] = vec3(18.0);
    arr[i++] = vec3(19.0);
    arr[i++] = vec3(20.0);
    arr[i++] = vec3(21.0);
    arr[i++] = vec3(22.0);
    arr[i++] = vec3(23.0);
    arr[i++] = vec3(24.0);
    arr[i++] = vec3(25.0);
    arr[i++] = vec3(26.0);
    arr[i++] = vec3(27.0);
    arr[i++] = vec3(28.0);
    arr[i++] = vec3(29.0);
    arr[i++] = vec3(30.0);
    arr[i++] = vec3(31.0);
    arr[i++] = vec3(32.0);
    arr[i++] = vec3(33.0);
    arr[i++] = vec3(34.0);
    arr[i++] = vec3(35.0);
    arr[i++] = vec3(36.0);
    arr[i++] = vec3(37.0);
    arr[i++] = vec3(38.0);
    arr[i++] = vec3(39.0);
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[40];
    arr[0] = vec3(0.125, 0.25, 0.5);
    arr[1] = vec3(0.125, 0.25, 0.5) * 0.5;
    arr[2] = vec3(0.125, 0.25, 0.5) * 0.25;
    arr[3] = vec3(0.125, 0.25, 0.5) * 0.125;
    int i = 4;
    arr[i++] = vec3(4.0);
    arr[i++] = vec3(5.0);
    arr[i++] = vec3(6.0);
    arr[i++] = vec3(7.0);
    arr[i++] = vec3(8.0);
    arr[i++] = vec3(9.0);
    arr[i++] = vec3(10.0);
    arr[i++] = vec3(11.0);
    arr[i++] = vec3(12.0);
    arr[i++] = vec3(13.0);
    arr[i++] = vec3(14.0);
    arr[i++] = vec3(15.0);
    arr[i++] = vec3(16.0);
    arr[i++] = vec3(17.0);
    arr[i++] = vec3(18.0);
    arr[i++] = vec3(19.0);
    arr[i++] = vec3(20.0);
    arr[i++] = vec3(21.0);
    arr[i++] = vec3(22.0);
    arr[i++] = vec3(23.0);
    arr[i++] = vec3(24.0);
    arr[i++] = vec3(25.0);
    arr[i++] = vec3(26.0);
    arr[i++] = vec3(27.0);
    arr[i++] = vec3(28.0);
    arr[i++] = vec3(29.0);
    arr[i++] = vec3(30.0);
    arr[i++] = vec3(31.0);
    arr[i++] = vec3(32.0);
    arr[i++] = vec3(33.0);
    arr[i++] = vec3(34.0);
    arr[i++] = vec3(35.0);
    arr[i++] = vec3(36.0);
    arr[i++] = vec3(37.0);
    arr[i++] = vec3(38.0);
    arr[i++] = vec3(39.0);
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec3 arr[40];
    arr[0] = vec3(0.125, 0.25, 0.5);
    arr[1] = vec3(0.125, 0.25, 0.5) * 0.5;
    arr[2] = vec3(0.125, 0.25, 0.5) * 0.25;
    arr[3] = vec3(0.125, 0.25, 0.5) * 0.125;
    int i = 4;
    arr[i++] = vec3(4.0);
    arr[i++] = vec3(5.0);
    arr[i++] = vec3(6.0);
    arr[i++] = vec3(7.0);
    arr[i++] = vec3(8.0);
    arr[i++] = vec3(9.0);
    arr[i++] = vec3(10.0);
    arr[i++] = vec3(11.0);
    arr[i++] = vec3(12.0);
    arr[i++] = vec3(13.0);
    arr[i++] = vec3(14.0);
    arr[i++] = vec3(15.0);
    arr[i++] = vec3(16.0);
    arr[i++] = vec3(17.0);
    arr[i++] = vec3(18.0);
    arr[i++] = vec3(19.0);
    arr[i++] = vec3(20.0);
    arr[i++] = vec3(21.0);
    arr[i++] = vec3(22.0);
    arr[i++] = vec3(23.0);
    arr[i++] = vec3(24.0);
    arr[i++] = vec3(25.0);
    arr[i++] = vec3(26.0);
    arr[i++] = vec3(27.0);
    arr[i++] = vec3(28.0);
    arr[i++] = vec3(29.0);
    arr[i++] = vec3(30.0);
    arr[i++] = vec3(31.0);
    arr[i++] = vec3(32.0);
    arr[i++] = vec3(33.0);
    arr[i++] = vec3(34.0);
    arr[i++] = vec3(35.0);
    arr[i++] = vec3(36.0);
    arr[i++] = vec3(37.0);
    arr[i++] = vec3(38.0);
    arr[i++] = vec3(39.0);
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    arr[0] = vec4(coords);
    arr[1] = vec4(coords) * 0.5;
    arr[2] = vec4(coords) * 0.25;
    arr[3] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    arr[0] = vec4(coords);
    arr[1] = vec4(coords) * 0.5;
    arr[2] = vec4(coords) * 0.25;
    arr[3] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    arr[0] = vec4(coords);
    arr[1] = vec4(coords) * 0.5;
    arr[2] = vec4(coords) * 0.25;
    arr[3] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    arr[0] = vec4(coords);
    arr[1] = vec4(coords) * 0.5;
    arr[2] = vec4(coords) * 0.25;
    arr[3] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    arr[0] = vec4(coords);
    arr[1] = vec4(coords) * 0.5;
    arr[2] = vec4(coords) * 0.25;
    arr[3] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    arr[0] = vec4(coords);
    arr[1] = vec4(coords) * 0.5;
    arr[2] = vec4(coords) * 0.25;
    arr[3] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    arr[0] = vec4(coords);
    arr[1] = vec4(coords) * 0.5;
    arr[2] = vec4(coords) * 0.25;
    arr[3] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    arr[0] = vec4(coords);
    arr[1] = vec4(coords) * 0.5;
    arr[2] = vec4(coords) * 0.25;
    arr[3] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    arr[ui_zero]  = vec4(coords);
    arr[ui_one]   = vec4(coords) * 0.5;
    arr[ui_two]   = vec4(coords) * 0.25;
    arr[ui_three] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    arr[ui_zero]  = vec4(coords);
    arr[ui_one]   = vec4(coords) * 0.5;
    arr[ui_two]   = vec4(coords) * 0.25;
    arr[ui_three] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    arr[ui_zero]  = vec4(coords);
    arr[ui_one]   = vec4(coords) * 0.5;
    arr[ui_two]   = vec4(coords) * 0.25;
    arr[ui_three] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    arr[ui_zero]  = vec4(coords);
    arr[ui_one]   = vec4(coords) * 0.5;
    arr[ui_two]   = vec4(coords) * 0.25;
    arr[ui_three] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    arr[ui_zero]  = vec4(coords);
    arr[ui_one]   = vec4(coords) * 0.5;
    arr[ui_two]   = vec4(coords) * 0.25;
    arr[ui_three] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    arr[ui_zero]  = vec4(coords);
    arr[ui_one]   = vec4(coords) * 0.5;
    arr[ui_two]   = vec4(coords) * 0.25;
    arr[ui_three] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    arr[ui_zero]  = vec4(coords);
    arr[ui_one]   = vec4(coords) * 0.5;
    arr[ui_two]   = vec4(coords) * 0.25;
    arr[ui_three] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    arr[ui_zero]  = vec4(coords);
    arr[ui_one]   = vec4(coords) * 0.5;
    arr[ui_two]   = vec4(coords) * 0.25;
    arr[ui_three] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[40];
    arr[0] = vec4(0.125, 0.25, 0.5, 1.0);
    arr[1] = vec4(0.125, 0.25, 0.5, 1.0) * 0.5;
    arr[2] = vec4(0.125, 0.25, 0.5, 1.0) * 0.25;
    arr[3] = vec4(0.125, 0.25, 0.5, 1.0) * 0.125;
    int i = 4;
    arr[i++] = vec4(4.0);
    arr[i++] = vec4(5.0);
    arr[i++] = vec4(6.0);
    arr[i++] = vec4(7.0);
    arr[i++] = vec4(8.0);
    arr[i++] = vec4(9.0);
    arr[i++] = vec4(10.0);
    arr[i++] = vec4(11.0);
    arr[i++] = vec4(12.0);
    arr[i++] = vec4(13.0);
    arr[i++] = vec4(14.0);
    arr[i++] = vec4(15.0);
    arr[i++] = vec4(16.0);
    arr[i++] = vec4(17.0);
    arr[i++] = vec4(18.0);
    arr[i++] = vec4(19.0);
    arr[i++] = vec4(20.0);
    arr[i++] = vec4(21.0);
    arr[i++] = vec4(22.0);
    arr[i++] = vec4(23.0);
    arr[i++] = vec4(24.0);
    arr[i++] = vec4(25.0);
    arr[i++] = vec4(26.0);
    arr[i++] = vec4(27.0);
    arr[i++] = vec4(28.0);
    arr[i++] = vec4(29.0);
    arr[i++] = vec4(30.0);
    arr[i++] = vec4(31.0);
    arr[i++] = vec4(32.0);
    arr[i++] = vec4(33.0);
    arr[i++] = vec4(34.0);
    arr[i++] = vec4(35.0);
    arr[i++] = vec4(36.0);
    arr[i++] = vec4(37.0);
    arr[i++] = vec4(38.0);
    arr[i++] = vec4(39.0);
    mediump vec4 res = vec4(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 arr[40];
    arr[0] = vec4(0.125, 0.25, 0.5, 1.0);
    arr[1] = vec4(0.125, 0.25, 0.5, 1.0) * 0.5;
    arr[2] = vec4(0.125, 0.25, 0.5, 1.0) * 0.25;
    arr[3] = vec4(0.125, 0.25, 0.5, 1.0) * 0.125;
    int i = 4;
    arr[i++] = vec4(4.0);
    arr[i++] = vec4(5.0);
    arr[i++] = vec4(6.0);
    arr[i++] = vec4(7.0);
    arr[i++] = vec4(8.0);
    arr[i++] = vec4(9.0);
    arr[i++] = vec4(10.0);
    arr[i++] = vec4(11.0);
    arr[i++] = vec4(12.0);
    arr[i++] = vec4(13.0);
    arr[i++] = vec4(14.0);
    arr[i++] = vec4(15.0);
    arr[i++] = vec4(16.0);
    arr[i++] = vec4(17.0);
    arr[i++] = vec4(18.0);
    arr[i++] = vec4(19.0);
    arr[i++] = vec4(20.0);
    arr[i++] = vec4(21.0);
    arr[i++] = vec4(22.0);
    arr[i++] = vec4(23.0);
    arr[i++] = vec4(24.0);
    arr[i++] = vec4(25.0);
    arr[i++] = vec4(26.0);
    arr[i++] = vec4(27.0);
    arr[i++] = vec4(28.0);
    arr[i++] = vec4(29.0);
    arr[i++] = vec4(30.0);
    arr[i++] = vec4(31.0);
    arr[i++] = vec4(32.0);
    arr[i++] = vec4(33.0);
    arr[i++] = vec4(34.0);
    arr[i++] = vec4(35.0);
    arr[i++] = vec4(36.0);
    arr[i++] = vec4(37.0);
    arr[i++] = vec4(38.0);
    arr[i++] = vec4(39.0);
    mediump vec4 res = vec4(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[40];
    arr[0] = vec4(0.125, 0.25, 0.5, 1.0);
    arr[1] = vec4(0.125, 0.25, 0.5, 1.0) * 0.5;
    arr[2] = vec4(0.125, 0.25, 0.5, 1.0) * 0.25;
    arr[3] = vec4(0.125, 0.25, 0.5, 1.0) * 0.125;
    int i = 4;
    arr[i++] = vec4(4.0);
    arr[i++] = vec4(5.0);
    arr[i++] = vec4(6.0);
    arr[i++] = vec4(7.0);
    arr[i++] = vec4(8.0);
    arr[i++] = vec4(9.0);
    arr[i++] = vec4(10.0);
    arr[i++] = vec4(11.0);
    arr[i++] = vec4(12.0);
    arr[i++] = vec4(13.0);
    arr[i++] = vec4(14.0);
    arr[i++] = vec4(15.0);
    arr[i++] = vec4(16.0);
    arr[i++] = vec4(17.0);
    arr[i++] = vec4(18.0);
    arr[i++] = vec4(19.0);
    arr[i++] = vec4(20.0);
    arr[i++] = vec4(21.0);
    arr[i++] = vec4(22.0);
    arr[i++] = vec4(23.0);
    arr[i++] = vec4(24.0);
    arr[i++] = vec4(25.0);
    arr[i++] = vec4(26.0);
    arr[i++] = vec4(27.0);
    arr[i++] = vec4(28.0);
    arr[i++] = vec4(29.0);
    arr[i++] = vec4(30.0);
    arr[i++] = vec4(31.0);
    arr[i++] = vec4(32.0);
    arr[i++] = vec4(33.0);
    arr[i++] = vec4(34.0);
    arr[i++] = vec4(35.0);
    arr[i++] = vec4(36.0);
    arr[i++] = vec4(37.0);
    arr[i++] = vec4(38.0);
    arr[i++] = vec4(39.0);
    mediump vec4 res = vec4(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 arr[40];
    arr[0] = vec4(0.125, 0.25, 0.5, 1.0);
    arr[1] = vec4(0.125, 0.25, 0.5, 1.0) * 0.5;
    arr[2] = vec4(0.125, 0.25, 0.5, 1.0) * 0.25;
    arr[3] = vec4(0.125, 0.25, 0.5, 1.0) * 0.125;
    int i = 4;
    arr[i++] = vec4(4.0);
    arr[i++] = vec4(5.0);
    arr[i++] = vec4(6.0);
    arr[i++] = vec4(7.0);
    arr[i++] = vec4(8.0);
    arr[i++] = vec4(9.0);
    arr[i++] = vec4(10.0);
    arr[i++] = vec4(11.0);
    arr[i++] = vec4(12.0);
    arr[i++] = vec4(13.0);
    arr[i++] = vec4(14.0);
    arr[i++] = vec4(15.0);
    arr[i++] = vec4(16.0);
    arr[i++] = vec4(17.0);
    arr[i++] = vec4(18.0);
    arr[i++] = vec4(19.0);
    arr[i++] = vec4(20.0);
    arr[i++] = vec4(21.0);
    arr[i++] = vec4(22.0);
    arr[i++] = vec4(23.0);
    arr[i++] = vec4(24.0);
    arr[i++] = vec4(25.0);
    arr[i++] = vec4(26.0);
    arr[i++] = vec4(27.0);
    arr[i++] = vec4(28.0);
    arr[i++] = vec4(29.0);
    arr[i++] = vec4(30.0);
    arr[i++] = vec4(31.0);
    arr[i++] = vec4(32.0);
    arr[i++] = vec4(33.0);
    arr[i++] = vec4(34.0);
    arr[i++] = vec4(35.0);
    arr[i++] = vec4(36.0);
    arr[i++] = vec4(37.0);
    arr[i++] = vec4(38.0);
    arr[i++] = vec4(39.0);
    mediump vec4 res = vec4(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[40];
    arr[0] = vec4(0.125, 0.25, 0.5, 1.0);
    arr[1] = vec4(0.125, 0.25, 0.5, 1.0) * 0.5;
    arr[2] = vec4(0.125, 0.25, 0.5, 1.0) * 0.25;
    arr[3] = vec4(0.125, 0.25, 0.5, 1.0) * 0.125;
    int i = 4;
    arr[i++] = vec4(4.0);
    arr[i++] = vec4(5.0);
    arr[i++] = vec4(6.0);
    arr[i++] = vec4(7.0);
    arr[i++] = vec4(8.0);
    arr[i++] = vec4(9.0);
    arr[i++] = vec4(10.0);
    arr[i++] = vec4(11.0);
    arr[i++] = vec4(12.0);
    arr[i++] = vec4(13.0);
    arr[i++] = vec4(14.0);
    arr[i++] = vec4(15.0);
    arr[i++] = vec4(16.0);
    arr[i++] = vec4(17.0);
    arr[i++] = vec4(18.0);
    arr[i++] = vec4(19.0);
    arr[i++] = vec4(20.0);
    arr[i++] = vec4(21.0);
    arr[i++] = vec4(22.0);
    arr[i++] = vec4(23.0);
    arr[i++] = vec4(24.0);
    arr[i++] = vec4(25.0);
    arr[i++] = vec4(26.0);
    arr[i++] = vec4(27.0);
    arr[i++] = vec4(28.0);
    arr[i++] = vec4(29.0);
    arr[i++] = vec4(30.0);
    arr[i++] = vec4(31.0);
    arr[i++] = vec4(32.0);
    arr[i++] = vec4(33.0);
    arr[i++] = vec4(34.0);
    arr[i++] = vec4(35.0);
    arr[i++] = vec4(36.0);
    arr[i++] = vec4(37.0);
    arr[i++] = vec4(38.0);
    arr[i++] = vec4(39.0);
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 arr[40];
    arr[0] = vec4(0.125, 0.25, 0.5, 1.0);
    arr[1] = vec4(0.125, 0.25, 0.5, 1.0) * 0.5;
    arr[2] = vec4(0.125, 0.25, 0.5, 1.0) * 0.25;
    arr[3] = vec4(0.125, 0.25, 0.5, 1.0) * 0.125;
    int i = 4;
    arr[i++] = vec4(4.0);
    arr[i++] = vec4(5.0);
    arr[i++] = vec4(6.0);
    arr[i++] = vec4(7.0);
    arr[i++] = vec4(8.0);
    arr[i++] = vec4(9.0);
    arr[i++] = vec4(10.0);
    arr[i++] = vec4(11.0);
    arr[i++] = vec4(12.0);
    arr[i++] = vec4(13.0);
    arr[i++] = vec4(14.0);
    arr[i++] = vec4(15.0);
    arr[i++] = vec4(16.0);
    arr[i++] = vec4(17.0);
    arr[i++] = vec4(18.0);
    arr[i++] = vec4(19.0);
    arr[i++] = vec4(20.0);
    arr[i++] = vec4(21.0);
    arr[i++] = vec4(22.0);
    arr[i++] = vec4(23.0);
    arr[i++] = vec4(24.0);
    arr[i++] = vec4(25.0);
    arr[i++] = vec4(26.0);
    arr[i++] = vec4(27.0);
    arr[i++] = vec4(28.0);
    arr[i++] = vec4(29.0);
    arr[i++] = vec4(30.0);
    arr[i++] = vec4(31.0);
    arr[i++] = vec4(32.0);
    arr[i++] = vec4(33.0);
    arr[i++] = vec4(34.0);
    arr[i++] = vec4(35.0);
    arr[i++] = vec4(36.0);
    arr[i++] = vec4(37.0);
    arr[i++] = vec4(38.0);
    arr[i++] = vec4(39.0);
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 arr[40];
    arr[0] = vec4(0.125, 0.25, 0.5, 1.0);
    arr[1] = vec4(0.125, 0.25, 0.5, 1.0) * 0.5;
    arr[2] = vec4(0.125, 0.25, 0.5, 1.0) * 0.25;
    arr[3] = vec4(0.125, 0.25, 0.5, 1.0) * 0.125;
    int i = 4;
    arr[i++] = vec4(4.0);
    arr[i++] = vec4(5.0);
    arr[i++] = vec4(6.0);
    arr[i++] = vec4(7.0);
    arr[i++] = vec4(8.0);
    arr[i++] = vec4(9.0);
    arr[i++] = vec4(10.0);
    arr[i++] = vec4(11.0);
    arr[i++] = vec4(12.0);
    arr[i++] = vec4(13.0);
    arr[i++] = vec4(14.0);
    arr[i++] = vec4(15.0);
    arr[i++] = vec4(16.0);
    arr[i++] = vec4(17.0);
    arr[i++] = vec4(18.0);
    arr[i++] = vec4(19.0);
    arr[i++] = vec4(20.0);
    arr[i++] = vec4(21.0);
    arr[i++] = vec4(22.0);
    arr[i++] = vec4(23.0);
    arr[i++] = vec4(24.0);
    arr[i++] = vec4(25.0);
    arr[i++] = vec4(26.0);
    arr[i++] = vec4(27.0);
    arr[i++] = vec4(28.0);
    arr[i++] = vec4(29.0);
    arr[i++] = vec4(30.0);
    arr[i++] = vec4(31.0);
    arr[i++] = vec4(32.0);
    arr[i++] = vec4(33.0);
    arr[i++] = vec4(34.0);
    arr[i++] = vec4(35.0);
    arr[i++] = vec4(36.0);
    arr[i++] = vec4(37.0);
    arr[i++] = vec4(38.0);
    arr[i++] = vec4(39.0);
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 arr[40];
    arr[0] = vec4(0.125, 0.25, 0.5, 1.0);
    arr[1] = vec4(0.125, 0.25, 0.5, 1.0) * 0.5;
    arr[2] = vec4(0.125, 0.25, 0.5, 1.0) * 0.25;
    arr[3] = vec4(0.125, 0.25, 0.5, 1.0) * 0.125;
    int i = 4;
    arr[i++] = vec4(4.0);
    arr[i++] = vec4(5.0);
    arr[i++] = vec4(6.0);
    arr[i++] = vec4(7.0);
    arr[i++] = vec4(8.0);
    arr[i++] = vec4(9.0);
    arr[i++] = vec4(10.0);
    arr[i++] = vec4(11.0);
    arr[i++] = vec4(12.0);
    arr[i++] = vec4(13.0);
    arr[i++] = vec4(14.0);
    arr[i++] = vec4(15.0);
    arr[i++] = vec4(16.0);
    arr[i++] = vec4(17.0);
    arr[i++] = vec4(18.0);
    arr[i++] = vec4(19.0);
    arr[i++] = vec4(20.0);
    arr[i++] = vec4(21.0);
    arr[i++] = vec4(22.0);
    arr[i++] = vec4(23.0);
    arr[i++] = vec4(24.0);
    arr[i++] = vec4(25.0);
    arr[i++] = vec4(26.0);
    arr[i++] = vec4(27.0);
    arr[i++] = vec4(28.0);
    arr[i++] = vec4(29.0);
    arr[i++] = vec4(30.0);
    arr[i++] = vec4(31.0);
    arr[i++] = vec4(32.0);
    arr[i++] = vec4(33.0);
    arr[i++] = vec4(34.0);
    arr[i++] = vec4(35.0);
    arr[i++] = vec4(36.0);
    arr[i++] = vec4(37.0);
    arr[i++] = vec4(38.0);
    arr[i++] = vec4(39.0);
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec3 v_color;

void main()
{
    o_color = vec4(v_color.rgb, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    res = dot(tmp, vec3(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    res = dot(tmp, vec3(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec3(res);
}
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
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    res = dot(tmp, vec3(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    res = dot(tmp, vec3(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    res = dot(tmp, vec3(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    res = dot(tmp, vec3(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    res = dot(tmp, vec3(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    res = dot(tmp, vec3(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res = dot(tmp, vec3(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res = dot(tmp, vec3(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res = dot(tmp, vec3(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res = dot(tmp, vec3(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec3(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    tmp[3] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    tmp[3] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    tmp[3] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    tmp[3] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    tmp[3] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    tmp[3] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    tmp[3] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    tmp[2] = vec2(coords.zwxy) * 0.25;
    tmp[3] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    tmp[ui_three] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    tmp[ui_three] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    tmp[ui_three] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    tmp[ui_three] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    tmp[ui_three] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    tmp[ui_three] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    tmp[ui_three] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    tmp[ui_three] = vec2(coords.wxyz) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x2 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    tmp[3] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    tmp[3] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    tmp[3] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    tmp[3] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    tmp[3] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    tmp[3] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    tmp[3] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    tmp[3] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    tmp[ui_three] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    tmp[ui_three] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    tmp[ui_three] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    tmp[ui_three] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    tmp[ui_three] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    tmp[ui_three] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    tmp[ui_three] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    tmp[ui_three] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    tmp[3] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    tmp[3] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    tmp[3] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    tmp[3] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    tmp[3] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    tmp[3] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    tmp[3] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    tmp[3] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    tmp[ui_three] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    tmp[ui_three] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    tmp[ui_three] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    tmp[ui_three] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    tmp[ui_three] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    tmp[ui_three] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    tmp[ui_three] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec4(coords.zwxy) * 0.25;
    tmp[ui_three] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(res);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    v_color = vec4(res);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    for (int i = 0; i < ui_four; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res);
}
