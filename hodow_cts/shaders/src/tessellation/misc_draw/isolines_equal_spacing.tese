#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, equal_spacing) in;

layout(set = 0, binding = 0, std430) readonly restrict buffer TessLevels {
    float inner0;
    float inner1;
    float outer0;
    float outer1;
    float outer2;
    float outer3;
} sb_levels;

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
    pos.y += 0.15*sin(gl_TessCoord.x*10.0);
    gl_Position = vec4(pos, 0.0, 1.0);
    highp int phaseX = int(round(gl_TessCoord.x*sb_levels.outer1));
    highp int phaseY = int(round(gl_TessCoord.y*sb_levels.outer0));
    highp int phase = (phaseX + phaseY) % 3;
    in_f_color = phase == 0 ? vec4(1.0, 0.0, 0.0, 1.0)
               : phase == 1 ? vec4(0.0, 1.0, 0.0, 1.0)
               :              vec4(0.0, 0.0, 1.0, 1.0);
}
