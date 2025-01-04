#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(isolines) in;

layout(location = 0) in  highp vec4 v_control_color[];
layout(location = 0) out highp vec4 v_evaluated_color;

// note: No need to use precise gl_Position since we do not require gapless geometry
void main (void)
{
    gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
    v_evaluated_color = mix(v_control_color[0], v_control_color[1], gl_TessCoord.x);
}
