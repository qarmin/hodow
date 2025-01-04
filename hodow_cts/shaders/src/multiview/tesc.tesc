#version 450
#extension GL_EXT_multiview : enable
#extension GL_EXT_tessellation_shader : require
layout(vertices = 4) out;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if ( gl_InvocationID == 0 )
    {
        gl_TessLevelInner[0] = 4.0f;
        gl_TessLevelInner[1] = 4.0f;
        gl_TessLevelOuter[0] = 4.0f;
        gl_TessLevelOuter[1] = 4.0f;
        gl_TessLevelOuter[2] = 4.0f;
        gl_TessLevelOuter[3] = 4.0f;
    }
    out_color[gl_InvocationID] = in_color[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
