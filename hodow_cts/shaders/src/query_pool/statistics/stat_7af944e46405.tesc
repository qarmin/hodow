#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 2) out;
vec4 positions[2] = vec4[](
    vec4(-0.5f,  0.0f, 0.0f, 1.0f),
    vec4( 0.5f,  0.0f, 0.0f, 1.0f)
);
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if( gl_InvocationID == 0 )
    {
        gl_TessLevelOuter[0] = 4.0f; // Number of lines
        gl_TessLevelOuter[1] = 4.0f; // Number of segments per line
    }
        out_color[gl_InvocationID] = in_color[gl_InvocationID];
        gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
