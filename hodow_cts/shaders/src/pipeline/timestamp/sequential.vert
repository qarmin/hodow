#version 310 es
precision highp float;
layout(location = 0) out vec4 vtxPos;
void main (void)
{
    // Hard-coded triangle positions
    vec4 positions[3] = vec4[3](
        vec4(-0.5, -0.5, 0.0, 1.0),
        vec4( 0.5, -0.5, 0.0, 1.0),
        vec4( 0.0,  0.5, 0.0, 1.0)
    );
    
    gl_Position = positions[gl_VertexIndex % 3];
    vtxPos = positions[gl_VertexIndex % 3];
}
