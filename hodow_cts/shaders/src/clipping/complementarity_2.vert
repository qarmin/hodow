#version 450

layout(location = 0) in vec4 v_position;    // we are passing ClipDistance in w component

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
};

void main (void)
{
    gl_Position        = vec4(v_position.xyz, 1.0);
    gl_ClipDistance[0] = 0.0;
    gl_ClipDistance[1] = v_position.w;
}
