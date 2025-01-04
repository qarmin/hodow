#version 310 es
layout(location = 0) in highp vec2 v_position;
layout(location = 1) flat out int prim_id;
void main ()
{
    prim_id = gl_VertexIndex / 3;
    gl_Position = vec4(v_position, float(gl_InstanceIndex)/256.0, 1);
}
