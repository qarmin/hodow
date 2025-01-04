#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, equal_spacing) in;

layout(location = 0) in  highp vec2 in_te_position[];
layout(location = 0) out highp vec4 in_f_color;

void main (void)
{
    highp vec2 corner0 = in_te_position[0];
    highp vec2 corner1 = in_te_position[1];
    highp vec2 corner2 = in_te_position[2];
    highp vec2 corner3 = in_te_position[3];
    highp vec2 pos = (1.0-gl_TessCoord.x)*(1.0-gl_TessCoord.y)*corner0
                   + (    gl_TessCoord.x)*(1.0-gl_TessCoord.y)*corner1
                   + (1.0-gl_TessCoord.x)*(    gl_TessCoord.y)*corner2
                   + (    gl_TessCoord.x)*(    gl_TessCoord.y)*corner3;
    highp float d = 2.0 * min(abs(gl_TessCoord.x-0.5), abs(gl_TessCoord.y-0.5));
    highp vec2 fromCenter = pos - (corner0 + corner1 + corner2 + corner3) / 4.0;
    highp float f = (1.0 - length(fromCenter)) * sqrt(1.7 - d);
    pos += 0.75 * f * fromCenter / (length(fromCenter) + 0.3);
    gl_Position = vec4(pos, 0.0, 1.0);
    in_f_color = vec4(1.0);
}
