#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

vec4 getColor (void)
{
    return vec4(a_coords.xyz, 1.0);
}

void main (void)
{
    gl_Position = a_position;
    v_color = getColor();
}
#version 310 es
layout(location = 0) in mediump vec4 v_color;
layout(location = 0) out mediump vec4 o_color;

void main (void)
{
    o_color = v_color;
}
#version 310 es
layout(location = 0) in  highp   vec4 a_position;
layout(location = 1) in  highp   vec4 a_coords;
layout(location = 0) out mediump vec4 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
mediump vec4 getColor (void)
{
    return vec4(v_coords.xyz, 1.0);
}

void main (void)
{
    o_color = getColor();
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

highp vec4 getColor (void)
{
    if (true)
        return vec4(a_coords.xyz, 1.0);
    return vec4(a_coords.wzy, 1.0);
}

void main (void)
{
    gl_Position = a_position;
    v_color = getColor();
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

mediump vec4 getColor (void)
{
    if (true)
        return vec4(v_coords.xyz, 1.0);
    return vec4(v_coords.wzy, 1.0);
}

void main (void)
{
    o_color = getColor();
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

highp vec4 getColor (void)
{
    if (false)
        return vec4(a_coords.xyz, 1.0);
    return vec4(a_coords.wzy, 1.0);
}

void main (void)
{
    gl_Position = a_position;
    v_color = getColor();
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

mediump vec4 getColor (void)
{
    if (false)
        return vec4(v_coords.xyz, 1.0);
    return vec4(v_coords.wzy, 1.0);
}

void main (void)
{
    o_color = getColor();
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

highp vec4 getColor (void)
{
    if (a_coords.x+a_coords.y >= 0.0)
        return vec4(a_coords.xyz, 1.0);
    return vec4(a_coords.wzy, 1.0);
}

void main (void)
{
    gl_Position = a_position;
    v_color = getColor();
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

mediump vec4 getColor (void)
{
    if (v_coords.x+v_coords.y >= 0.0)
        return vec4(v_coords.xyz, 1.0);
    return vec4(v_coords.wzy, 1.0);
}

void main (void)
{
    o_color = getColor();
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

vec4 getColor (void)
{
    return vec4(a_coords.xyz, 1.0);
    return vec4(a_coords.wzy, 1.0);
}

void main (void)
{
    gl_Position = a_position;
    v_color = getColor();
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

mediump vec4 getColor (void)
{
    return vec4(v_coords.xyz, 1.0);
    return vec4(v_coords.wzy, 1.0);
}

void main (void)
{
    o_color = getColor();
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    v_color = vec4(a_coords.xyz, 1.0);
    return;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

void main (void)
{
    o_color = vec4(v_coords.xyz, 1.0);
    return;
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

void main ()
{
    gl_Position = a_position;
    v_color = vec4(a_coords.xyz, 1.0);
    if (true)
        return;
    v_color = vec4(a_coords.wzy, 1.0);
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

void main ()
{
    o_color = vec4(v_coords.xyz, 1.0);
    if (true)
        return;
    o_color = vec4(v_coords.wzy, 1.0);
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

void main ()
{
    gl_Position = a_position;
    v_color = vec4(a_coords.xyz, 1.0);
    if (false)
        return;
    v_color = vec4(a_coords.wzy, 1.0);
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

void main ()
{
    o_color = vec4(v_coords.xyz, 1.0);
    if (false)
        return;
    o_color = vec4(v_coords.wzy, 1.0);
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

void main ()
{
    gl_Position = a_position;
    v_color = vec4(a_coords.xyz, 1.0);
    if (a_coords.x+a_coords.y >= 0.0)
        return;
    v_color = vec4(a_coords.wzy, 1.0);
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

void main ()
{
    o_color = vec4(v_coords.xyz, 1.0);
    if (v_coords.x+v_coords.y >= 0.0)
        return;
    o_color = vec4(v_coords.wzy, 1.0);
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

void myfunc (void)
{
    v_color = vec4(a_coords.xyz, 1.0);
    if (true)
        return;
    v_color = vec4(a_coords.wzy, 1.0);
}

void main (void)
{
    gl_Position = a_position;
    myfunc();
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

void myfunc (void)
{
    o_color = vec4(v_coords.xyz, 1.0);
    if (true)
        return;
    o_color = vec4(v_coords.wzy, 1.0);
}

void main (void)
{
    myfunc();
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

void myfunc (void)
{
    v_color = vec4(a_coords.xyz, 1.0);
    if (false)
        return;
    v_color = vec4(a_coords.wzy, 1.0);
}

void main (void)
{
    gl_Position = a_position;
    myfunc();
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

void myfunc (void)
{
    o_color = vec4(v_coords.xyz, 1.0);
    if (false)
        return;
    o_color = vec4(v_coords.wzy, 1.0);
}

void main (void)
{
    myfunc();
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

void myfunc (void)
{
    v_color = vec4(a_coords.xyz, 1.0);
    if (a_coords.x+a_coords.y >= 0.0)
        return;
    v_color = vec4(a_coords.wzy, 1.0);
}

void main (void)
{
    gl_Position = a_position;
    myfunc();
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

void myfunc (void)
{
    o_color = vec4(v_coords.xyz, 1.0);
    if (v_coords.x+v_coords.y >= 0.0)
        return;
    o_color = vec4(v_coords.wzy, 1.0);
}

void main (void)
{
    myfunc();
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

highp vec4 getCoords (void)
{
    highp vec4 coords = a_coords;
    for (int i = 0; i < 1; i++)
    {
        if (true)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    gl_Position = a_position;
    v_color = vec4(getCoords().xyz, 1.0);
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) out mediump vec4 o_color;

mediump vec4 getCoords (void)
{
    mediump vec4 coords = v_coords;
    for (int i = 0; i < 1; i++)
    {
        if (true)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    o_color = vec4(getCoords().xyz, 1.0);
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

highp vec4 getCoords (void)
{
    highp vec4 coords = a_coords;
    for (int i = 0; i < 1; i++)
    {
        if (false)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    gl_Position = a_position;
    v_color = vec4(getCoords().xyz, 1.0);
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) out mediump vec4 o_color;

mediump vec4 getCoords (void)
{
    mediump vec4 coords = v_coords;
    for (int i = 0; i < 1; i++)
    {
        if (false)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    o_color = vec4(getCoords().xyz, 1.0);
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

highp vec4 getCoords (void)
{
    highp vec4 coords = a_coords;
    for (int i = 0; i < 1; i++)
    {
        if (a_coords.x+a_coords.y >= 0.0)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    gl_Position = a_position;
    v_color = vec4(getCoords().xyz, 1.0);
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) out mediump vec4 o_color;

mediump vec4 getCoords (void)
{
    mediump vec4 coords = v_coords;
    for (int i = 0; i < 1; i++)
    {
        if (v_coords.x+v_coords.y >= 0.0)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    o_color = vec4(getCoords().xyz, 1.0);
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

highp vec4 getCoords (void)
{
    highp vec4 coords = a_coords;
    for (int i = 0; i < ui_one; i++)
    {
        if (true)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    gl_Position = a_position;
    v_color = vec4(getCoords().xyz, 1.0);
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) out mediump vec4 o_color;

mediump vec4 getCoords (void)
{
    mediump vec4 coords = v_coords;
    for (int i = 0; i < ui_one; i++)
    {
        if (true)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    o_color = vec4(getCoords().xyz, 1.0);
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

highp vec4 getCoords (void)
{
    highp vec4 coords = a_coords;
    for (int i = 0; i < ui_one; i++)
    {
        if (false)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    gl_Position = a_position;
    v_color = vec4(getCoords().xyz, 1.0);
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) out mediump vec4 o_color;

mediump vec4 getCoords (void)
{
    mediump vec4 coords = v_coords;
    for (int i = 0; i < ui_one; i++)
    {
        if (false)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    o_color = vec4(getCoords().xyz, 1.0);
}
#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

highp vec4 getCoords (void)
{
    highp vec4 coords = a_coords;
    for (int i = 0; i < ui_one; i++)
    {
        if (a_coords.x+a_coords.y >= 0.0)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    gl_Position = a_position;
    v_color = vec4(getCoords().xyz, 1.0);
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) out mediump vec4 o_color;

mediump vec4 getCoords (void)
{
    mediump vec4 coords = v_coords;
    for (int i = 0; i < ui_one; i++)
    {
        if (v_coords.x+v_coords.y >= 0.0)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    o_color = vec4(getCoords().xyz, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(binding = 0, std140) uniform something { int ui_zero; };
highp vec4 getCoords (void)
{
    for (int i = 1; i < 10; i += ui_zero)
        return a_coords;
    return a_coords.wzyx;
}

void main (void)
{
    gl_Position = a_position;
    v_color = vec4(getCoords().xyz, 1.0);
    return;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform something { int ui_zero; };

mediump vec4 getCoords (void)
{
    for (int i = 1; i < 10; i += ui_zero)
        return v_coords;
    return v_coords.wzyx;
}

void main (void)
{
    o_color = vec4(getCoords().xyz, 1.0);
    return;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2: res = coords.yzw;    break;
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_color;

void main (void)
{
    o_color = v_color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out highp vec4 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2: res = coords.yzw;    break;
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2: res = coords.yzw;    break;
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2: res = coords.yzw;    break;
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2: res = coords.yzw;    break;
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2: res = coords.yzw;    break;
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    const int t = 2;
    switch (2)
    {
        case int(0.0): res = coords.xyz;    break;
        case 2-1: res = coords.wzy;    break;
        case 3&(1<<1): res = coords.yzw;    break;
        case t+1: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    const int t = 2;
    switch (2)
    {
        case int(0.0): res = coords.xyz;    break;
        case 2-1: res = coords.wzy;    break;
        case 3&(1<<1): res = coords.yzw;    break;
        case t+1: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    const int t = 2;
    switch (ui_two)
    {
        case int(0.0): res = coords.xyz;    break;
        case 2-1: res = coords.wzy;    break;
        case 3&(1<<1): res = coords.yzw;    break;
        case t+1: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    const int t = 2;
    switch (ui_two)
    {
        case int(0.0): res = coords.xyz;    break;
        case 2-1: res = coords.wzy;    break;
        case 3&(1<<1): res = coords.yzw;    break;
        case t+1: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    const int t = 2;
    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case int(0.0): res = coords.xyz;    break;
        case 2-1: res = coords.wzy;    break;
        case 3&(1<<1): res = coords.yzw;    break;
        case t+1: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    const int t = 2;
    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case int(0.0): res = coords.xyz;    break;
        case 2-1: res = coords.wzy;    break;
        case 3&(1<<1): res = coords.yzw;    break;
        case t+1: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
        default: res = coords.yzw;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
        default: res = coords.yzw;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
        default: res = coords.yzw;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
        default: res = coords.yzw;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
        default: res = coords.yzw;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
        default: res = coords.yzw;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        default: res = coords.yzw;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        default: res = coords.yzw;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        default: res = coords.yzw;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        default: res = coords.yzw;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        default: res = coords.yzw;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        default: res = coords.yzw;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    res = coords.yzw;

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    res = coords.yzw;

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    res = coords.yzw;

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    res = coords.yzw;

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    res = coords.yzw;

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    res = coords.yzw;

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        default:
            res = coords.yzw;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        default:
            res = coords.yzw;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        default:
            res = coords.yzw;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        default:
            res = coords.yzw;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 2:
        default:
            res = coords.yzw;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 2:
        default:
            res = coords.yzw;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 2:
        default:
            res = coords.yzw;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 2:
        default:
            res = coords.yzw;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2: coords = coords.yzwx;
        case 4: res = vec3(coords);    break;
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2: coords = coords.yzwx;
        case 4: res = vec3(coords);    break;
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2: coords = coords.yzwx;
        case 4: res = vec3(coords);    break;
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2: coords = coords.yzwx;
        case 4: res = vec3(coords);    break;
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2: coords = coords.yzwx;
        case 4: res = vec3(coords);    break;
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2: coords = coords.yzwx;
        case 4: res = vec3(coords);    break;
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
        case 2: coords = coords.yzwx;
        default: res = vec3(coords);
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
        case 2: coords = coords.yzwx;
        default: res = vec3(coords);
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
        case 2: coords = coords.yzwx;
        default: res = vec3(coords);
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
        case 2: coords = coords.yzwx;
        default: res = vec3(coords);
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
        case 2: coords = coords.yzwx;
        default: res = vec3(coords);
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 3: res = coords.zyx;    break;
        case 2: coords = coords.yzwx;
        default: res = vec3(coords);
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (2 != 3)
                break;
        default: res = tmp.zyx;        break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (2 != 3)
                break;
        default: res = tmp.zyx;        break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (ui_two != 3)
                break;
        default: res = tmp.zyx;        break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (ui_two != 3)
                break;
        default: res = tmp.zyx;        break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (int(floor(coords.z*1.5 + 2.0)) != 3)
                break;
        default: res = tmp.zyx;        break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (int(floor(coords.z*1.5 + 2.0)) != 3)
                break;
        default: res = tmp.zyx;        break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    mediump int c = 2;
    switch (c)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            c += 2;
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (c == 4)
                break;
        default: res = tmp.zyx;        break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    mediump int c = 2;
    switch (c)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            c += 2;
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (c == 4)
                break;
        default: res = tmp.zyx;        break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    mediump int c = ui_two;
    switch (c)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            c += ui_two;
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (c == 4)
                break;
        default: res = tmp.zyx;        break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    mediump int c = ui_two;
    switch (c)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            c += ui_two;
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (c == 4)
                break;
        default: res = tmp.zyx;        break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    mediump int c = int(floor(coords.z*1.5 + 2.0));
    switch (c)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            c += int(floor(coords.z*1.5 + 2.0));
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (c == 4)
                break;
        default: res = tmp.zyx;        break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    mediump int c = int(floor(coords.z*1.5 + 2.0));
    switch (c)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            c += int(floor(coords.z*1.5 + 2.0));
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (c == 4)
                break;
        default: res = tmp.zyx;        break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
        {
            mediump vec3 t = coords.yzw;
            res = t;
            break;
        }
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
        {
            mediump vec3 t = coords.yzw;
            res = t;
            break;
        }
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
        {
            mediump vec3 t = coords.yzw;
            res = t;
            break;
        }
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
        {
            mediump vec3 t = coords.yzw;
            res = t;
            break;
        }
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
        {
            mediump vec3 t = coords.yzw;
            res = t;
            break;
        }
        case 3: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
        {
            mediump vec3 t = coords.yzw;
            res = t;
            break;
        }
        case 3: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    if (2 >= 0)
    {
        switch (2)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    if (2 >= 0)
    {
        switch (2)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    if (ui_two >= 0)
    {
        switch (ui_two)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    if (ui_two >= 0)
    {
        switch (ui_two)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    if (int(floor(coords.z*1.5 + 2.0)) >= 0)
    {
        switch (int(floor(coords.z*1.5 + 2.0)))
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    if (int(floor(coords.z*1.5 + 2.0)) >= 0)
    {
        switch (int(floor(coords.z*1.5 + 2.0)))
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    for (int i = 0; i <= 2; i++)
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    for (int i = 0; i <= 2; i++)
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    for (int i = 0; i <= ui_two; i++)
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    for (int i = 0; i <= ui_two; i++)
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    for (int i = 0; i <= int(floor(coords.z*1.5 + 2.0)); i++)
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    for (int i = 0; i <= int(floor(coords.z*1.5 + 2.0)); i++)
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    while (i <= 2)
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    while (i <= 2)
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    while (i <= ui_two)
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    while (i <= ui_two)
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    while (i <= int(floor(coords.z*1.5 + 2.0)))
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    while (i <= int(floor(coords.z*1.5 + 2.0)))
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    do
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    } while (i <= 2);

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    do
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    } while (i <= 2);

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    do
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    } while (i <= ui_two);

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    do
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    } while (i <= ui_two);

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    do
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    } while (i <= int(floor(coords.z*1.5 + 2.0)));

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    do
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    } while (i <= int(floor(coords.z*1.5 + 2.0)));

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        default:
            if (2 == 2)
                res = coords.yzw;
            else
                res = coords.zyx;
            break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        default:
            if (2 == 2)
                res = coords.yzw;
            else
                res = coords.zyx;
            break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        default:
            if (ui_two == 2)
                res = coords.yzw;
            else
                res = coords.zyx;
            break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        default:
            if (ui_two == 2)
                res = coords.yzw;
            else
                res = coords.zyx;
            break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        default:
            if (int(floor(coords.z*1.5 + 2.0)) == 2)
                res = coords.yzw;
            else
                res = coords.zyx;
            break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        default:
            if (int(floor(coords.z*1.5 + 2.0)) == 2)
                res = coords.yzw;
            else
                res = coords.zyx;
            break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            for (int i = 0; i < 2; i++)
                t = t.zyx;
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            for (int i = 0; i < 2; i++)
                t = t.zyx;
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            for (int i = 0; i < ui_two; i++)
                t = t.zyx;
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            for (int i = 0; i < ui_two; i++)
                t = t.zyx;
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            for (int i = 0; i < int(floor(coords.z*1.5 + 2.0)); i++)
                t = t.zyx;
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            for (int i = 0; i < int(floor(coords.z*1.5 + 2.0)); i++)
                t = t.zyx;
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            while (i < 2)
            {
                t = t.zyx;
                i += 1;
            }
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            while (i < 2)
            {
                t = t.zyx;
                i += 1;
            }
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            while (i < ui_two)
            {
                t = t.zyx;
                i += 1;
            }
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            while (i < ui_two)
            {
                t = t.zyx;
                i += 1;
            }
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            while (i < int(floor(coords.z*1.5 + 2.0)))
            {
                t = t.zyx;
                i += 1;
            }
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            while (i < int(floor(coords.z*1.5 + 2.0)))
            {
                t = t.zyx;
                i += 1;
            }
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            do
            {
                t = t.zyx;
                i += 1;
            } while (i < 2);
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            do
            {
                t = t.zyx;
                i += 1;
            } while (i < 2);
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            do
            {
                t = t.zyx;
                i += 1;
            } while (i < ui_two);
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            do
            {
                t = t.zyx;
                i += 1;
            } while (i < ui_two);
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            do
            {
                t = t.zyx;
                i += 1;
            } while (i < int(floor(coords.z*1.5 + 2.0)));
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            do
            {
                t = t.zyx;
                i += 1;
            } while (i < int(floor(coords.z*1.5 + 2.0)));
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
            switch (2 - 1)
            {
                case 0: res = coords.wzy;    break;
                case 1: res = coords.yzw;    break;
            }
            break;
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
            switch (2 - 1)
            {
                case 0: res = coords.wzy;    break;
                case 1: res = coords.yzw;    break;
            }
            break;
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
            switch (ui_two - 1)
            {
                case 0: res = coords.wzy;    break;
                case 1: res = coords.yzw;    break;
            }
            break;
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
            switch (ui_two - 1)
            {
                case 0: res = coords.wzy;    break;
                case 1: res = coords.yzw;    break;
            }
            break;
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
            switch (int(floor(coords.z*1.5 + 2.0)) - 1)
            {
                case 0: res = coords.wzy;    break;
                case 1: res = coords.yzw;    break;
            }
            break;
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
            switch (int(floor(coords.z*1.5 + 2.0)) - 1)
            {
                case 0: res = coords.wzy;    break;
                case 1: res = coords.yzw;    break;
            }
            break;
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
#version 310 es
layout(location=0) in  highp   vec4 a_position;
layout(location=1) in  highp   vec4 a_coords;
layout(location=2) in  highp   vec4 a_one;
layout(location=0) out mediump vec4 v_color;
layout(location=1) out mediump vec4 v_coords;

layout(location=2) out mediump vec4 v_one;
void main (void)
{
    gl_Position = a_position;
    v_color = vec4(a_coords.xyz, 1.0);
    v_coords = a_coords;
    v_one = a_one;
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    discard;
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    if (false) discard;
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    if (ui_one > 0) discard;
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    if (v_coords.x+v_coords.y > 0.0) discard;
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    if (texture(ut_brick, v_coords.xy*0.25+0.5).x < 0.7) discard;
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    discard;
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    if (false) discard;
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    if (ui_one > 0) discard;
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    if (v_coords.x+v_coords.y > 0.0) discard;
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    if (texture(ut_brick, v_coords.xy*0.25+0.5).x < 0.7) discard;
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            discard;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (false) discard;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (ui_one > 0) discard;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (v_coords.x+v_coords.y > 0.0) discard;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (texture(ut_brick, v_coords.xy*0.25+0.5).x < 0.7) discard;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < ui_two; i++)
    {
        if (i > 0) {
            discard;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < ui_two; i++)
    {
        if (i > 0) {
            if (false) discard;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < ui_two; i++)
    {
        if (i > 0) {
            if (ui_one > 0) discard;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < ui_two; i++)
    {
        if (i > 0) {
            if (v_coords.x+v_coords.y > 0.0) discard;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < ui_two; i++)
    {
        if (i > 0) {
            if (texture(ut_brick, v_coords.xy*0.25+0.5).x < 0.7) discard;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            discard;
        }
    }
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (false) discard;
        }
    }
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (ui_one > 0) discard;
        }
    }
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (v_coords.x+v_coords.y > 0.0) discard;
        }
    }
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (texture(ut_brick, v_coords.xy*0.25+0.5).x < 0.7) discard;
        }
    }
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    demote;
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    if (false) demote;
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    if (ui_one > 0) demote;
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    if (v_coords.x+v_coords.y > 0.0) demote;
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    if (texture(ut_brick, v_coords.xy*0.25+0.5).x < 0.7) demote;
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
      ivec2 f = ivec2(gl_FragCoord.xy);
  int lsb = (f.x | f.y)&1;
  if (lsb != 0) demote;
  bool isHelper = helperInvocationEXT();
  highp vec2 dx = dFdx(a_one.xy + gl_FragCoord.xy);
  highp vec2 dy = dFdy(a_one.xy + gl_FragCoord.xy);
  highp float dh = dFdx(float(isHelper));
  bool valid = abs(dx.x-1.0) < 0.01 && dx.y == 0.0 && dy.x == 0.0 && abs(dy.y-1.0) < 0.01 && abs(dh-1.0) < 0.1 && !isHelper;
  if (valid) demote;
  o_color = vec4(1,0,0,1);
;
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    demote;
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    if (false) demote;
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    if (ui_one > 0) demote;
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    if (v_coords.x+v_coords.y > 0.0) demote;
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    if (texture(ut_brick, v_coords.xy*0.25+0.5).x < 0.7) demote;
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
      ivec2 f = ivec2(gl_FragCoord.xy);
  int lsb = (f.x | f.y)&1;
  if (lsb != 0) demote;
  bool isHelper = helperInvocationEXT();
  highp vec2 dx = dFdx(a_one.xy + gl_FragCoord.xy);
  highp vec2 dy = dFdy(a_one.xy + gl_FragCoord.xy);
  highp float dh = dFdx(float(isHelper));
  bool valid = abs(dx.x-1.0) < 0.01 && dx.y == 0.0 && dy.x == 0.0 && abs(dy.y-1.0) < 0.01 && abs(dh-1.0) < 0.1 && !isHelper;
  if (valid) demote;
  o_color = vec4(1,0,0,1);
;
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            demote;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (false) demote;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (ui_one > 0) demote;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (v_coords.x+v_coords.y > 0.0) demote;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (texture(ut_brick, v_coords.xy*0.25+0.5).x < 0.7) demote;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
              ivec2 f = ivec2(gl_FragCoord.xy);
  int lsb = (f.x | f.y)&1;
  if (lsb != 0) demote;
  bool isHelper = helperInvocationEXT();
  highp vec2 dx = dFdx(a_one.xy + gl_FragCoord.xy);
  highp vec2 dy = dFdy(a_one.xy + gl_FragCoord.xy);
  highp float dh = dFdx(float(isHelper));
  bool valid = abs(dx.x-1.0) < 0.01 && dx.y == 0.0 && dy.x == 0.0 && abs(dy.y-1.0) < 0.01 && abs(dh-1.0) < 0.1 && !isHelper;
  if (valid) demote;
  o_color = vec4(1,0,0,1);
;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < ui_two; i++)
    {
        if (i > 0) {
            demote;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < ui_two; i++)
    {
        if (i > 0) {
            if (false) demote;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < ui_two; i++)
    {
        if (i > 0) {
            if (ui_one > 0) demote;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < ui_two; i++)
    {
        if (i > 0) {
            if (v_coords.x+v_coords.y > 0.0) demote;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < ui_two; i++)
    {
        if (i > 0) {
            if (texture(ut_brick, v_coords.xy*0.25+0.5).x < 0.7) demote;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < ui_two; i++)
    {
        if (i > 0) {
              ivec2 f = ivec2(gl_FragCoord.xy);
  int lsb = (f.x | f.y)&1;
  if (lsb != 0) demote;
  bool isHelper = helperInvocationEXT();
  highp vec2 dx = dFdx(a_one.xy + gl_FragCoord.xy);
  highp vec2 dy = dFdy(a_one.xy + gl_FragCoord.xy);
  highp float dh = dFdx(float(isHelper));
  bool valid = abs(dx.x-1.0) < 0.01 && dx.y == 0.0 && dy.x == 0.0 && abs(dy.y-1.0) < 0.01 && abs(dh-1.0) < 0.1 && !isHelper;
  if (valid) demote;
  o_color = vec4(1,0,0,1);
;
        }
    }
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            demote;
        }
    }
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (false) demote;
        }
    }
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (ui_one > 0) demote;
        }
    }
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (v_coords.x+v_coords.y > 0.0) demote;
        }
    }
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
            if (texture(ut_brick, v_coords.xy*0.25+0.5).x < 0.7) demote;
        }
    }
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void myfunc (void)
{
    for (int i = 0; i < 2; i++)
    {
        if (i > 0) {
              ivec2 f = ivec2(gl_FragCoord.xy);
  int lsb = (f.x | f.y)&1;
  if (lsb != 0) demote;
  bool isHelper = helperInvocationEXT();
  highp vec2 dx = dFdx(a_one.xy + gl_FragCoord.xy);
  highp vec2 dy = dFdy(a_one.xy + gl_FragCoord.xy);
  highp float dh = dFdx(float(isHelper));
  bool valid = abs(dx.x-1.0) < 0.01 && dx.y == 0.0 && dy.x == 0.0 && abs(dy.y-1.0) < 0.01 && abs(dh-1.0) < 0.1 && !isHelper;
  if (valid) demote;
  o_color = vec4(1,0,0,1);
;
        }
    }
}

void main (void)
{
    o_color = v_color;
    myfunc();
}
