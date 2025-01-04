#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_even_spacing) in;

layout(location = 0) in  highp vec2 in_te_position[];
layout(location = 0) out highp vec4 in_f_color;

void main (void)
{
    highp float d = 3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z));
    highp vec2 corner0 = in_te_position[0];
    highp vec2 corner1 = in_te_position[1];
    highp vec2 corner2 = in_te_position[2];
    highp vec2 pos =  corner0*gl_TessCoord.x + corner1*gl_TessCoord.y + corner2*gl_TessCoord.z;
    highp vec2 fromCenter = pos - (corner0 + corner1 + corner2) / 3.0;
    highp float f = (1.0 - length(fromCenter)) * (1.5 - d);
    pos += 0.75 * f * fromCenter / (length(fromCenter) + 0.3);
    gl_Position = vec4(pos, 0.0, 1.0);
    in_f_color = vec4(1.0);
}
