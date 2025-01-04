#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump float a_coords;
layout(location = 1) out mediump float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);

void main (void)
{
    mediump mat2 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const mediump mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = in0 + in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) in mediump vec4 v_color;

void main (void)
{
    dEQP_FragColor = v_color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = in0 + a_coords;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 1) out highp float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);

void main (void)
{
    highp mat2 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const highp mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = in0 + in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);

void main (void)
{
    mediump mat2x3 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);

void main (void)
{
    highp mat2x3 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const highp mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = in0 + in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const mediump mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = in0 + in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = in0 + a_coords;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);

void main (void)
{
    mediump mat3x2 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);
const mediump mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = in0 + in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = in0 + a_coords;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);

void main (void)
{
    highp mat3x2 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = in0 + a_coords;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = in0 + a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);

void main (void)
{
    mediump mat3x4 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const mediump mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    mediump mat3x4 res = in0 + in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = in0 + a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);

void main (void)
{
    highp mat3x4 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const highp mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = in0 + in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const highp mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    highp mat3x4 res = in0 + in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);

void main (void)
{
    mediump mat4x2 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
const mediump mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = in0 + in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);

void main (void)
{
    highp mat4x2 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const mediump mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = in0 + in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const mediump mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    mediump mat4x3 res = in0 + in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const highp mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    highp mat4x3 res = in0 + in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);

void main (void)
{
    mediump mat4 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const mediump mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = in0 + in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const mediump mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    mediump mat4 res = in0 + in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = in0 + a_coords;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);

void main (void)
{
    highp mat4 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const highp mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = in0 + in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const highp mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    highp mat4 res = in0 + in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2 u_in0; };

void main (void)
{
    mediump mat2 res = u_in0 + v_coords;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = u_in0 + a_coords;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2 u_in0; };

void main (void)
{
    highp mat2 res = u_in0 + v_coords;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = u_in0 + u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    highp mat2 res = u_in0 + u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = u_in0 + u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x3 u_in0; };

void main (void)
{
    highp mat2x3 res = u_in0 + v_coords;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = u_in0 + u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    highp mat2x3 res = u_in0 + u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };

void main (void)
{
    mediump mat2x4 res = u_in0 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    highp mat2x4 res = u_in0 + u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x2 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = u_in0 + a_coords;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x2 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = u_in0 + a_coords;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x2 u_in0; };

void main (void)
{
    highp mat3x2 res = u_in0 + v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    highp mat3x2 res = u_in0 + u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = u_in0 + u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = u_in0 + a_coords;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    highp mat3 res = u_in0 + u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x4 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = u_in0 + a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = u_in0 + u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    mediump mat3x4 res = u_in0 + u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x4 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = u_in0 + a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x4 u_in0; };

void main (void)
{
    highp mat3x4 res = u_in0 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = u_in0 + u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x2 u_in0; };

void main (void)
{
    highp mat4x2 res = u_in0 + v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    highp mat4x2 res = u_in0 + u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };

void main (void)
{
    mediump mat4x3 res = u_in0 + v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump mat4x3 res = u_in0 + u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4 u_in0; };

void main (void)
{
    mediump mat4 res = u_in0 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    mediump mat4 res = u_in0 + u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = u_in0 + a_coords;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4 u_in0; };

void main (void)
{
    highp mat4 res = u_in0 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = u_in0 + u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat2 a_mat2;
layout(location = 1) out mediump mat2 v_mat2;
layout(location = 1) in mediump float a_coords;
layout(location = 3) out mediump float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat2 = a_mat2;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;
layout(location = 3) in mediump float v_coords;

void main (void)
{
    mediump mat2 res = v_mat2 + v_coords;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat2 a_mat2;
layout(location = 1) out mediump mat2 v_mat2;

void main (void)
{
    gl_Position = a_position;
    v_mat2 = a_mat2;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    mediump mat2 res = v_mat2 + u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2 a_mat2;
layout(location = 1) in highp float a_coords;

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = a_mat2 + a_coords;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat2 a_mat2;
layout(location = 1) out highp mat2 v_mat2;
layout(location = 1) in highp float a_coords;
layout(location = 3) out highp float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat2 = a_mat2;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;
layout(location = 3) in highp float v_coords;

void main (void)
{
    highp mat2 res = v_mat2 + v_coords;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2 a_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = a_mat2 + u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat2 a_mat2;
layout(location = 1) out highp mat2 v_mat2;

void main (void)
{
    gl_Position = a_position;
    v_mat2 = a_mat2;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    highp mat2 res = v_mat2 + u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat2x3 a_mat2x3;
layout(location = 1) out highp mat2x3 v_mat2x3;
layout(location = 1) in highp float a_coords;
layout(location = 3) out highp float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat2x3 = a_mat2x3;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;
layout(location = 3) in highp float v_coords;

void main (void)
{
    highp mat2x3 res = v_mat2x3 + v_coords;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat2x4 a_mat2x4;
layout(location = 1) out mediump mat2x4 v_mat2x4;
layout(location = 1) in mediump float a_coords;
layout(location = 3) out mediump float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat2x4 = a_mat2x4;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x4 v_mat2x4;
layout(location = 3) in mediump float v_coords;

void main (void)
{
    mediump mat2x4 res = v_mat2x4 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = a_mat2x4 + u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = a_mat2x4 + u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = a_mat3x2 + a_coords;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = a_mat3x2 + u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x2 a_mat3x2;
layout(location = 1) in highp float a_coords;

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = a_mat3x2 + a_coords;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat3x2 a_mat3x2;
layout(location = 1) out highp mat3x2 v_mat3x2;
layout(location = 1) in highp float a_coords;
layout(location = 4) out highp float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat3x2 = a_mat3x2;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;
layout(location = 4) in highp float v_coords;

void main (void)
{
    highp mat3x2 res = v_mat3x2 + v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = a_mat3x2 + u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = a_mat3 + u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat3 a_mat3;
layout(location = 1) out mediump mat3 v_mat3;

void main (void)
{
    gl_Position = a_position;
    v_mat3 = a_mat3;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    mediump mat3 res = v_mat3 + u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3 a_mat3;
layout(location = 1) in highp float a_coords;

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = a_mat3 + a_coords;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat3 a_mat3;
layout(location = 1) out highp mat3 v_mat3;

void main (void)
{
    gl_Position = a_position;
    v_mat3 = a_mat3;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    highp mat3 res = v_mat3 + u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = a_mat3x4 + a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat3x4 a_mat3x4;
layout(location = 1) out mediump mat3x4 v_mat3x4;

void main (void)
{
    gl_Position = a_position;
    v_mat3x4 = a_mat3x4;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    mediump mat3x4 res = v_mat3x4 + u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x4 a_mat3x4;
layout(location = 1) in highp float a_coords;

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = a_mat3x4 + a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat3x4 a_mat3x4;
layout(location = 1) out highp mat3x4 v_mat3x4;
layout(location = 1) in highp float a_coords;
layout(location = 4) out highp float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat3x4 = a_mat3x4;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;
layout(location = 4) in highp float v_coords;

void main (void)
{
    highp mat3x4 res = v_mat3x4 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat3x4 a_mat3x4;
layout(location = 1) out highp mat3x4 v_mat3x4;

void main (void)
{
    gl_Position = a_position;
    v_mat3x4 = a_mat3x4;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    highp mat3x4 res = v_mat3x4 + u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x2 a_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = a_mat4x2 + u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat4x2 a_mat4x2;
layout(location = 1) out highp mat4x2 v_mat4x2;
layout(location = 1) in highp float a_coords;
layout(location = 5) out highp float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4x2 = a_mat4x2;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;
layout(location = 5) in highp float v_coords;

void main (void)
{
    highp mat4x2 res = v_mat4x2 + v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x2 a_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = a_mat4x2 + u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat4x3 a_mat4x3;
layout(location = 1) out mediump mat4x3 v_mat4x3;
layout(location = 1) in mediump float a_coords;
layout(location = 5) out mediump float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4x3 = a_mat4x3;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;
layout(location = 5) in mediump float v_coords;

void main (void)
{
    mediump mat4x3 res = v_mat4x3 + v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x3 a_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = a_mat4x3 + u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat4x3 a_mat4x3;
layout(location = 1) out mediump mat4x3 v_mat4x3;

void main (void)
{
    gl_Position = a_position;
    v_mat4x3 = a_mat4x3;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump mat4x3 res = v_mat4x3 + u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = a_mat4x3 + u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat4x3 a_mat4x3;
layout(location = 1) out highp mat4x3 v_mat4x3;

void main (void)
{
    gl_Position = a_position;
    v_mat4x3 = a_mat4x3;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    highp mat4x3 res = v_mat4x3 + u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat4 a_mat4;
layout(location = 1) out mediump mat4 v_mat4;
layout(location = 1) in mediump float a_coords;
layout(location = 5) out mediump float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4 = a_mat4;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;
layout(location = 5) in mediump float v_coords;

void main (void)
{
    mediump mat4 res = v_mat4 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4 a_mat4;
layout(location = 1) in highp float a_coords;

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = a_mat4 + a_coords;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat4 a_mat4;
layout(location = 1) out highp mat4 v_mat4;
layout(location = 1) in highp float a_coords;
layout(location = 5) out highp float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4 = a_mat4;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;
layout(location = 5) in highp float v_coords;

void main (void)
{
    highp mat4 res = v_mat4 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4 a_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = a_mat4 + u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = in0 - a_coords;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);

void main (void)
{
    mediump mat2 res = in0 - v_coords;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const highp mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    highp mat2 res = in0 - in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = in0 - a_coords;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);

void main (void)
{
    highp mat2x3 res = in0 - v_coords;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const highp mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = in0 - in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);

void main (void)
{
    mediump mat2x4 res = in0 - v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const mediump mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = in0 - in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = in0 - a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = in0 - a_coords;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);
const mediump mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = in0 - in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);

void main (void)
{
    highp mat3x2 res = in0 - v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = in0 - a_coords;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
const mediump mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = in0 - in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);

void main (void)
{
    highp mat3 res = in0 - v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
const highp mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = in0 - in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
const highp mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    highp mat3 res = in0 - in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = in0 - a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const mediump mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    mediump mat3x4 res = in0 - in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);

void main (void)
{
    highp mat3x4 res = in0 - v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const highp mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = in0 - in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const highp mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    highp mat3x4 res = in0 - in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
const mediump mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = in0 - in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = in0 - a_coords;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);

void main (void)
{
    highp mat4x2 res = in0 - v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);

void main (void)
{
    mediump mat4x3 res = in0 - v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const mediump mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = in0 - in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const mediump mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    mediump mat4x3 res = in0 - in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = in0 - a_coords;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const highp mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    highp mat4x3 res = in0 - in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = in0 - a_coords;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);

void main (void)
{
    mediump mat4 res = in0 - v_coords;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const mediump mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    mediump mat4 res = in0 - in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2 u_in0; };

void main (void)
{
    highp mat2 res = u_in0 - v_coords;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    highp mat2 res = u_in0 - u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x3 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = u_in0 - a_coords;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x3 u_in0; };

void main (void)
{
    mediump mat2x3 res = u_in0 - v_coords;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = u_in0 - u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = u_in0 - u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    highp mat2x3 res = u_in0 - u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = u_in0 - a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x4 u_in0; };

void main (void)
{
    highp mat2x4 res = u_in0 - v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    highp mat2x4 res = u_in0 - u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x2 u_in0; };

void main (void)
{
    mediump mat3x2 res = u_in0 - v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x2 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = u_in0 - a_coords;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    highp mat3x2 res = u_in0 - u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3 u_in0; };

void main (void)
{
    mediump mat3 res = u_in0 - v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = u_in0 - u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = u_in0 - u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    highp mat3 res = u_in0 - u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x4 u_in0; };

void main (void)
{
    mediump mat3x4 res = u_in0 - v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = u_in0 - u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    mediump mat3x4 res = u_in0 - u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x4 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = u_in0 - a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = u_in0 - u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x2 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = u_in0 - a_coords;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x2 u_in0; };

void main (void)
{
    mediump mat4x2 res = u_in0 - v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    highp mat4x2 res = u_in0 - u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = u_in0 - a_coords;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump mat4x3 res = u_in0 - u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x3 u_in0; };

void main (void)
{
    highp mat4x3 res = u_in0 - v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    mediump mat4 res = u_in0 - u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4 u_in0; };

void main (void)
{
    highp mat4 res = u_in0 - v_coords;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    mediump mat2 res = v_mat2 - u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;
layout(location = 3) in highp float v_coords;

void main (void)
{
    highp mat2 res = v_mat2 - v_coords;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    highp mat2 res = v_mat2 - u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x3 a_mat2x3;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = a_mat2x3 - a_coords;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat2x3 a_mat2x3;
layout(location = 1) out mediump mat2x3 v_mat2x3;
layout(location = 1) in mediump float a_coords;
layout(location = 3) out mediump float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat2x3 = a_mat2x3;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x3 v_mat2x3;
layout(location = 3) in mediump float v_coords;

void main (void)
{
    mediump mat2x3 res = v_mat2x3 - v_coords;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x4 a_mat2x4;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = a_mat2x4 - a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = a_mat2x4 - u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat2x4 a_mat2x4;
layout(location = 1) out highp mat2x4 v_mat2x4;
layout(location = 1) in highp float a_coords;
layout(location = 3) out highp float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat2x4 = a_mat2x4;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x4 v_mat2x4;
layout(location = 3) in highp float v_coords;

void main (void)
{
    highp mat2x4 res = v_mat2x4 - v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = a_mat2x4 - u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(location = 1) out mediump mat3x2 v_mat3x2;
layout(location = 1) in mediump float a_coords;
layout(location = 4) out mediump float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat3x2 = a_mat3x2;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x2 v_mat3x2;
layout(location = 4) in mediump float v_coords;

void main (void)
{
    mediump mat3x2 res = v_mat3x2 - v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = a_mat3x2 - u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x2 a_mat3x2;
layout(location = 1) in highp float a_coords;

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = a_mat3x2 - a_coords;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = a_mat3x2 - u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat3 a_mat3;
layout(location = 1) out mediump mat3 v_mat3;
layout(location = 1) in mediump float a_coords;
layout(location = 4) out mediump float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat3 = a_mat3;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;
layout(location = 4) in mediump float v_coords;

void main (void)
{
    mediump mat3 res = v_mat3 - v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = a_mat3 - u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    mediump mat3 res = v_mat3 - u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3 a_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = a_mat3 - u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    highp mat3 res = v_mat3 - u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat3x4 a_mat3x4;
layout(location = 1) out mediump mat3x4 v_mat3x4;
layout(location = 1) in mediump float a_coords;
layout(location = 4) out mediump float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat3x4 = a_mat3x4;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;
layout(location = 4) in mediump float v_coords;

void main (void)
{
    mediump mat3x4 res = v_mat3x4 - v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    mediump mat3x4 res = v_mat3x4 - u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x4 a_mat3x4;
layout(location = 1) in highp float a_coords;

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = a_mat3x4 - a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    highp mat3x4 res = v_mat3x4 - u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x2 a_mat4x2;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = a_mat4x2 - a_coords;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat4x2 a_mat4x2;
layout(location = 1) out mediump mat4x2 v_mat4x2;
layout(location = 1) in mediump float a_coords;
layout(location = 5) out mediump float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4x2 = a_mat4x2;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;
layout(location = 5) in mediump float v_coords;

void main (void)
{
    mediump mat4x2 res = v_mat4x2 - v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x2 a_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = a_mat4x2 - u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x2 a_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = a_mat4x2 - u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x3 a_mat4x3;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = a_mat4x3 - a_coords;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x3 a_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = a_mat4x3 - u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump mat4x3 res = v_mat4x3 - u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat4x3 a_mat4x3;
layout(location = 1) out highp mat4x3 v_mat4x3;
layout(location = 1) in highp float a_coords;
layout(location = 5) out highp float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4x3 = a_mat4x3;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x3 v_mat4x3;
layout(location = 5) in highp float v_coords;

void main (void)
{
    highp mat4x3 res = v_mat4x3 - v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = a_mat4x3 - u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    highp mat4x3 res = v_mat4x3 - u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;
layout(location = 5) in highp float v_coords;

void main (void)
{
    highp mat4 res = v_mat4 - v_coords;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = in0 * a_coords;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec2 a_coords;
layout(location = 1) out mediump vec2 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);

void main (void)
{
    mediump vec2 res = in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
const mediump mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = a_coords * in1;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
const mediump mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    mediump vec2 res = v_coords * in1;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const mediump mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = in0 * in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const mediump mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    mediump mat2 res = in0 * in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const mediump mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    mediump mat3x2 res = in0 * in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const mediump mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = in0 * in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = in0 * a_coords;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec2 a_coords;
const highp mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    gl_Position = a_position;
    highp vec2 res = a_coords * in1;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const highp mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = in0 * in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const highp mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = in0 * in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const highp mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    highp mat4x2 res = in0 * in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = in0 * a_coords;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
const mediump mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);

void main (void)
{
    gl_Position = a_position;
    mediump vec3 res = in0 * a_coords;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const mediump mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = in0 * in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const mediump mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    mediump mat4x3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = in0 * a_coords;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 1) out highp vec2 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec2 v_coords;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);

void main (void)
{
    highp vec3 res = in0 * v_coords;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec3 a_coords;
const highp mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    gl_Position = a_position;
    highp vec2 res = a_coords * in1;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 1) out highp vec3 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec3 v_coords;
const highp mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    highp vec2 res = v_coords * in1;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const highp mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = in0 * in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const highp mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    highp mat2x3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const highp mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = in0 * in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const highp mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    highp mat4x3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = in0 * a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);

void main (void)
{
    mediump mat2x4 res = in0 * v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = in0 * a_coords;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
const mediump mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = a_coords * in1;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const mediump mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = in0 * in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const mediump mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    mediump mat3x4 res = in0 * in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = in0 * a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);

void main (void)
{
    highp mat2x4 res = in0 * v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec2 v_coords;
const highp mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);

void main (void)
{
    highp vec4 res = in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 1) out highp vec4 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
const highp mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    highp vec2 res = v_coords * in1;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const highp mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = in0 * in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const highp mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    highp mat2x4 res = in0 * in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const highp mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    highp mat3x4 res = in0 * in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const highp mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = in0 * in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec3 a_coords;
layout(location = 1) out mediump vec3 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);

void main (void)
{
    mediump vec2 res = in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);
const mediump mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = in0 * in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);
const mediump mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    mediump mat3x2 res = in0 * in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);
const mediump mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = in0 * in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec3 a_coords;
const highp mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);

void main (void)
{
    gl_Position = a_position;
    highp vec2 res = in0 * a_coords;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec2 a_coords;
const highp mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    gl_Position = a_position;
    highp vec3 res = a_coords * in1;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec2 v_coords;
const highp mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    highp vec3 res = v_coords * in1;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);
const highp mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = in0 * in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = in0 * a_coords;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);

void main (void)
{
    mediump mat3 res = in0 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec3 a_coords;
const mediump mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);

void main (void)
{
    gl_Position = a_position;
    mediump vec3 res = in0 * a_coords;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
const mediump mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);

void main (void)
{
    mediump vec3 res = in0 * v_coords;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
const mediump mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    mediump vec3 res = v_coords * in1;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
const mediump mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    mediump mat2x3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
const mediump mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    mediump mat3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
const mediump mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = in0 * in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
const mediump mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    mediump mat4x3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = in0 * a_coords;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);

void main (void)
{
    highp mat3 res = in0 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec3 a_coords;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);

void main (void)
{
    gl_Position = a_position;
    highp vec3 res = in0 * a_coords;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
const highp mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = in0 * in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec3 a_coords;
const mediump mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = in0 * a_coords;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
const mediump mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);

void main (void)
{
    mediump vec4 res = in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
const mediump mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    gl_Position = a_position;
    mediump vec3 res = a_coords * in1;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec4 a_coords;
layout(location = 1) out mediump vec4 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec4 v_coords;
const mediump mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    mediump vec3 res = v_coords * in1;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const mediump mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    mediump mat3x4 res = in0 * in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const mediump mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = in0 * in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const highp mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = in0 * in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const highp mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = in0 * in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = in0 * a_coords;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
const mediump mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = in0 * a_coords;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec4 v_coords;
const mediump mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);

void main (void)
{
    mediump vec2 res = in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
const mediump mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = a_coords * in1;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
const mediump mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    mediump vec4 res = v_coords * in1;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
const mediump mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    mediump mat3x2 res = in0 * in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
const mediump mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    mediump mat4x2 res = in0 * in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = in0 * a_coords;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
const highp mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = in0 * in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
const highp mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = in0 * in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
const highp mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    highp mat3x2 res = in0 * in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
const highp mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = in0 * in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = in0 * a_coords;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);

void main (void)
{
    mediump mat4x3 res = in0 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec4 v_coords;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);

void main (void)
{
    mediump vec3 res = in0 * v_coords;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec3 a_coords;
const mediump mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = a_coords * in1;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const mediump mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    mediump mat2x3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const mediump mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = in0 * in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const mediump mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    mediump mat4x3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = in0 * a_coords;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);

void main (void)
{
    highp mat4x3 res = in0 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec4 a_coords;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);

void main (void)
{
    gl_Position = a_position;
    highp vec3 res = in0 * a_coords;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec3 v_coords;
const highp mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    highp vec4 res = v_coords * in1;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const highp mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = in0 * in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const highp mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    highp mat2x3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const highp mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = in0 * in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = in0 * a_coords;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
const mediump mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = a_coords * in1;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const mediump mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = in0 * in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const mediump mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    mediump mat2x4 res = in0 * in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const mediump mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = in0 * in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const mediump mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = in0 * in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
const highp mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = in0 * a_coords;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
const highp mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);

void main (void)
{
    highp vec4 res = in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec4 a_coords;
const highp mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    gl_Position = a_position;
    highp vec4 res = a_coords * in1;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
const highp mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    highp vec4 res = v_coords * in1;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const highp mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    highp mat3x4 res = in0 * in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const highp mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = in0 * in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const highp mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    highp mat4 res = in0 * in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = u_in0 * a_coords;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2 u_in0; };

void main (void)
{
    mediump vec2 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = a_coords * u_in1;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    mediump vec2 res = v_coords * u_in1;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = u_in0 * u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    mediump mat2 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = u_in0 * u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    mediump mat4x2 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec2 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp vec2 res = a_coords * u_in1;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = u_in0 * u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = u_in0 * u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    highp mat4x2 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x3 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = u_in0 * a_coords;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x3 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump vec3 res = u_in0 * a_coords;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x3 u_in0; };

void main (void)
{
    mediump vec3 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    mediump vec2 res = v_coords * u_in1;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    mediump mat2x3 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    mediump mat3 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = u_in0 * u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x3 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = u_in0 * a_coords;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec2 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x3 u_in0; };

void main (void)
{
    highp vec3 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec3 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp vec2 res = a_coords * u_in1;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec3 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    highp vec2 res = v_coords * u_in1;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = u_in0 * u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    highp mat2x3 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    highp mat3 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = u_in0 * u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = u_in0 * a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };

void main (void)
{
    mediump mat2x4 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = u_in0 * a_coords;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };

void main (void)
{
    mediump vec4 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = a_coords * u_in1;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec4 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    mediump vec2 res = v_coords * u_in1;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    mediump mat2x4 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = u_in0 * u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    mediump mat4 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x4 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = u_in0 * a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x4 u_in0; };

void main (void)
{
    highp mat2x4 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec2 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x4 u_in0; };

void main (void)
{
    highp vec4 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    highp vec2 res = v_coords * u_in1;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = u_in0 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    highp mat2x4 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = u_in0 * u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    highp mat4 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    mediump vec3 res = v_coords * u_in1;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = u_in0 * u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    mediump mat2 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = u_in0 * u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump mat4x2 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec3 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x2 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp vec2 res = u_in0 * a_coords;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec2 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp vec3 res = a_coords * u_in1;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec2 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    highp vec3 res = v_coords * u_in1;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = u_in0 * u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    highp mat2 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    highp mat4x2 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = u_in0 * a_coords;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3 u_in0; };

void main (void)
{
    mediump mat3 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec3 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump vec3 res = u_in0 * a_coords;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3 u_in0; };

void main (void)
{
    mediump vec3 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    mediump vec3 res = v_coords * u_in1;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    mediump mat3 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = u_in0 * u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3 u_in0; };

void main (void)
{
    highp mat3 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec3 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp vec3 res = u_in0 * a_coords;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = u_in0 * u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec3 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x4 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = u_in0 * a_coords;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump vec3 res = a_coords * u_in1;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = u_in0 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    mediump mat2x4 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump mat4 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = u_in0 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    highp mat2x4 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = u_in0 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    highp mat4 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x2 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = u_in0 * a_coords;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x2 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = u_in0 * a_coords;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = a_coords * u_in1;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = u_in0 * u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    mediump mat2 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = u_in0 * u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x2 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = u_in0 * a_coords;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = u_in0 * u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    highp mat2 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = u_in0 * u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = u_in0 * u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = u_in0 * a_coords;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };

void main (void)
{
    mediump mat4x3 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec3 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = a_coords * u_in1;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump vec4 res = v_coords * u_in1;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = u_in0 * u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = u_in0 * u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    mediump mat3 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = u_in0 * u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x3 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = u_in0 * a_coords;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x3 u_in0; };

void main (void)
{
    highp mat4x3 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec4 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x3 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp vec3 res = u_in0 * a_coords;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec3 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    highp vec4 res = v_coords * u_in1;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = u_in0 * u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = u_in0 * u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    highp mat3 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = u_in0 * a_coords;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = a_coords * u_in1;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = u_in0 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = u_in0 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    mediump mat3x4 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = u_in0 * u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4 u_in0; };

void main (void)
{
    highp vec4 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec4 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 res = a_coords * u_in1;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    highp vec4 res = v_coords * u_in1;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    highp mat3x4 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = u_in0 * u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    highp mat4 res = u_in0 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = a_mat2 * a_coords;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
layout(location = 5) in mediump mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = a_coords * a_mat2;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = a_mat2 * u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = a_mat2 * u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    mediump mat3x2 res = v_mat2 * u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec2 a_coords;
layout(location = 5) in highp mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    highp vec2 res = a_coords * a_mat2;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2 a_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = a_mat2 * u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2 a_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = a_mat2 * u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    highp mat3x2 res = v_mat2 * u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x3 a_mat2x3;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = a_mat2x3 * a_coords;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec3 a_coords;
layout(location = 5) in mediump mat2x3 a_mat2x3;

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = a_coords * a_mat2x3;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x3 a_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = a_mat2x3 * u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x3 a_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = a_mat2x3 * u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat2x3 a_mat2x3;
layout(location = 1) out mediump mat2x3 v_mat2x3;

void main (void)
{
    gl_Position = a_position;
    v_mat2x3 = a_mat2x3;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x3 v_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    mediump mat3 res = v_mat2x3 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x3 a_mat2x3;
layout(location = 1) in highp float a_coords;

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = a_mat2x3 * a_coords;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec3 a_coords;
layout(location = 5) in highp mat2x3 a_mat2x3;

void main (void)
{
    gl_Position = a_position;
    highp vec2 res = a_coords * a_mat2x3;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x3 a_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = a_mat2x3 * u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x3 a_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = a_mat2x3 * u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat2x3 a_mat2x3;
layout(location = 1) out highp mat2x3 v_mat2x3;

void main (void)
{
    gl_Position = a_position;
    v_mat2x3 = a_mat2x3;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    highp mat4x3 res = v_mat2x3 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x4 a_mat2x4;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = a_mat2x4 * a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x4 v_mat2x4;
layout(location = 3) in mediump float v_coords;

void main (void)
{
    mediump mat2x4 res = v_mat2x4 * v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = a_mat2x4 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = a_mat2x4 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat2x4 a_mat2x4;
layout(location = 1) out mediump mat2x4 v_mat2x4;

void main (void)
{
    gl_Position = a_position;
    v_mat2x4 = a_mat2x4;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x4 v_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    mediump mat4 res = v_mat2x4 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x4 a_mat2x4;
layout(location = 1) in highp float a_coords;

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = a_mat2x4 * a_coords;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x4 v_mat2x4;
layout(location = 3) in highp float v_coords;

void main (void)
{
    highp mat2x4 res = v_mat2x4 * v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = a_mat2x4 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = a_mat2x4 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat2x4 a_mat2x4;
layout(location = 1) out highp mat2x4 v_mat2x4;

void main (void)
{
    gl_Position = a_position;
    v_mat2x4 = a_mat2x4;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x4 v_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    highp mat3x4 res = v_mat2x4 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(location = 1) in mediump vec3 a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = a_mat3x2 * a_coords;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(location = 1) out mediump mat3x2 v_mat3x2;
layout(location = 1) in mediump vec3 a_coords;
layout(location = 4) out mediump vec3 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat3x2 = a_mat3x2;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x2 v_mat3x2;
layout(location = 4) in mediump vec3 v_coords;

void main (void)
{
    mediump vec2 res = v_mat3x2 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
layout(location = 5) in mediump mat3x2 a_mat3x2;

void main (void)
{
    gl_Position = a_position;
    mediump vec3 res = a_coords * a_mat3x2;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(location = 1) out mediump mat3x2 v_mat3x2;

void main (void)
{
    gl_Position = a_position;
    v_mat3x2 = a_mat3x2;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x2 v_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    mediump mat2 res = v_mat3x2 * u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x2 v_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    mediump mat3x2 res = v_mat3x2 * u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = a_mat3x2 * u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x2 v_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump mat4x2 res = v_mat3x2 * u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x2 a_mat3x2;
layout(location = 1) in highp vec3 a_coords;

void main (void)
{
    gl_Position = a_position;
    highp vec2 res = a_mat3x2 * a_coords;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat3x2 a_mat3x2;
layout(location = 1) out highp mat3x2 v_mat3x2;
layout(location = 1) in highp vec3 a_coords;
layout(location = 4) out highp vec3 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat3x2 = a_mat3x2;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;
layout(location = 4) in highp vec3 v_coords;

void main (void)
{
    highp vec2 res = v_mat3x2 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec2 a_coords;
layout(location = 5) in highp mat3x2 a_mat3x2;

void main (void)
{
    gl_Position = a_position;
    highp vec3 res = a_coords * a_mat3x2;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat3x2 a_mat3x2;
layout(location = 1) out highp mat3x2 v_mat3x2;

void main (void)
{
    gl_Position = a_position;
    v_mat3x2 = a_mat3x2;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    highp mat3x2 res = v_mat3x2 * u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = a_mat3x2 * u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = a_mat3 * a_coords;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;
layout(location = 4) in mediump float v_coords;

void main (void)
{
    mediump mat3 res = v_mat3 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;
layout(location = 1) in mediump vec3 a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump vec3 res = a_mat3 * a_coords;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = a_mat3 * u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    mediump mat2x3 res = v_mat3 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump mat4x3 res = v_mat3 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat3 a_mat3;
layout(location = 1) out highp mat3 v_mat3;
layout(location = 1) in highp float a_coords;
layout(location = 4) out highp float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat3 = a_mat3;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;
layout(location = 4) in highp float v_coords;

void main (void)
{
    highp mat3 res = v_mat3 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3 a_mat3;
layout(location = 1) in highp vec3 a_coords;

void main (void)
{
    gl_Position = a_position;
    highp vec3 res = a_mat3 * a_coords;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3 a_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = a_mat3 * u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    highp mat2x3 res = v_mat3 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    highp mat4x3 res = v_mat3 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat3x4 a_mat3x4;
layout(location = 1) out mediump mat3x4 v_mat3x4;
layout(location = 1) in mediump vec3 a_coords;
layout(location = 4) out mediump vec3 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat3x4 = a_mat3x4;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;
layout(location = 4) in mediump vec3 v_coords;

void main (void)
{
    mediump vec4 res = v_mat3x4 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec4 a_coords;
layout(location = 1) out mediump vec4 v_coords;
layout(location = 5) in mediump mat3x4 a_mat3x4;
layout(location = 2) out mediump mat3x4 v_mat3x4;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_mat3x4 = a_mat3x4;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump mat3x4 v_mat3x4;

void main (void)
{
    mediump vec3 res = v_coords * v_mat3x4;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    mediump mat2x4 res = v_mat3x4 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = a_mat3x4 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    mediump mat3x4 res = v_mat3x4 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = a_mat3x4 * u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump mat4 res = v_mat3x4 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat3x4 a_mat3x4;
layout(location = 1) out highp mat3x4 v_mat3x4;
layout(location = 1) in highp vec3 a_coords;
layout(location = 4) out highp vec3 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat3x4 = a_mat3x4;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;
layout(location = 4) in highp vec3 v_coords;

void main (void)
{
    highp vec4 res = v_mat3x4 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 1) out highp vec4 v_coords;
layout(location = 5) in highp mat3x4 a_mat3x4;
layout(location = 2) out highp mat3x4 v_mat3x4;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_mat3x4 = a_mat3x4;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
layout(location = 2) in highp mat3x4 v_mat3x4;

void main (void)
{
    highp vec3 res = v_coords * v_mat3x4;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x4 a_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = a_mat3x4 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    highp mat3x4 res = v_mat3x4 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x4 a_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = a_mat3x4 * u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x2 a_mat4x2;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = a_mat4x2 * a_coords;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat4x2 a_mat4x2;
layout(location = 1) out mediump mat4x2 v_mat4x2;
layout(location = 1) in mediump vec4 a_coords;
layout(location = 5) out mediump vec4 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4x2 = a_mat4x2;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;
layout(location = 5) in mediump vec4 v_coords;

void main (void)
{
    mediump vec2 res = v_mat4x2 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec2 a_coords;
layout(location = 1) out mediump vec2 v_coords;
layout(location = 5) in mediump mat4x2 a_mat4x2;
layout(location = 2) out mediump mat4x2 v_mat4x2;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_mat4x2 = a_mat4x2;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
layout(location = 2) in mediump mat4x2 v_mat4x2;

void main (void)
{
    mediump vec4 res = v_coords * v_mat4x2;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat4x2 a_mat4x2;
layout(location = 1) out mediump mat4x2 v_mat4x2;

void main (void)
{
    gl_Position = a_position;
    v_mat4x2 = a_mat4x2;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    mediump mat2 res = v_mat4x2 * u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x2 a_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = a_mat4x2 * u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    mediump mat4x2 res = v_mat4x2 * u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x2 a_mat4x2;
layout(location = 1) in highp float a_coords;

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = a_mat4x2 * a_coords;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat4x2 a_mat4x2;
layout(location = 1) out highp mat4x2 v_mat4x2;
layout(location = 1) in highp vec4 a_coords;
layout(location = 5) out highp vec4 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4x2 = a_mat4x2;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;
layout(location = 5) in highp vec4 v_coords;

void main (void)
{
    highp vec2 res = v_mat4x2 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 1) out highp vec2 v_coords;
layout(location = 5) in highp mat4x2 a_mat4x2;
layout(location = 2) out highp mat4x2 v_mat4x2;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_mat4x2 = a_mat4x2;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec2 v_coords;
layout(location = 2) in highp mat4x2 v_mat4x2;

void main (void)
{
    highp vec4 res = v_coords * v_mat4x2;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat4x2 a_mat4x2;
layout(location = 1) out highp mat4x2 v_mat4x2;

void main (void)
{
    gl_Position = a_position;
    v_mat4x2 = a_mat4x2;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    highp mat3x2 res = v_mat4x2 * u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x2 a_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = a_mat4x2 * u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    highp mat4x2 res = v_mat4x2 * u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x3 a_mat4x3;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = a_mat4x3 * a_coords;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;
layout(location = 5) in mediump float v_coords;

void main (void)
{
    mediump mat4x3 res = v_mat4x3 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x3 a_mat4x3;
layout(location = 1) in mediump vec4 a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump vec3 res = a_mat4x3 * a_coords;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat4x3 a_mat4x3;
layout(location = 1) out mediump mat4x3 v_mat4x3;
layout(location = 1) in mediump vec4 a_coords;
layout(location = 5) out mediump vec4 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4x3 = a_mat4x3;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;
layout(location = 5) in mediump vec4 v_coords;

void main (void)
{
    mediump vec3 res = v_mat4x3 * v_coords;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    mediump mat3 res = v_mat4x3 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    mediump mat4x3 res = v_mat4x3 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;
layout(location = 1) in highp float a_coords;

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = a_mat4x3 * a_coords;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x3 v_mat4x3;
layout(location = 5) in highp float v_coords;

void main (void)
{
    highp mat4x3 res = v_mat4x3 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;
layout(location = 1) in highp vec4 a_coords;

void main (void)
{
    gl_Position = a_position;
    highp vec3 res = a_mat4x3 * a_coords;
    v_color = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat4x3 a_mat4x3;
layout(location = 1) out highp mat4x3 v_mat4x3;
layout(location = 1) in highp vec4 a_coords;
layout(location = 5) out highp vec4 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4x3 = a_mat4x3;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x3 v_mat4x3;
layout(location = 5) in highp vec4 v_coords;

void main (void)
{
    highp vec3 res = v_mat4x3 * v_coords;
    dEQP_FragColor = vec4(res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    highp mat2x3 res = v_mat4x3 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    highp mat4x3 res = v_mat4x3 * u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = a_mat4 * a_coords;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat4 a_mat4;
layout(location = 1) out mediump mat4 v_mat4;
layout(location = 1) in mediump vec4 a_coords;
layout(location = 5) out mediump vec4 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4 = a_mat4;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;
layout(location = 5) in mediump vec4 v_coords;

void main (void)
{
    mediump vec4 res = v_mat4 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
layout(location = 5) in mediump mat4 a_mat4;

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = a_coords * a_mat4;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec4 a_coords;
layout(location = 1) out mediump vec4 v_coords;
layout(location = 5) in mediump mat4 a_mat4;
layout(location = 2) out mediump mat4 v_mat4;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_mat4 = a_mat4;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump mat4 v_mat4;

void main (void)
{
    mediump vec4 res = v_coords * v_mat4;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat4 a_mat4;
layout(location = 1) out mediump mat4 v_mat4;

void main (void)
{
    gl_Position = a_position;
    v_mat4 = a_mat4;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    mediump mat2x4 res = v_mat4 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = a_mat4 * u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    mediump mat4 res = v_mat4 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat4 a_mat4;
layout(location = 1) out highp mat4 v_mat4;
layout(location = 1) in highp vec4 a_coords;
layout(location = 5) out highp vec4 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4 = a_mat4;
    v_coords = a_coords;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;
layout(location = 5) in highp vec4 v_coords;

void main (void)
{
    highp vec4 res = v_mat4 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec4 a_coords;
layout(location = 5) in highp mat4 a_mat4;

void main (void)
{
    gl_Position = a_position;
    highp vec4 res = a_coords * a_mat4;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 1) out highp vec4 v_coords;
layout(location = 5) in highp mat4 a_mat4;
layout(location = 2) out highp mat4 v_mat4;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_mat4 = a_mat4;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
layout(location = 2) in highp mat4 v_mat4;

void main (void)
{
    highp vec4 res = v_coords * v_mat4;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat4 a_mat4;
layout(location = 1) out highp mat4 v_mat4;

void main (void)
{
    gl_Position = a_position;
    v_mat4 = a_mat4;
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    highp mat2x4 res = v_mat4 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4 a_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = a_mat4 * u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    highp mat4 res = v_mat4 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = in0 / u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    mediump mat2 res = in0 / u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const mediump mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = in0 / in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const mediump mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    mediump mat2x3 res = in0 / in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = in0 / u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat2x3 res = in0 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const highp mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = in0 / in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    mediump mat2x4 res = in0 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const mediump mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = in0 / in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const mediump mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    mediump mat2x4 res = in0 / in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = in0 / u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = in0 / u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);
const mediump mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = in0 / in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);
const mediump mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    mediump mat3x2 res = in0 / in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat3x2 res = in0 / u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = in0 / u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat3 res = in0 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
const highp mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = in0 / in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = in0 / u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat3x4 res = in0 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const highp mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = in0 / in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const highp mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    highp mat3x4 res = in0 / in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
const mediump mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = in0 / in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
const mediump mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    mediump mat4x2 res = in0 / in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = in0 / u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat4x2 res = in0 / u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    mediump mat4x3 res = in0 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const mediump mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = in0 / in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = in0 / u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const highp mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    highp mat4x3 res = in0 / in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = in0 / u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    mediump mat4 res = in0 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const mediump mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = in0 / in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const mediump mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    mediump mat4 res = in0 / in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const highp mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    highp mat4 res = in0 / in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat2 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = u_in0 / u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    highp mat2 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = u_in0 / u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    mediump mat2x3 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = u_in0 / u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = u_in0 / u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    mediump mat2x4 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = u_in0 / u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    mediump mat2x4 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat2x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat2x4 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = u_in0 / u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    mediump mat3x2 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp float u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = u_in0 / u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    mediump mat3 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = u_in0 / u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    highp mat3 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp float u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = u_in0 / u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = u_in0 / u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    highp mat3x4 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = u_in0 / u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = u_in0 / u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x2 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    mediump mat4x2 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = u_in0 / u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    mediump mat4x3 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = u_in0 / u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat4x3 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4x3 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    highp mat4x3 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    mediump mat4 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat4 res = u_in0 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = u_in0 / u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    mediump mat2 res = v_mat2 / u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat2 res = v_mat2 / u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2 a_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = a_mat2 / u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    highp mat2 res = v_mat2 / u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x3 a_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = a_mat2x3 / u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x3 a_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = a_mat2x3 / u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x3 v_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    mediump mat2x3 res = v_mat2x3 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    highp mat2x3 res = v_mat2x3 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = a_mat2x4 / u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x4 v_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    mediump mat2x4 res = v_mat2x4 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x4 v_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    mediump mat2x4 res = v_mat2x4 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x4 v_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat2x4 res = v_mat2x4 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = a_mat2x4 / u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x4 v_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    highp mat2x4 res = v_mat2x4 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x2 v_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    mediump mat3x2 res = v_mat3x2 / u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = a_mat3x2 / u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = a_mat3x2 / u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    highp mat3x2 res = v_mat3x2 / u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    mediump mat3 res = v_mat3 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = a_mat3 / u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    mediump mat3 res = v_mat3 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    highp mat3 res = v_mat3 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = a_mat3x4 / u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x4 a_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = a_mat3x4 / u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x2 a_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = a_mat4x2 / u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    mediump mat4x2 res = v_mat4x2 / u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x2 a_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = a_mat4x2 / u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    highp mat4x2 res = v_mat4x2 / u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x3 a_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = a_mat4x3 / u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    mediump mat4x3 res = v_mat4x3 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat4x3 res = v_mat4x3 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = a_mat4x3 / u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat4 res = v_mat4 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4 a_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = a_mat4 / u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = matrixCompMult(a_mat2, u_in1);
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x3 a_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = matrixCompMult(a_mat2x3, u_in1);
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = matrixCompMult(a_mat2x4, u_in1);
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = matrixCompMult(a_mat3x2, u_in1);
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3 a_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = matrixCompMult(a_mat3, u_in1);
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    mediump mat3x4 res = matrixCompMult(v_mat3x4, u_in1);
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x4 a_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = matrixCompMult(a_mat3x4, u_in1);
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    highp mat3x4 res = matrixCompMult(v_mat3x4, u_in1);
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x2 a_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = matrixCompMult(a_mat4x2, u_in1);
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x3 a_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = matrixCompMult(a_mat4x3, u_in1);
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump mat4x3 res = matrixCompMult(v_mat4x3, u_in1);
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    highp mat4x3 res = matrixCompMult(v_mat4x3, u_in1);
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = matrixCompMult(a_mat4, u_in1);
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    mediump mat4 res = matrixCompMult(v_mat4, u_in1);
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    highp mat4 res = matrixCompMult(v_mat4, u_in1);
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec2 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp vec2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = outerProduct(a_coords, u_in1);
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec2 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp vec2 u_in1; };

void main (void)
{
    highp mat2 res = outerProduct(v_coords, u_in1);
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec3 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump vec2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = outerProduct(a_coords, u_in1);
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump vec2 u_in1; };

void main (void)
{
    mediump mat2x3 res = outerProduct(v_coords, u_in1);
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump vec2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = outerProduct(a_coords, u_in1);
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp vec2 u_in1; };

void main (void)
{
    highp mat2x4 res = outerProduct(v_coords, u_in1);
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump vec3 u_in1; };

void main (void)
{
    mediump mat3x2 res = outerProduct(v_coords, u_in1);
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec2 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp vec3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = outerProduct(a_coords, u_in1);
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump vec3 u_in1; };

void main (void)
{
    mediump mat3 res = outerProduct(v_coords, u_in1);
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec3 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp vec3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = outerProduct(a_coords, u_in1);
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec4 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump vec3 u_in1; };

void main (void)
{
    mediump mat3x4 res = outerProduct(v_coords, u_in1);
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec4 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp vec3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = outerProduct(a_coords, u_in1);
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump vec4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = outerProduct(a_coords, u_in1);
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump vec4 u_in1; };

void main (void)
{
    mediump mat4x2 res = outerProduct(v_coords, u_in1);
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec3 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump vec4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = outerProduct(a_coords, u_in1);
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec3 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp vec4 u_in1; };

void main (void)
{
    highp mat4x3 res = outerProduct(v_coords, u_in1);
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec4 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp vec4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = outerProduct(a_coords, u_in1);
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp vec4 u_in1; };

void main (void)
{
    highp mat4 res = outerProduct(v_coords, u_in1);
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;

void main (void)
{
    mediump mat2 res = transpose(v_mat2);
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = transpose(a_mat2);
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;

void main (void)
{
    highp mat2 res = transpose(v_mat2);
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;

void main (void)
{
    highp mat3x2 res = transpose(v_mat2x3);
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x4 v_mat2x4;

void main (void)
{
    mediump mat4x2 res = transpose(v_mat2x4);
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = transpose(a_mat3x2);
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x2 a_mat3x2;

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = transpose(a_mat3x2);
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;

void main (void)
{
    highp mat2x3 res = transpose(v_mat3x2);
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3 a_mat3;

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = transpose(a_mat3);
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = transpose(a_mat3x4);
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x4 a_mat3x4;

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = transpose(a_mat3x4);
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;

void main (void)
{
    highp mat4x3 res = transpose(v_mat3x4);
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;

void main (void)
{
    highp mat2x4 res = transpose(v_mat4x2);
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;

void main (void)
{
    mediump mat3x4 res = transpose(v_mat4x3);
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;

void main (void)
{
    mediump mat4 res = transpose(v_mat4);
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4 a_mat4;

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = transpose(a_mat4);
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;

void main (void)
{
    highp mat4 res = transpose(v_mat4);
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    mediump float res = determinant(a_mat2);
    v_color = vec4(res, res, res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;

void main (void)
{
    mediump float res = determinant(v_mat2);
    dEQP_FragColor = vec4(res, res, res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    highp float res = determinant(a_mat2);
    v_color = vec4(res, res, res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;

void main (void)
{
    gl_Position = a_position;
    mediump float res = determinant(a_mat3);
    v_color = vec4(res, res, res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3 a_mat3;

void main (void)
{
    gl_Position = a_position;
    highp float res = determinant(a_mat3);
    v_color = vec4(res, res, res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;

void main (void)
{
    highp float res = determinant(v_mat3);
    dEQP_FragColor = vec4(res, res, res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;

void main (void)
{
    gl_Position = a_position;
    mediump float res = determinant(a_mat4);
    v_color = vec4(res, res, res, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;

void main (void)
{
    mediump float res = determinant(v_mat4);
    dEQP_FragColor = vec4(res, res, res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4 a_mat4;

void main (void)
{
    gl_Position = a_position;
    highp float res = determinant(a_mat4);
    v_color = vec4(res, res, res, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = inverse(a_mat2);
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;

void main (void)
{
    mediump mat2 res = inverse(v_mat2);
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = inverse(a_mat3);
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;

void main (void)
{
    highp mat3 res = inverse(v_mat3);
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = inverse(a_mat4);
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;

void main (void)
{
    mediump mat4 res = inverse(v_mat4);
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = +a_mat2;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;

void main (void)
{
    mediump mat2 res = +v_mat2;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x3 a_mat2x3;

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = +a_mat2x3;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;

void main (void)
{
    highp mat2x3 res = +v_mat2x3;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x4 v_mat2x4;

void main (void)
{
    mediump mat2x4 res = +v_mat2x4;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x4 a_mat2x4;

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = +a_mat2x4;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = +a_mat3x2;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;

void main (void)
{
    highp mat3x2 res = +v_mat3x2;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = +a_mat3;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;

void main (void)
{
    highp mat3 res = +v_mat3;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = +a_mat3x4;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;

void main (void)
{
    highp mat3x4 res = +v_mat3x4;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x2 a_mat4x2;

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = +a_mat4x2;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;

void main (void)
{
    highp mat4x2 res = +v_mat4x2;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;

void main (void)
{
    mediump mat4x3 res = +v_mat4x3;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = +a_mat4x3;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = +a_mat4;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;

void main (void)
{
    mediump mat4 res = +v_mat4;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;

void main (void)
{
    highp mat2 res = -v_mat2;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x3 a_mat2x3;

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = -a_mat2x3;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x4 a_mat2x4;

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = -a_mat2x4;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x4 v_mat2x4;

void main (void)
{
    mediump mat2x4 res = -v_mat2x4;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x4 v_mat2x4;

void main (void)
{
    highp mat2x4 res = -v_mat2x4;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x2 a_mat3x2;

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 res = -a_mat3x2;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;

void main (void)
{
    mediump mat3 res = -v_mat3;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x4 a_mat3x4;

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = -a_mat3x4;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x2 a_mat4x2;

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = -a_mat4x2;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x3 a_mat4x3;

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = -a_mat4x3;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;

void main (void)
{
    mediump mat4x3 res = -v_mat4x3;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x3 v_mat4x3;

void main (void)
{
    highp mat4x3 res = -v_mat4x3;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;

void main (void)
{
    highp mat4 res = -v_mat4;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;

void main (void)
{
    mediump mat2 tmpValue = v_mat2;
    mediump mat2 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0) + vec4(tmpValue[0][0], tmpValue[1][0], tmpValue[0][1]+tmpValue[1][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;

void main (void)
{
    highp mat2 tmpValue = v_mat2;
    highp mat2 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0) + vec4(tmpValue[0][0], tmpValue[1][0], tmpValue[0][1]+tmpValue[1][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x3 v_mat2x3;

void main (void)
{
    mediump mat2x3 tmpValue = v_mat2x3;
    mediump mat2x3 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0) + vec4(tmpValue[0] + tmpValue[1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;

void main (void)
{
    highp mat2x3 tmpValue = v_mat2x3;
    highp mat2x3 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0) + vec4(tmpValue[0] + tmpValue[1], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 tmpValue = a_mat3x2;
    mediump mat3x2 res = ++tmpValue;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1], tmpValue[1][0]+tmpValue[1][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x2 v_mat3x2;

void main (void)
{
    mediump mat3x2 tmpValue = v_mat3x2;
    mediump mat3x2 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1], tmpValue[1][0]+tmpValue[1][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x2 a_mat3x2;

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 tmpValue = a_mat3x2;
    highp mat3x2 res = ++tmpValue;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1], tmpValue[1][0]+tmpValue[1][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;

void main (void)
{
    highp mat3x2 tmpValue = v_mat3x2;
    highp mat3x2 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1], tmpValue[1][0]+tmpValue[1][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 tmpValue = a_mat3x4;
    mediump mat3x4 res = ++tmpValue;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;

void main (void)
{
    mediump mat3x4 tmpValue = v_mat3x4;
    mediump mat3x4 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x4 a_mat3x4;

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 tmpValue = a_mat3x4;
    highp mat3x4 res = ++tmpValue;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;

void main (void)
{
    highp mat3x4 tmpValue = v_mat3x4;
    highp mat3x4 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;

void main (void)
{
    mediump mat4x2 tmpValue = v_mat4x2;
    mediump mat4x2 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1]+tmpValue[3][0], tmpValue[1][0]+tmpValue[1][1]+tmpValue[3][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;

void main (void)
{
    highp mat4x2 tmpValue = v_mat4x2;
    highp mat4x2 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1]+tmpValue[3][0], tmpValue[1][0]+tmpValue[1][1]+tmpValue[3][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;

void main (void)
{
    mediump mat4 tmpValue = v_mat4;
    mediump mat4 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0) + vec4(tmpValue[0].xyz+tmpValue[1].yzw+tmpValue[2].zwx+tmpValue[3].wxy, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;

void main (void)
{
    highp mat4 tmpValue = v_mat4;
    highp mat4 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0) + vec4(tmpValue[0].xyz+tmpValue[1].yzw+tmpValue[2].zwx+tmpValue[3].wxy, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;

void main (void)
{
    mediump mat2 tmpValue = v_mat2;
    mediump mat2 res = --tmpValue;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0) + vec4(tmpValue[0][0], tmpValue[1][0], tmpValue[0][1]+tmpValue[1][1], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    highp mat2 tmpValue = a_mat2;
    highp mat2 res = --tmpValue;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0) + vec4(tmpValue[0][0], tmpValue[1][0], tmpValue[0][1]+tmpValue[1][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;

void main (void)
{
    highp mat2 tmpValue = v_mat2;
    highp mat2 res = --tmpValue;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0) + vec4(tmpValue[0][0], tmpValue[1][0], tmpValue[0][1]+tmpValue[1][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x3 v_mat2x3;

void main (void)
{
    mediump mat2x3 tmpValue = v_mat2x3;
    mediump mat2x3 res = --tmpValue;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0) + vec4(tmpValue[0] + tmpValue[1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;

void main (void)
{
    highp mat2x3 tmpValue = v_mat2x3;
    highp mat2x3 res = --tmpValue;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0) + vec4(tmpValue[0] + tmpValue[1], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 tmpValue = a_mat3x2;
    mediump mat3x2 res = --tmpValue;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1], tmpValue[1][0]+tmpValue[1][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x2 v_mat3x2;

void main (void)
{
    mediump mat3x2 tmpValue = v_mat3x2;
    mediump mat3x2 res = --tmpValue;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1], tmpValue[1][0]+tmpValue[1][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x2 a_mat3x2;

void main (void)
{
    gl_Position = a_position;
    highp mat3x2 tmpValue = a_mat3x2;
    highp mat3x2 res = --tmpValue;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1], tmpValue[1][0]+tmpValue[1][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;

void main (void)
{
    highp mat3x2 tmpValue = v_mat3x2;
    highp mat3x2 res = --tmpValue;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1], tmpValue[1][0]+tmpValue[1][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3 a_mat3;

void main (void)
{
    gl_Position = a_position;
    highp mat3 tmpValue = a_mat3;
    highp mat3 res = --tmpValue;
    v_color = vec4(res[0] + res[1] + res[2], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 tmpValue = a_mat3x4;
    mediump mat3x4 res = --tmpValue;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;

void main (void)
{
    mediump mat3x4 tmpValue = v_mat3x4;
    mediump mat3x4 res = --tmpValue;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x4 a_mat3x4;

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 tmpValue = a_mat3x4;
    highp mat3x4 res = --tmpValue;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;

void main (void)
{
    highp mat3x4 tmpValue = v_mat3x4;
    highp mat3x4 res = --tmpValue;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;

void main (void)
{
    mediump mat4x2 tmpValue = v_mat4x2;
    mediump mat4x2 res = --tmpValue;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1]+tmpValue[3][0], tmpValue[1][0]+tmpValue[1][1]+tmpValue[3][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;

void main (void)
{
    highp mat4x2 tmpValue = v_mat4x2;
    highp mat4x2 res = --tmpValue;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1]+tmpValue[3][0], tmpValue[1][0]+tmpValue[1][1]+tmpValue[3][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;

void main (void)
{
    mediump mat4 tmpValue = v_mat4;
    mediump mat4 res = --tmpValue;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0) + vec4(tmpValue[0].xyz+tmpValue[1].yzw+tmpValue[2].zwx+tmpValue[3].wxy, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4 a_mat4;

void main (void)
{
    gl_Position = a_position;
    highp mat4 tmpValue = a_mat4;
    highp mat4 res = --tmpValue;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0) + vec4(tmpValue[0].xyz+tmpValue[1].yzw+tmpValue[2].zwx+tmpValue[3].wxy, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;

void main (void)
{
    highp mat4 tmpValue = v_mat4;
    highp mat4 res = --tmpValue;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0) + vec4(tmpValue[0].xyz+tmpValue[1].yzw+tmpValue[2].zwx+tmpValue[3].wxy, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    mediump mat2 tmpValue = a_mat2;
    mediump mat2 res = tmpValue++;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0) + vec4(tmpValue[0][0], tmpValue[1][0], tmpValue[0][1]+tmpValue[1][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;

void main (void)
{
    mediump mat2 tmpValue = v_mat2;
    mediump mat2 res = tmpValue++;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0) + vec4(tmpValue[0][0], tmpValue[1][0], tmpValue[0][1]+tmpValue[1][1], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    highp mat2 tmpValue = a_mat2;
    highp mat2 res = tmpValue++;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0) + vec4(tmpValue[0][0], tmpValue[1][0], tmpValue[0][1]+tmpValue[1][1], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x3 a_mat2x3;

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 tmpValue = a_mat2x3;
    highp mat2x3 res = tmpValue++;
    v_color = vec4(res[0] + res[1], 1.0) + vec4(tmpValue[0] + tmpValue[1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;

void main (void)
{
    highp mat2x3 tmpValue = v_mat2x3;
    highp mat2x3 res = tmpValue++;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0) + vec4(tmpValue[0] + tmpValue[1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x4 v_mat2x4;

void main (void)
{
    mediump mat2x4 tmpValue = v_mat2x4;
    mediump mat2x4 res = tmpValue++;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x4 a_mat2x4;

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 tmpValue = a_mat2x4;
    highp mat2x4 res = tmpValue++;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 tmpValue = a_mat3x2;
    mediump mat3x2 res = tmpValue++;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1], tmpValue[1][0]+tmpValue[1][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;

void main (void)
{
    highp mat3x2 tmpValue = v_mat3x2;
    highp mat3x2 res = tmpValue++;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1], tmpValue[1][0]+tmpValue[1][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;

void main (void)
{
    gl_Position = a_position;
    mediump mat3 tmpValue = a_mat3;
    mediump mat3 res = tmpValue++;
    v_color = vec4(res[0] + res[1] + res[2], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3 a_mat3;

void main (void)
{
    gl_Position = a_position;
    highp mat3 tmpValue = a_mat3;
    highp mat3 res = tmpValue++;
    v_color = vec4(res[0] + res[1] + res[2], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;

void main (void)
{
    highp mat3 tmpValue = v_mat3;
    highp mat3 res = tmpValue++;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 tmpValue = a_mat3x4;
    mediump mat3x4 res = tmpValue++;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;

void main (void)
{
    highp mat3x4 tmpValue = v_mat3x4;
    highp mat3x4 res = tmpValue++;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x2 a_mat4x2;

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 tmpValue = a_mat4x2;
    highp mat4x2 res = tmpValue++;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1]+tmpValue[3][0], tmpValue[1][0]+tmpValue[1][1]+tmpValue[3][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;

void main (void)
{
    highp mat4x2 tmpValue = v_mat4x2;
    highp mat4x2 res = tmpValue++;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1]+tmpValue[3][0], tmpValue[1][0]+tmpValue[1][1]+tmpValue[3][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;

void main (void)
{
    mediump mat4x3 tmpValue = v_mat4x3;
    mediump mat4x3 res = tmpValue++;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2] + tmpValue[3], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 tmpValue = a_mat4x3;
    highp mat4x3 res = tmpValue++;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2] + tmpValue[3], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;

void main (void)
{
    gl_Position = a_position;
    mediump mat4 tmpValue = a_mat4;
    mediump mat4 res = tmpValue++;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0) + vec4(tmpValue[0].xyz+tmpValue[1].yzw+tmpValue[2].zwx+tmpValue[3].wxy, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;

void main (void)
{
    mediump mat4 tmpValue = v_mat4;
    mediump mat4 res = tmpValue++;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0) + vec4(tmpValue[0].xyz+tmpValue[1].yzw+tmpValue[2].zwx+tmpValue[3].wxy, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4 a_mat4;

void main (void)
{
    gl_Position = a_position;
    highp mat4 tmpValue = a_mat4;
    highp mat4 res = tmpValue++;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0) + vec4(tmpValue[0].xyz+tmpValue[1].yzw+tmpValue[2].zwx+tmpValue[3].wxy, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    mediump mat2 tmpValue = a_mat2;
    mediump mat2 res = tmpValue--;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0) + vec4(tmpValue[0][0], tmpValue[1][0], tmpValue[0][1]+tmpValue[1][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;

void main (void)
{
    mediump mat2 tmpValue = v_mat2;
    mediump mat2 res = tmpValue--;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0) + vec4(tmpValue[0][0], tmpValue[1][0], tmpValue[0][1]+tmpValue[1][1], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x3 a_mat2x3;

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 tmpValue = a_mat2x3;
    highp mat2x3 res = tmpValue--;
    v_color = vec4(res[0] + res[1], 1.0) + vec4(tmpValue[0] + tmpValue[1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;

void main (void)
{
    highp mat2x3 tmpValue = v_mat2x3;
    highp mat2x3 res = tmpValue--;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0) + vec4(tmpValue[0] + tmpValue[1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x4 v_mat2x4;

void main (void)
{
    mediump mat2x4 tmpValue = v_mat2x4;
    mediump mat2x4 res = tmpValue--;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x4 a_mat2x4;

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 tmpValue = a_mat2x4;
    highp mat2x4 res = tmpValue--;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 tmpValue = a_mat3x2;
    mediump mat3x2 res = tmpValue--;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1], tmpValue[1][0]+tmpValue[1][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;

void main (void)
{
    highp mat3x2 tmpValue = v_mat3x2;
    highp mat3x2 res = tmpValue--;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1], tmpValue[1][0]+tmpValue[1][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;

void main (void)
{
    gl_Position = a_position;
    mediump mat3 tmpValue = a_mat3;
    mediump mat3 res = tmpValue--;
    v_color = vec4(res[0] + res[1] + res[2], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;

void main (void)
{
    highp mat3 tmpValue = v_mat3;
    highp mat3 res = tmpValue--;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 tmpValue = a_mat3x4;
    mediump mat3x4 res = tmpValue--;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;

void main (void)
{
    highp mat3x4 tmpValue = v_mat3x4;
    highp mat3x4 res = tmpValue--;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x2 a_mat4x2;

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 tmpValue = a_mat4x2;
    highp mat4x2 res = tmpValue--;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1]+tmpValue[3][0], tmpValue[1][0]+tmpValue[1][1]+tmpValue[3][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;

void main (void)
{
    highp mat4x2 tmpValue = v_mat4x2;
    highp mat4x2 res = tmpValue--;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1]+tmpValue[3][0], tmpValue[1][0]+tmpValue[1][1]+tmpValue[3][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;

void main (void)
{
    mediump mat4x3 tmpValue = v_mat4x3;
    mediump mat4x3 res = tmpValue--;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2] + tmpValue[3], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 tmpValue = a_mat4x3;
    highp mat4x3 res = tmpValue--;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2] + tmpValue[3], 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;

void main (void)
{
    gl_Position = a_position;
    mediump mat4 tmpValue = a_mat4;
    mediump mat4 res = tmpValue--;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0) + vec4(tmpValue[0].xyz+tmpValue[1].yzw+tmpValue[2].zwx+tmpValue[3].wxy, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;

void main (void)
{
    mediump mat4 tmpValue = v_mat4;
    mediump mat4 res = tmpValue--;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0) + vec4(tmpValue[0].xyz+tmpValue[1].yzw+tmpValue[2].zwx+tmpValue[3].wxy, 0.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = a_mat2;
    res += u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    mediump mat2 res = v_mat2;
    res += u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x3 v_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    mediump mat2x3 res = v_mat2x3;
    res += u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x3 a_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = a_mat2x3;
    res += u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    highp mat2x3 res = v_mat2x3;
    res += u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = a_mat2x4;
    res += u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = a_mat3x2;
    res += u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x2 v_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    mediump mat3x2 res = v_mat3x2;
    res += u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    highp mat3x2 res = v_mat3x2;
    res += u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = a_mat3;
    res += u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    highp mat3 res = v_mat3;
    res += u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = a_mat3x4;
    res += u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    mediump mat3x4 res = v_mat3x4;
    res += u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    highp mat3x4 res = v_mat3x4;
    res += u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    mediump mat4x2 res = v_mat4x2;
    res += u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x2 a_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = a_mat4x2;
    res += u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    highp mat4x2 res = v_mat4x2;
    res += u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = a_mat4x3;
    res += u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = a_mat4;
    res += u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    mediump mat4 res = v_mat4;
    res += u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = a_mat2;
    res -= u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    mediump mat2 res = v_mat2;
    res -= u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2 a_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = a_mat2;
    res -= u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x3 v_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x3 u_in1; };

void main (void)
{
    mediump mat2x3 res = v_mat2x3;
    res -= u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x3 a_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = a_mat2x3;
    res -= u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    highp mat2x3 res = v_mat2x3;
    res -= u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = a_mat2x4;
    res -= u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = a_mat3x2;
    res -= u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x2 v_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    mediump mat3x2 res = v_mat3x2;
    res -= u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    highp mat3x2 res = v_mat3x2;
    res -= u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = a_mat3;
    res -= u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3 a_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = a_mat3;
    res -= u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    highp mat3 res = v_mat3;
    res -= u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = a_mat3x4;
    res -= u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    mediump mat3x4 res = v_mat3x4;
    res -= u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    highp mat3x4 res = v_mat3x4;
    res -= u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    mediump mat4x2 res = v_mat4x2;
    res -= u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x2 a_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = a_mat4x2;
    res -= u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    highp mat4x2 res = v_mat4x2;
    res -= u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = a_mat4x3;
    res -= u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = a_mat4;
    res -= u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    mediump mat4 res = v_mat4;
    res -= u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4 a_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = a_mat4;
    res -= u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2 u_in1; };

void main (void)
{
    highp mat2 res = v_mat2;
    res *= u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    mediump mat3 res = v_mat3;
    res *= u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    highp mat4 res = v_mat4;
    res *= u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = a_mat2;
    res /= u_in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    mediump mat2 res = v_mat2;
    res /= u_in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x3 a_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = a_mat2x3;
    res /= u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x3 u_in1; };

void main (void)
{
    highp mat2x3 res = v_mat2x3;
    res /= u_in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x4 v_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    mediump mat2x4 res = v_mat2x4;
    res /= u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x4 a_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = a_mat2x4;
    res /= u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = a_mat3x2;
    res /= u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x2 u_in1; };

void main (void)
{
    highp mat3x2 res = v_mat3x2;
    res /= u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3 a_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3 res = a_mat3;
    res /= u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    highp mat3 res = v_mat3;
    res /= u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x4 res = a_mat3x4;
    res /= u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    highp mat3x4 res = v_mat3x4;
    res /= u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x2 a_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x2 res = a_mat4x2;
    res /= u_in1;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x2 v_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x2 u_in1; };

void main (void)
{
    highp mat4x2 res = v_mat4x2;
    res /= u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump mat4x3 res = v_mat4x3;
    res /= u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4x3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = a_mat4x3;
    res /= u_in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = a_mat4;
    res /= u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4 v_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    mediump mat4 res = v_mat4;
    res /= u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
