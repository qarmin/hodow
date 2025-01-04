#version 450
layout(location = 0) in highp vec4 a_position;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; }; 
void main (void)
{
    highp float res = dFdx(7.7) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; }; 
void main (void)
{
    highp float res = dFdxFine(7.7) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; }; 
void main (void)
{
    highp float res = dFdxCoarse(7.7) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; }; 
void main (void)
{
    highp float res = dFdyFine(7.7) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; }; 
void main (void)
{
    highp float res = dFdyCoarse(7.7) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; }; 
void main (void)
{
    highp float res = fwidth(7.7) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; }; 
void main (void)
{
    highp float res = fwidthFine(7.7) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump float a_coord;
layout(location = 0) out mediump float v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = dFdx(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec2 a_coord;
layout(location = 0) out mediump vec2 v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coord;
layout(location = 0) out highp vec2 v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in lowp vec3 a_coord;
layout(location = 0) out lowp vec3 v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
#version 450
layout(location = 0) in lowp vec3 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec3 u_bias; };
void main (void)
{
    lowp vec3 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coord;
layout(location = 0) out highp vec3 v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in lowp vec4 a_coord;
layout(location = 0) out lowp vec4 v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
#version 450
layout(location = 0) in lowp vec4 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec4 u_bias; };
void main (void)
{
    lowp vec4 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec4 a_coord;
layout(location = 0) out mediump vec4 v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coord;
layout(location = 0) out highp vec4 v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };

mediump vec2 computeRes (mediump vec2 value)
{
    return dFdx(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec2 res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };

mediump vec4 computeRes (mediump vec4 value)
{
    return dFdx(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec4 res = computeRes(v_coord);
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res;
    if (false)
        res = dFdx(-v_coord) * u_scale + u_bias;
    else
        res = dFdx(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res;
    if (false)
        res = dFdx(-v_coord) * u_scale + u_bias;
    else
        res = dFdx(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdx(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdx(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdx(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdx(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdx(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res;
    switch (1)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coord;
layout(location = 0) out highp float v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res;
    switch (1)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res;
    switch (1)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec3 a_coord;
layout(location = 0) out mediump vec3 v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res;
    switch (1)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res;
    switch (1)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res;
    switch (1)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump float res;
    if (ub_true)        res = dFdx(v_coord) * u_scale + u_bias;
    else
        res = dFdx(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp float res;
    if (ub_true)        res = dFdx(v_coord) * u_scale + u_bias;
    else
        res = dFdx(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump vec3 res;
    if (ub_true)        res = dFdx(v_coord) * u_scale + u_bias;
    else
        res = dFdx(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp float res = float(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdx(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdx(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdx(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    switch (ui_one)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    switch (ui_one)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    switch (ui_one)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    switch (ui_one)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    switch (ui_one)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    switch (ui_one)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    switch (ui_one)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdx(v_coord) * u_scale + u_bias;
    else
        res = dFdx(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdx(v_coord) * u_scale + u_bias;
    else
        res = dFdx(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdx(v_coord) * u_scale + u_bias;
    else
        res = dFdx(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdx(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res = vec2(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdx(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdx(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdx(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdx(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdx(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdx(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdx(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdx(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdx(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdx(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump float intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump float res = dFdx(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec2 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec2 res = dFdx(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec3 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec3 res = dFdx(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec3 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec3 res = dFdx(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec4 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec4 res = dFdx(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
highp float intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp float res = dFdx(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
highp vec2 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp vec2 res = dFdx(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
mediump vec3 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec3 res = dFdx(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
highp vec3 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp vec3 res = dFdx(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
highp vec4 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp vec4 res = dFdx(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in lowp float a_coord;
layout(location = 0) out lowp float v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
#version 450
layout(location = 0) in lowp float v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
void main (void)
{
    lowp float res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in lowp vec2 a_coord;
layout(location = 0) out lowp vec2 v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
#version 450
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
void main (void)
{
    lowp vec2 res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };

mediump float computeRes (mediump float value)
{
    return dFdxFine(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump float res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };

highp vec2 computeRes (highp vec2 value)
{
    return dFdxFine(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec2 res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };

mediump vec3 computeRes (mediump vec3 value)
{
    return dFdxFine(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec3 res = computeRes(v_coord);
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };

highp vec3 computeRes (highp vec3 value)
{
    return dFdxFine(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec3 res = computeRes(v_coord);
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };

highp vec4 computeRes (highp vec4 value)
{
    return dFdxFine(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec4 res = computeRes(v_coord);
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res;
    if (false)
        res = dFdxFine(-v_coord) * u_scale + u_bias;
    else
        res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = float(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdxFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdxFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res;
    switch (1)
    {
        case 0: res = dFdxFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res;
    switch (1)
    {
        case 0: res = dFdxFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump vec3 res;
    if (ub_true)        res = dFdxFine(v_coord) * u_scale + u_bias;
    else
        res = dFdxFine(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdxFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    switch (ui_one)
    {
        case 0: res = dFdxFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    switch (ui_one)
    {
        case 0: res = dFdxFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    switch (ui_one)
    {
        case 0: res = dFdxFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    switch (ui_one)
    {
        case 0: res = dFdxFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdxFine(v_coord) * u_scale + u_bias;
    else
        res = dFdxFine(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdxFine(v_coord) * u_scale + u_bias;
    else
        res = dFdxFine(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdxFine(v_coord) * u_scale + u_bias;
    else
        res = dFdxFine(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res = float(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdxFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res = vec2(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdxFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdxFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdxFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdxFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdxFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdxFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdxFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump float intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump float res = dFdxFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp float intermediateStore;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp float res = dFdxFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec2 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec2 res = dFdxFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec2 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec2 res = dFdxFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec3 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec3 res = dFdxFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec4 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec4 res = dFdxFine(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec4 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec4 res = dFdxFine(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
mediump vec3 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec3 res = dFdxFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in lowp float v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
void main (void)
{
    lowp float res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
void main (void)
{
    lowp vec2 res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };

mediump float computeRes (mediump float value)
{
    return dFdxCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump float res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };

highp float computeRes (highp float value)
{
    return dFdxCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp float res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };

mediump vec2 computeRes (mediump vec2 value)
{
    return dFdxCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec2 res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };

highp vec2 computeRes (highp vec2 value)
{
    return dFdxCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec2 res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };

highp vec3 computeRes (highp vec3 value)
{
    return dFdxCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec3 res = computeRes(v_coord);
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };

mediump vec4 computeRes (mediump vec4 value)
{
    return dFdxCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec4 res = computeRes(v_coord);
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };

highp vec4 computeRes (highp vec4 value)
{
    return dFdxCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec4 res = computeRes(v_coord);
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res;
    if (false)
        res = dFdxCoarse(-v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res;
    if (false)
        res = dFdxCoarse(-v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res;
    if (false)
        res = dFdxCoarse(-v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res;
    if (false)
        res = dFdxCoarse(-v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res;
    if (false)
        res = dFdxCoarse(-v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res;
    if (false)
        res = dFdxCoarse(-v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = float(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdxCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = float(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdxCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdxCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdxCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res;
    switch (1)
    {
        case 0: res = dFdxCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res;
    switch (1)
    {
        case 0: res = dFdxCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res;
    switch (1)
    {
        case 0: res = dFdxCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res;
    switch (1)
    {
        case 0: res = dFdxCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res;
    switch (1)
    {
        case 0: res = dFdxCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump float res;
    if (ub_true)        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump vec2 res;
    if (ub_true)        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp vec2 res;
    if (ub_true)        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp vec3 res;
    if (ub_true)        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump vec4 res;
    if (ub_true)        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(-v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp vec4 res;
    if (ub_true)        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(-v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp float res = float(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdxCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdxCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdxCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdxCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdxCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    switch (ui_one)
    {
        case 0: res = dFdxCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    switch (ui_one)
    {
        case 0: res = dFdxCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    switch (ui_one)
    {
        case 0: res = dFdxCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdxCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdxCoarse(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdxCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdxCoarse(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxCoarse(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdxCoarse(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdxCoarse(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump float intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump float res = dFdxCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec2 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec2 res = dFdxCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec4 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec4 res = dFdxCoarse(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
highp vec2 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp vec2 res = dFdxCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
mediump vec3 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec3 res = dFdxCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
highp vec3 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp vec3 res = dFdxCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
highp vec4 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp vec4 res = dFdxCoarse(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = dFdy(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
void main (void)
{
    lowp vec2 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };

mediump float computeRes (mediump float value)
{
    return dFdy(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump float res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };

highp vec2 computeRes (highp vec2 value)
{
    return dFdy(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec2 res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };

mediump vec3 computeRes (mediump vec3 value)
{
    return dFdy(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec3 res = computeRes(v_coord);
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };

highp vec3 computeRes (highp vec3 value)
{
    return dFdy(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec3 res = computeRes(v_coord);
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };

highp vec4 computeRes (highp vec4 value)
{
    return dFdy(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec4 res = computeRes(v_coord);
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res;
    if (false)
        res = dFdy(-v_coord) * u_scale + u_bias;
    else
        res = dFdy(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = float(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdy(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdy(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res;
    switch (1)
    {
        case 0: res = dFdy(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdy(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res;
    switch (1)
    {
        case 0: res = dFdy(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdy(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res;
    switch (1)
    {
        case 0: res = dFdy(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdy(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump vec3 res;
    if (ub_true)        res = dFdy(v_coord) * u_scale + u_bias;
    else
        res = dFdy(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump float res = float(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdy(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdy(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    switch (ui_one)
    {
        case 0: res = dFdy(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdy(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    switch (ui_one)
    {
        case 0: res = dFdy(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdy(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    switch (ui_one)
    {
        case 0: res = dFdy(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdy(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdy(v_coord) * u_scale + u_bias;
    else
        res = dFdy(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdy(v_coord) * u_scale + u_bias;
    else
        res = dFdy(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdy(v_coord) * u_scale + u_bias;
    else
        res = dFdy(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res = float(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdy(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res = float(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdy(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res = vec2(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdy(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdy(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdy(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdy(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdy(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdy(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdy(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdy(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp float intermediateStore;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp float res = dFdy(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec2 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec2 res = dFdy(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec2 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec2 res = dFdy(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec3 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec3 res = dFdy(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec4 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec4 res = dFdy(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec4 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec4 res = dFdy(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
mediump vec2 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec2 res = dFdy(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
mediump vec4 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec4 res = dFdy(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in lowp float v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
void main (void)
{
    lowp float res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
void main (void)
{
    lowp vec2 res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };

mediump vec3 computeRes (mediump vec3 value)
{
    return dFdyFine(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec3 res = computeRes(v_coord);
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res;
    if (false)
        res = dFdyFine(-v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res;
    if (false)
        res = dFdyFine(-v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res;
    if (false)
        res = dFdyFine(-v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res;
    if (false)
        res = dFdyFine(-v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res;
    if (false)
        res = dFdyFine(-v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res;
    if (false)
        res = dFdyFine(-v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdyFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdyFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdyFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdyFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res;
    switch (1)
    {
        case 0: res = dFdyFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res;
    switch (1)
    {
        case 0: res = dFdyFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp float res;
    if (ub_true)        res = dFdyFine(v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp vec2 res;
    if (ub_true)        res = dFdyFine(v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump vec3 res;
    if (ub_true)        res = dFdyFine(v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp vec3 res;
    if (ub_true)        res = dFdyFine(v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp vec4 res;
    if (ub_true)        res = dFdyFine(v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(-v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdyFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdyFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    switch (ui_one)
    {
        case 0: res = dFdyFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    switch (ui_one)
    {
        case 0: res = dFdyFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    switch (ui_one)
    {
        case 0: res = dFdyFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    switch (ui_one)
    {
        case 0: res = dFdyFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    switch (ui_one)
    {
        case 0: res = dFdyFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    switch (ui_one)
    {
        case 0: res = dFdyFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdyFine(v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdyFine(v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdyFine(v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdyFine(v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdyFine(v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdyFine(v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdyFine(v_coord) * u_scale + u_bias;
    else
        res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res = float(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdyFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdyFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res = vec2(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdyFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdyFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdyFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdyFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump float intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump float res = dFdyFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp float intermediateStore;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp float res = dFdyFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec2 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec2 res = dFdyFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec3 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec3 res = dFdyFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec3 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec3 res = dFdyFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec4 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec4 res = dFdyFine(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
mediump float intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump float res = dFdyFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
highp float intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp float res = dFdyFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
mediump vec3 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec3 res = dFdyFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in lowp float v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
void main (void)
{
    lowp float res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in lowp vec3 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec3 u_bias; };
void main (void)
{
    lowp vec3 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in lowp vec4 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec4 u_bias; };
void main (void)
{
    lowp vec4 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };

mediump vec2 computeRes (mediump vec2 value)
{
    return dFdyCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec2 res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };

highp vec2 computeRes (highp vec2 value)
{
    return dFdyCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec2 res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };

highp vec3 computeRes (highp vec3 value)
{
    return dFdyCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec3 res = computeRes(v_coord);
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };

mediump vec4 computeRes (mediump vec4 value)
{
    return dFdyCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec4 res = computeRes(v_coord);
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };

highp vec4 computeRes (highp vec4 value)
{
    return dFdyCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec4 res = computeRes(v_coord);
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res;
    if (false)
        res = dFdyCoarse(-v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res;
    if (false)
        res = dFdyCoarse(-v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdyCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdyCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res;
    switch (1)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res;
    switch (1)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res;
    switch (1)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res;
    switch (1)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res;
    switch (1)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res;
    switch (1)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump float res;
    if (ub_true)        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp vec2 res;
    if (ub_true)        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump vec3 res;
    if (ub_true)        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp vec3 res;
    if (ub_true)        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp vec4 res;
    if (ub_true)        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(-v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp float res = float(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdyCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdyCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdyCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    switch (ui_one)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    switch (ui_one)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    switch (ui_one)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    switch (ui_one)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    switch (ui_one)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    switch (ui_one)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    switch (ui_one)
    {
        case 0: res = dFdyCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdyCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res = vec2(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdyCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdyCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdyCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdyCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = dFdyCoarse(v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyCoarse(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump float intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump float res = dFdyCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec2 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec2 res = dFdyCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec3 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec3 res = dFdyCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec3 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec3 res = dFdyCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec4 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec4 res = dFdyCoarse(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
highp float intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp float res = dFdyCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
highp vec2 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp vec2 res = dFdyCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
mediump vec3 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec3 res = dFdyCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
highp vec3 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp vec3 res = dFdyCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
highp vec4 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp vec4 res = dFdyCoarse(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
void main (void)
{
    lowp vec2 res = fwidth(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = fwidth(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = fwidth(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = fwidth(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = fwidth(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = fwidth(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };

highp float computeRes (highp float value)
{
    return fwidth(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp float res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };

mediump vec3 computeRes (mediump vec3 value)
{
    return fwidth(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec3 res = computeRes(v_coord);
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res;
    if (false)
        res = fwidth(-v_coord) * u_scale + u_bias;
    else
        res = fwidth(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res;
    if (false)
        res = fwidth(-v_coord) * u_scale + u_bias;
    else
        res = fwidth(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res;
    if (false)
        res = fwidth(-v_coord) * u_scale + u_bias;
    else
        res = fwidth(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res;
    if (false)
        res = fwidth(-v_coord) * u_scale + u_bias;
    else
        res = fwidth(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res;
    if (false)
        res = fwidth(-v_coord) * u_scale + u_bias;
    else
        res = fwidth(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res;
    if (false)
        res = fwidth(-v_coord) * u_scale + u_bias;
    else
        res = fwidth(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = float(0.0);
    for (int i = 0; i < 2; i++)
        res += fwidth(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += fwidth(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += fwidth(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += fwidth(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    for (int i = 0; i < 2; i++)
        res += fwidth(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res;
    switch (1)
    {
        case 0: res = fwidth(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res;
    switch (1)
    {
        case 0: res = fwidth(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp float res;
    if (ub_true)        res = fwidth(v_coord) * u_scale + u_bias;
    else
        res = fwidth(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump vec2 res;
    if (ub_true)        res = fwidth(v_coord) * u_scale + u_bias;
    else
        res = fwidth(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump vec4 res;
    if (ub_true)        res = fwidth(v_coord) * u_scale + u_bias;
    else
        res = fwidth(-v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidth(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidth(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidth(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidth(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidth(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    switch (ui_one)
    {
        case 0: res = fwidth(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    switch (ui_one)
    {
        case 0: res = fwidth(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    switch (ui_one)
    {
        case 0: res = fwidth(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    switch (ui_one)
    {
        case 0: res = fwidth(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    switch (ui_one)
    {
        case 0: res = fwidth(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    switch (ui_one)
    {
        case 0: res = fwidth(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = fwidth(v_coord) * u_scale + u_bias;
    else
        res = fwidth(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = fwidth(v_coord) * u_scale + u_bias;
    else
        res = fwidth(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = fwidth(v_coord) * u_scale + u_bias;
    else
        res = fwidth(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res = float(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidth(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidth(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidth(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidth(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidth(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidth(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidth(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidth(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidth(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidth(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidth(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump float intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump float res = fwidth(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp float intermediateStore;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp float res = fwidth(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec3 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec3 res = fwidth(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
mediump float intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump float res = fwidth(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
highp float intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp float res = fwidth(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
mediump vec3 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec3 res = fwidth(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in lowp float v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
void main (void)
{
    lowp float res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in lowp vec3 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec3 u_bias; };
void main (void)
{
    lowp vec3 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in lowp vec4 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec4 u_bias; };
void main (void)
{
    lowp vec4 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };

highp float computeRes (highp float value)
{
    return fwidthFine(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp float res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };

highp vec2 computeRes (highp vec2 value)
{
    return fwidthFine(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec2 res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };

mediump vec3 computeRes (mediump vec3 value)
{
    return fwidthFine(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec3 res = computeRes(v_coord);
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };

highp vec3 computeRes (highp vec3 value)
{
    return fwidthFine(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec3 res = computeRes(v_coord);
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };

highp vec4 computeRes (highp vec4 value)
{
    return fwidthFine(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec4 res = computeRes(v_coord);
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res;
    if (false)
        res = fwidthFine(-v_coord) * u_scale + u_bias;
    else
        res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res;
    if (false)
        res = fwidthFine(-v_coord) * u_scale + u_bias;
    else
        res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res;
    if (false)
        res = fwidthFine(-v_coord) * u_scale + u_bias;
    else
        res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res;
    if (false)
        res = fwidthFine(-v_coord) * u_scale + u_bias;
    else
        res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res;
    if (false)
        res = fwidthFine(-v_coord) * u_scale + u_bias;
    else
        res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = float(0.0);
    for (int i = 0; i < 2; i++)
        res += fwidthFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += fwidthFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res;
    switch (1)
    {
        case 0: res = fwidthFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res;
    switch (1)
    {
        case 0: res = fwidthFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res;
    switch (1)
    {
        case 0: res = fwidthFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res;
    switch (1)
    {
        case 0: res = fwidthFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump vec2 res;
    if (ub_true)        res = fwidthFine(v_coord) * u_scale + u_bias;
    else
        res = fwidthFine(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump vec4 res;
    if (ub_true)        res = fwidthFine(v_coord) * u_scale + u_bias;
    else
        res = fwidthFine(-v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump float res = float(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidthFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidthFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidthFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidthFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidthFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidthFine(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    switch (ui_one)
    {
        case 0: res = fwidthFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    switch (ui_one)
    {
        case 0: res = fwidthFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    switch (ui_one)
    {
        case 0: res = fwidthFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    switch (ui_one)
    {
        case 0: res = fwidthFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    switch (ui_one)
    {
        case 0: res = fwidthFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = fwidthFine(v_coord) * u_scale + u_bias;
    else
        res = fwidthFine(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = fwidthFine(v_coord) * u_scale + u_bias;
    else
        res = fwidthFine(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res = float(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidthFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res = float(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidthFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidthFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res = vec4(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidthFine(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp float intermediateStore;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp float res = fwidthFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec3 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec3 res = fwidthFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
highp float intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp float res = fwidthFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
mediump vec2 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec2 res = fwidthFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
mediump vec4 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec4 res = fwidthFine(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
void main (void)
{
    lowp vec2 res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };

mediump float computeRes (mediump float value)
{
    return fwidthCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump float res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };

highp vec2 computeRes (highp vec2 value)
{
    return fwidthCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec2 res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };

mediump vec3 computeRes (mediump vec3 value)
{
    return fwidthCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec3 res = computeRes(v_coord);
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };

highp vec3 computeRes (highp vec3 value)
{
    return fwidthCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec3 res = computeRes(v_coord);
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };

highp vec4 computeRes (highp vec4 value)
{
    return fwidthCoarse(v_coord) * u_scale + u_bias;
}

void main (void)
{
    highp vec4 res = computeRes(v_coord);
    o_color = res;
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res;
    if (false)
        res = fwidthCoarse(-v_coord) * u_scale + u_bias;
    else
        res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res;
    if (false)
        res = fwidthCoarse(-v_coord) * u_scale + u_bias;
    else
        res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res;
    if (false)
        res = fwidthCoarse(-v_coord) * u_scale + u_bias;
    else
        res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res;
    if (false)
        res = fwidthCoarse(-v_coord) * u_scale + u_bias;
    else
        res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = float(0.0);
    for (int i = 0; i < 2; i++)
        res += fwidthCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += fwidthCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res;
    switch (1)
    {
        case 0: res = fwidthCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res;
    switch (1)
    {
        case 0: res = fwidthCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    mediump vec3 res;
    if (ub_true)        res = fwidthCoarse(v_coord) * u_scale + u_bias;
    else
        res = fwidthCoarse(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump float res = float(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidthCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidthCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    switch (ui_one)
    {
        case 0: res = fwidthCoarse(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthCoarse(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = fwidthCoarse(v_coord) * u_scale + u_bias;
    else
        res = fwidthCoarse(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = fwidthCoarse(v_coord) * u_scale + u_bias;
    else
        res = fwidthCoarse(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    if (quad_uniform)
        res = fwidthCoarse(v_coord) * u_scale + u_bias;
    else
        res = fwidthCoarse(v_coord * float(ui_one)) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump float res = float(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidthCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res = float(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidthCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec2 res = vec2(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidthCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res = vec3(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidthCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidthCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = fwidthCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec2 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidthCoarse(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthCoarse(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec4 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidthCoarse(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthCoarse(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp float intermediateStore;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp float res = fwidthCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec2 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec2 res = fwidthCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec2 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec2 res = fwidthCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec3 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec3 res = fwidthCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) out mediump vec4 intermediateStore;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    mediump vec4 res = fwidthCoarse(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec4 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec4 res = fwidthCoarse(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
mediump float intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump float res = fwidthCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
mediump vec2 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec2 res = fwidthCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
mediump vec4 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec4 res = fwidthCoarse(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = dFdx(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
#extension GL_KHR_shader_subgroup_quad : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
vec3 dFdxSubgroup(vec3 f)
{
    vec3 left, right;
    if ((gl_SubgroupInvocationID & 2) == 0) {
        left = subgroupQuadBroadcast(f, 0);
        right = subgroupQuadBroadcast(f, 1);
    } else {
        left = subgroupQuadBroadcast(f, 2);
        right = subgroupQuadBroadcast(f, 3);
    }
    return right - left;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    mediump vec3 res = dFdxSubgroup(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
float dFdySubgroup(float f)
{
    float top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    mediump float res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
vec2 dFdySubgroup(vec2 f)
{
    vec2 top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    mediump vec2 res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
vec2 dFdySubgroup(vec2 f)
{
    vec2 top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    highp vec2 res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
vec3 dFdySubgroup(vec3 f)
{
    vec3 top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    highp vec3 res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
vec4 dFdySubgroup(vec4 f)
{
    vec4 top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    mediump vec4 res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
vec4 dFdySubgroup(vec4 f)
{
    vec4 top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    highp vec4 res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = dFdx(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = dFdx(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
void main (void)
{
    lowp vec2 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = dFdx(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in lowp float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
void main (void)
{
    lowp float res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
void main (void)
{
    lowp vec2 res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in lowp float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
void main (void)
{
    lowp float res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
void main (void)
{
    lowp vec2 res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = dFdxCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = dFdy(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
void main (void)
{
    lowp vec2 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in lowp float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
void main (void)
{
    lowp float res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in lowp vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec3 u_bias; };
void main (void)
{
    lowp vec3 res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in lowp vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec4 u_bias; };
void main (void)
{
    lowp vec4 res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in lowp vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec3 u_bias; };
void main (void)
{
    lowp vec3 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
void main (void)
{
    mediump vec3 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in lowp vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec4 u_bias; };
void main (void)
{
    lowp vec4 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = dFdyCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
void main (void)
{
    mediump float res = fwidth(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
void main (void)
{
    lowp vec2 res = fwidth(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = fwidth(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = fwidth(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = fwidth(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = fwidth(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = fwidth(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
void main (void)
{
    lowp vec2 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    highp vec2 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    highp vec4 res = fwidthFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in lowp float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
void main (void)
{
    lowp float res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in lowp vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec3 u_bias; };
void main (void)
{
    lowp vec3 res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in lowp vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec4 u_bias; };
void main (void)
{
    lowp vec4 res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = fwidthCoarse(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
#extension GL_KHR_shader_subgroup_quad : require
layout(location = 0) in lowp float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
float dFdxSubgroup(float f)
{
    float left, right;
    if ((gl_SubgroupInvocationID & 2) == 0) {
        left = subgroupQuadBroadcast(f, 0);
        right = subgroupQuadBroadcast(f, 1);
    } else {
        left = subgroupQuadBroadcast(f, 2);
        right = subgroupQuadBroadcast(f, 3);
    }
    return right - left;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    lowp float res = dFdxSubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
#extension GL_KHR_shader_subgroup_quad : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
float dFdxSubgroup(float f)
{
    float left, right;
    if ((gl_SubgroupInvocationID & 2) == 0) {
        left = subgroupQuadBroadcast(f, 0);
        right = subgroupQuadBroadcast(f, 1);
    } else {
        left = subgroupQuadBroadcast(f, 2);
        right = subgroupQuadBroadcast(f, 3);
    }
    return right - left;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    mediump float res = dFdxSubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
#extension GL_KHR_shader_subgroup_quad : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
float dFdxSubgroup(float f)
{
    float left, right;
    if ((gl_SubgroupInvocationID & 2) == 0) {
        left = subgroupQuadBroadcast(f, 0);
        right = subgroupQuadBroadcast(f, 1);
    } else {
        left = subgroupQuadBroadcast(f, 2);
        right = subgroupQuadBroadcast(f, 3);
    }
    return right - left;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    highp float res = dFdxSubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
#extension GL_KHR_shader_subgroup_quad : require
layout(location = 0) in lowp vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec3 u_bias; };
vec3 dFdxSubgroup(vec3 f)
{
    vec3 left, right;
    if ((gl_SubgroupInvocationID & 2) == 0) {
        left = subgroupQuadBroadcast(f, 0);
        right = subgroupQuadBroadcast(f, 1);
    } else {
        left = subgroupQuadBroadcast(f, 2);
        right = subgroupQuadBroadcast(f, 3);
    }
    return right - left;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    lowp vec3 res = dFdxSubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
#extension GL_KHR_shader_subgroup_quad : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
vec3 dFdxSubgroup(vec3 f)
{
    vec3 left, right;
    if ((gl_SubgroupInvocationID & 2) == 0) {
        left = subgroupQuadBroadcast(f, 0);
        right = subgroupQuadBroadcast(f, 1);
    } else {
        left = subgroupQuadBroadcast(f, 2);
        right = subgroupQuadBroadcast(f, 3);
    }
    return right - left;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    mediump vec3 res = dFdxSubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
#extension GL_KHR_shader_subgroup_ballot : require
#extension GL_KHR_shader_subgroup_quad : require
layout(location = 0) in lowp vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec4 u_bias; };
vec4 dFdxSubgroup(vec4 f)
{
    vec4 left, right;
    if ((gl_SubgroupInvocationID & 2) == 0) {
        left = subgroupQuadBroadcast(f, 0);
        right = subgroupQuadBroadcast(f, 1);
    } else {
        left = subgroupQuadBroadcast(f, 2);
        right = subgroupQuadBroadcast(f, 3);
    }
    return right - left;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    lowp vec4 res = dFdxSubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in lowp float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
float dFdySubgroup(float f)
{
    float top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    lowp float res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
float dFdySubgroup(float f)
{
    float top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    mediump float res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
float dFdySubgroup(float f)
{
    float top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    highp float res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in lowp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
vec2 dFdySubgroup(vec2 f)
{
    vec2 top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    lowp vec2 res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
vec2 dFdySubgroup(vec2 f)
{
    vec2 top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    mediump vec2 res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
vec4 dFdySubgroup(vec4 f)
{
    vec4 top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    mediump vec4 res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec3 res = dFdx(tex.xyz) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec2 res = dFdx(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec2 res = dFdx(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec3 u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp vec3 res = dFdx(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec3 res = dFdx(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec4 u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp vec4 res = dFdx(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec4 res = dFdx(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec4 res = dFdx(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp float res = dFdxFine(tex.x) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec3 res = dFdxFine(tex.xyz) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp float res = dFdxFine(tex.x) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp vec2 res = dFdxFine(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec2 res = dFdxFine(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec3 res = dFdxFine(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec3 res = dFdxFine(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec4 res = dFdxFine(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump float res = dFdxCoarse(tex.x) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp float res = dFdxCoarse(tex.x) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec2 res = dFdxCoarse(tex.xy) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec4 res = dFdxCoarse(tex) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp float res = dFdxCoarse(tex.x) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp vec2 res = dFdxCoarse(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec3 res = dFdxCoarse(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec3 res = dFdy(tex.xyz) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump float res = dFdy(tex.x) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp float res = dFdy(tex.x) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp vec2 res = dFdy(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec2 res = dFdy(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec3 res = dFdy(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec3 res = dFdy(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec4 res = dFdy(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump float res = dFdyFine(tex.x) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp float res = dFdyFine(tex.x) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec2 res = dFdyFine(tex.xy) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec2 res = dFdyFine(tex.xy) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec3 res = dFdyFine(tex.xyz) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec4 res = dFdyFine(tex) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec4 res = dFdyFine(tex) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp float res = dFdyFine(tex.x) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec2 res = dFdyFine(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec2 res = dFdyFine(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec3 u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp vec3 res = dFdyFine(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec3 res = dFdyFine(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec4 u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp vec4 res = dFdyFine(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec4 res = dFdyFine(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec4 res = dFdyFine(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump float res = dFdyCoarse(tex.x) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec2 res = dFdyCoarse(tex.xy) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec3 res = dFdyCoarse(tex.xyz) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec3 res = dFdyCoarse(tex.xyz) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec4 res = dFdyCoarse(tex) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp vec2 res = dFdyCoarse(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec2 res = dFdyCoarse(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec2 res = dFdyCoarse(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec3 res = dFdyCoarse(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec4 res = dFdyCoarse(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec4 res = dFdyCoarse(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec2 res = fwidth(tex.xy) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec4 res = fwidth(tex) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp float res = fwidth(tex.x) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp float res = fwidth(tex.x) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec2 res = fwidth(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec3 u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp vec3 res = fwidth(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec4 u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp vec4 res = fwidth(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec4 res = fwidth(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec2 res = fwidthFine(tex.xy) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec4 res = fwidthFine(tex) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp float res = fwidthFine(tex.x) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump float res = fwidthFine(tex.x) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp float res = fwidthFine(tex.x) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp vec2 res = fwidthFine(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec2 res = fwidthFine(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec4 res = fwidthFine(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp float res = fwidthCoarse(tex.x) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec2 res = fwidthCoarse(tex.xy) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec2 res = fwidthCoarse(tex.xy) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec3 res = fwidthCoarse(tex.xyz) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec4 res = fwidthCoarse(tex) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec4 res = fwidthCoarse(tex) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump float res = fwidthCoarse(tex.x) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp float res = fwidthCoarse(tex.x) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec2 u_bias; };
layout(binding = 2) uniform lowp sampler2D u_sampler;
void main (void)
{
    lowp vec4 tex = texture(u_sampler, v_coord);
    lowp vec2 res = fwidthCoarse(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec2 res = fwidthCoarse(tex.xy) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec3 res = fwidthCoarse(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec3 res = fwidthCoarse(tex.xyz) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 1.0));
}
#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec4 res = fwidthCoarse(tex) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
