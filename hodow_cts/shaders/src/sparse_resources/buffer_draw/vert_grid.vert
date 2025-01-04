#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 0) out int  out_ndx;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
    out_ndx     = gl_VertexIndex;
}
