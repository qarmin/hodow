#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;

void main (void)
{
    mediump mat4x2 tmpValue = v_mat4x2;
    mediump mat4x2 res = tmpValue++;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0) + vec4(tmpValue[0][0]+tmpValue[0][1]+tmpValue[3][0], tmpValue[1][0]+tmpValue[1][1]+tmpValue[3][1], tmpValue[2][0]+tmpValue[2][1], 0.0);
}
