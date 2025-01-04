#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices = 2) out;

layout(location = 0) in  highp vec4 v_vertex_color[];
layout(location = 0) out highp vec4 v_control_color[];

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    v_control_color[gl_InvocationID] = v_vertex_color[gl_InvocationID];

    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
}
