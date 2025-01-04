#version 310 es

layout(location = 0) in  highp vec2 in_v_position;
layout(location = 0) out highp vec2 in_tc_position;

void main (void)
{
    in_tc_position = in_v_position;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(set = 0, binding = 0, std430) readonly restrict buffer TessLevels {
    float inner0;
    float inner1;
    float outer0;
    float outer1;
    float outer2;
    float outer3;
} sb_levels;

layout(location = 0) in  highp vec2 in_tc_position[];
layout(location = 0) out highp vec2 in_te_position[];

void main (void)
{
    in_te_position[gl_InvocationID] = in_tc_position[gl_InvocationID];

    gl_TessLevelInner[0] = sb_levels.inner0;
    gl_TessLevelInner[1] = sb_levels.inner1;

    gl_TessLevelOuter[0] = sb_levels.outer0;
    gl_TessLevelOuter[1] = sb_levels.outer1;
    gl_TessLevelOuter[2] = sb_levels.outer2;
    gl_TessLevelOuter[3] = sb_levels.outer3;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, equal_spacing) in;

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
#version 310 es

layout(location = 0) in  highp   vec4 in_f_color;
layout(location = 0) out mediump vec4 o_color;

void main (void)
{
    o_color = in_f_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_odd_spacing) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 4) out;

layout(set = 0, binding = 0, std430) readonly restrict buffer TessLevels {
    float inner0;
    float inner1;
    float outer0;
    float outer1;
    float outer2;
    float outer3;
} sb_levels;

layout(location = 0) in  highp vec2 in_tc_position[];
layout(location = 0) out highp vec2 in_te_position[];

void main (void)
{
    in_te_position[gl_InvocationID] = in_tc_position[gl_InvocationID];

    gl_TessLevelInner[0] = sb_levels.inner0;
    gl_TessLevelInner[1] = sb_levels.inner1;

    gl_TessLevelOuter[0] = sb_levels.outer0;
    gl_TessLevelOuter[1] = sb_levels.outer1;
    gl_TessLevelOuter[2] = sb_levels.outer2;
    gl_TessLevelOuter[3] = sb_levels.outer3;
}
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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_odd_spacing) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_even_spacing) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, equal_spacing) in;

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
    highp vec2 pos =  corner0*gl_TessCoord.x + corner1*gl_TessCoord.y + corner2*gl_TessCoord.z;
    gl_Position = vec4(pos, 0.0, 1.0);
    highp int numConcentricTriangles = int(round(sb_levels.inner0)) / 2 + 1;
    highp float d = 3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z));
    highp int phase = int(d*float(numConcentricTriangles)) % 3;
    in_f_color = phase == 0 ? vec4(1.0, 0.0, 0.0, 1.0)
               : phase == 1 ? vec4(0.0, 1.0, 0.0, 1.0)
               :              vec4(0.0, 0.0, 1.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_odd_spacing) in;

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
    highp vec2 pos =  corner0*gl_TessCoord.x + corner1*gl_TessCoord.y + corner2*gl_TessCoord.z;
    gl_Position = vec4(pos, 0.0, 1.0);
    highp int numConcentricTriangles = int(round(sb_levels.inner0)) / 2 + 1;
    highp float d = 3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z));
    highp int phase = int(d*float(numConcentricTriangles)) % 3;
    in_f_color = phase == 0 ? vec4(1.0, 0.0, 0.0, 1.0)
               : phase == 1 ? vec4(0.0, 1.0, 0.0, 1.0)
               :              vec4(0.0, 0.0, 1.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_even_spacing) in;

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
    highp vec2 pos =  corner0*gl_TessCoord.x + corner1*gl_TessCoord.y + corner2*gl_TessCoord.z;
    gl_Position = vec4(pos, 0.0, 1.0);
    highp int numConcentricTriangles = int(round(sb_levels.inner0)) / 2 + 1;
    highp float d = 3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z));
    highp int phase = int(d*float(numConcentricTriangles)) % 3;
    in_f_color = phase == 0 ? vec4(1.0, 0.0, 0.0, 1.0)
               : phase == 1 ? vec4(0.0, 1.0, 0.0, 1.0)
               :              vec4(0.0, 0.0, 1.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, equal_spacing) in;

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
    gl_Position = vec4(pos, 0.0, 1.0);
    highp int phaseX = int(round((0.5 - abs(gl_TessCoord.x-0.5)) * sb_levels.inner0));
    highp int phaseY = int(round((0.5 - abs(gl_TessCoord.y-0.5)) * sb_levels.inner1));
    highp int phase = min(phaseX, phaseY) % 3;
    in_f_color = phase == 0 ? vec4(1.0, 0.0, 0.0, 1.0)
               : phase == 1 ? vec4(0.0, 1.0, 0.0, 1.0)
               :              vec4(0.0, 0.0, 1.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_odd_spacing) in;

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
    gl_Position = vec4(pos, 0.0, 1.0);
    highp int phaseX = int(round((0.5 - abs(gl_TessCoord.x-0.5)) * sb_levels.inner0));
    highp int phaseY = int(round((0.5 - abs(gl_TessCoord.y-0.5)) * sb_levels.inner1));
    highp int phase = min(phaseX, phaseY) % 3;
    in_f_color = phase == 0 ? vec4(1.0, 0.0, 0.0, 1.0)
               : phase == 1 ? vec4(0.0, 1.0, 0.0, 1.0)
               :              vec4(0.0, 0.0, 1.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_even_spacing) in;

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
    gl_Position = vec4(pos, 0.0, 1.0);
    highp int phaseX = int(round((0.5 - abs(gl_TessCoord.x-0.5)) * sb_levels.inner0));
    highp int phaseY = int(round((0.5 - abs(gl_TessCoord.y-0.5)) * sb_levels.inner1));
    highp int phase = min(phaseX, phaseY) % 3;
    in_f_color = phase == 0 ? vec4(1.0, 0.0, 0.0, 1.0)
               : phase == 1 ? vec4(0.0, 1.0, 0.0, 1.0)
               :              vec4(0.0, 0.0, 1.0, 1.0);
}
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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_odd_spacing) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_even_spacing) in;

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
#version 460
layout (location=0) in vec4 inPos;
layout (push_constant, std430) uniform PushConstantBlock { vec2 offset; } pc;
out gl_PerVertex
{
  vec4 gl_Position;
};
void main() {
    gl_Position = inPos + vec4(pc.offset, 0.0, 0.0);
}
#version 460
layout (vertices=4) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];
void main() {
    const float extraLevel = 0.0;
    gl_TessLevelInner[0] = 10.0 + extraLevel;
    gl_TessLevelInner[1] = 10.0 + extraLevel;
    gl_TessLevelOuter[0] = 50.0 + extraLevel;
    gl_TessLevelOuter[1] = 40.0 + extraLevel;
    gl_TessLevelOuter[2] = 30.0 + extraLevel;
    gl_TessLevelOuter[3] = 20.0 + extraLevel;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 460
layout (triangles, equal_spacing, ccw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};

// This assumes 2D, calculates barycentrics for point p inside triangle (a, b, c)
vec3 calcBaryCoords(vec2 p, vec2 a, vec2 b, vec2 c)
{
    const vec2 v0 = b - a;
    const vec2 v1 = c - a;
    const vec2 v2 = p - a;

    const float den = v0.x * v1.y - v1.x * v0.y;
    const float v   = (v2.x * v1.y - v1.x * v2.y) / den;
    const float w   = (v0.x * v2.y - v2.x * v0.y) / den;
    const float u   = 1.0 - v - w;

    return vec3(u, v, w);
}

void main() {
    const vec4 p0 = gl_in[0].gl_Position;
    const vec4 p1 = gl_in[1].gl_Position;
    const vec4 p2 = gl_in[2].gl_Position;
    const vec4 p3 = gl_in[3].gl_Position;
    // We have a patch with 4 corners (v0,v1,v2,v3), but triangle-based tessellation.
    // Lets suppose the triangle covers half the patch (triangle v0,v2,v1).
    // Expand the triangle by virtually grabbing it from the midpoint between v1 and v2 (which should fall in the middle of the patch) and stretching that point to the fourth corner (v3).
    const vec4 origpoint = (gl_TessCoord.x * p0) +
                           (gl_TessCoord.y * p2) +
                           (gl_TessCoord.z * p1);
    const vec4 midpoint = 0.5 * p1 + 0.5 * p2;

    // Find out if it falls on left or right side of the triangle.
    vec4 halfTriangle[3];
    vec4 stretchedHalf[3];

    if (gl_TessCoord.z >= gl_TessCoord.y)
    {
        halfTriangle[0] = p0;
        halfTriangle[1] = midpoint;
        halfTriangle[2] = p1;

        stretchedHalf[0] = p0;
        stretchedHalf[1] = p3;
        stretchedHalf[2] = p1;
    }
    else
    {
        halfTriangle[0] = p0;
        halfTriangle[1] = p2;
        halfTriangle[2] = midpoint;

        stretchedHalf[0] = p0;
        stretchedHalf[1] = p2;
        stretchedHalf[2] = p3;
    }

    // Calculate the barycentric coordinates for the left or right sides.
    vec3 sideBaryCoord = calcBaryCoords(origpoint.xy, halfTriangle[0].xy, halfTriangle[1].xy, halfTriangle[2].xy);

    // Move the point by stretching the half triangle and dragging the midpoint vertex to v3.
    gl_Position = sideBaryCoord.x * stretchedHalf[0] + sideBaryCoord.y * stretchedHalf[1] + sideBaryCoord.z * stretchedHalf[2];
}
#version 460
layout (quads, equal_spacing, ccw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};

// This assumes 2D, calculates barycentrics for point p inside triangle (a, b, c)
vec3 calcBaryCoords(vec2 p, vec2 a, vec2 b, vec2 c)
{
    const vec2 v0 = b - a;
    const vec2 v1 = c - a;
    const vec2 v2 = p - a;

    const float den = v0.x * v1.y - v1.x * v0.y;
    const float v   = (v2.x * v1.y - v1.x * v2.y) / den;
    const float w   = (v0.x * v2.y - v2.x * v0.y) / den;
    const float u   = 1.0 - v - w;

    return vec3(u, v, w);
}

void main() {
    const vec4 p0 = gl_in[0].gl_Position;
    const vec4 p1 = gl_in[1].gl_Position;
    const vec4 p2 = gl_in[2].gl_Position;
    const vec4 p3 = gl_in[3].gl_Position;
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    gl_Position = (1 - u) * (1 - v) * p0 + (1 - u) * v * p1 + u * (1 - v) * p2 + u * v * p3;
}
#version 460
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(0.0, 1.0, 1.0, 1.0);
}
#version 460
layout (quads, fractional_odd_spacing, ccw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};

// This assumes 2D, calculates barycentrics for point p inside triangle (a, b, c)
vec3 calcBaryCoords(vec2 p, vec2 a, vec2 b, vec2 c)
{
    const vec2 v0 = b - a;
    const vec2 v1 = c - a;
    const vec2 v2 = p - a;

    const float den = v0.x * v1.y - v1.x * v0.y;
    const float v   = (v2.x * v1.y - v1.x * v2.y) / den;
    const float w   = (v0.x * v2.y - v2.x * v0.y) / den;
    const float u   = 1.0 - v - w;

    return vec3(u, v, w);
}

void main() {
    const vec4 p0 = gl_in[0].gl_Position;
    const vec4 p1 = gl_in[1].gl_Position;
    const vec4 p2 = gl_in[2].gl_Position;
    const vec4 p3 = gl_in[3].gl_Position;
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    gl_Position = (1 - u) * (1 - v) * p0 + (1 - u) * v * p1 + u * (1 - v) * p2 + u * v * p3;
}
#version 460
layout (vertices=4) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];
void main() {
    const float extraLevel = 1.0;
    gl_TessLevelInner[0] = 10.0 + extraLevel;
    gl_TessLevelInner[1] = 10.0 + extraLevel;
    gl_TessLevelOuter[0] = 50.0 + extraLevel;
    gl_TessLevelOuter[1] = 40.0 + extraLevel;
    gl_TessLevelOuter[2] = 30.0 + extraLevel;
    gl_TessLevelOuter[3] = 20.0 + extraLevel;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 460
layout (quads, fractional_even_spacing, ccw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};

// This assumes 2D, calculates barycentrics for point p inside triangle (a, b, c)
vec3 calcBaryCoords(vec2 p, vec2 a, vec2 b, vec2 c)
{
    const vec2 v0 = b - a;
    const vec2 v1 = c - a;
    const vec2 v2 = p - a;

    const float den = v0.x * v1.y - v1.x * v0.y;
    const float v   = (v2.x * v1.y - v1.x * v2.y) / den;
    const float w   = (v0.x * v2.y - v2.x * v0.y) / den;
    const float u   = 1.0 - v - w;

    return vec3(u, v, w);
}

void main() {
    const vec4 p0 = gl_in[0].gl_Position;
    const vec4 p1 = gl_in[1].gl_Position;
    const vec4 p2 = gl_in[2].gl_Position;
    const vec4 p3 = gl_in[3].gl_Position;
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    gl_Position = (1 - u) * (1 - v) * p0 + (1 - u) * v * p1 + u * (1 - v) * p2 + u * v * p3;
}
#version 460
layout (vertices=3) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];
void main() {
    const float extraLevel = 0.0;
    gl_TessLevelInner[0] = 10.0 + extraLevel;
    gl_TessLevelInner[1] = 10.0 + extraLevel;
    gl_TessLevelOuter[0] = 50.0 + extraLevel;
    gl_TessLevelOuter[1] = 40.0 + extraLevel;
    gl_TessLevelOuter[2] = 30.0 + extraLevel;
    gl_TessLevelOuter[3] = 20.0 + extraLevel;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 460
layout (quads, equal_spacing, ccw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};

// This assumes 2D, calculates barycentrics for point p inside triangle (a, b, c)
vec3 calcBaryCoords(vec2 p, vec2 a, vec2 b, vec2 c)
{
    const vec2 v0 = b - a;
    const vec2 v1 = c - a;
    const vec2 v2 = p - a;

    const float den = v0.x * v1.y - v1.x * v0.y;
    const float v   = (v2.x * v1.y - v1.x * v2.y) / den;
    const float w   = (v0.x * v2.y - v2.x * v0.y) / den;
    const float u   = 1.0 - v - w;

    return vec3(u, v, w);
}

void main() {
    const vec4 p0 = gl_in[0].gl_Position;
    const vec4 p1 = gl_in[1].gl_Position;
    const vec4 p2 = gl_in[2].gl_Position;
    const float delta  = 0.75;
    const float width  = p2.x - p0.x;
    const float height = p1.y - p0.y;
    const vec4 p3 = vec4(p0.x + width * delta, p0.y + height * delta, p0.z, p0.w);
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    gl_Position = (1 - u) * (1 - v) * p0 + (1 - u) * v * p1 + u * (1 - v) * p2 + u * v * p3;
}
#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main() {
    gl_Position    = gl_in[0].gl_Position; EmitVertex();
    gl_Position    = gl_in[1].gl_Position; EmitVertex();
    gl_Position    = gl_in[2].gl_Position; EmitVertex();
    gl_PrimitiveID = gl_PrimitiveIDIn;     EndPrimitive();
}
#version 450 core

layout(set = 0, binding = 0) buffer coherent block {
   uint ssbo_val;
};

layout(location=0) in vec2 position;
layout(location=0) out uint patch_index;

void main() {
   gl_Position = vec4(position, 0.0, 1.0);
   patch_index = gl_InstanceIndex;

   /*
    * RADV groups TCS wave in workgroups similar to compute ones.
    *
    * This test assumes that the TCS workgroup has at most 256 invocations (64 patches). Try to
    * cause the first wave of the workgroup to start the TCS much later than ones which write
    * non-zero factors.
    *
    * This loop makes the test much more likely to fail.
   */
   uint wave32_in_workgroup = patch_index % 64u / 8u;
   uint threshold = patch_index / 64u % 8u;
   if (wave32_in_workgroup <= threshold) {
      /*for (uint i = 0; i < 8192; i++) {
         patch_index += (i & 0x1) == 0 ? -1 : 1;
      }*/
      for (uint i = 0; i < 160; i++)
         atomicAdd(ssbo_val, i);
   }
}
#version 450 core

/*
 * For the workgroup barriers to be optimized to wave ones, each TCS output patch must be part of a
 * single wave.
 */
layout(vertices = 4) out;

layout(location=0) in uint patch_index_in[];

void main() {
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

   /* The compiler must either know that all invocations define tessellation levels or that a
    * workgroup barrier exists. This test ensures that both are true.
    */
   barrier();

   /*
    * We assume that the TCS workgroup has 256 invocations (64 patches). All waves in the workgroup
    * will discard all patches except for the last. If the timing is right, the bug causes the
    * factors of the last wave to be dismissed when determining whether all waves in the workgroup
    * write zero as a factor.
   */
   uint patch_index = patch_index_in[gl_InvocationID];
   uint wave32_in_workgroup = patch_index % 64u / 8u;
   if (wave32_in_workgroup == 7) {
      uint index_in_wave32 = patch_index % 8u;
      uint workgroup_index = patch_index / 64u;
      uint index = (workgroup_index * 8u) + index_in_wave32;
      uint grid_size = 256;
      vec2 pos = (vec2(index % grid_size, index / grid_size) + gl_out[gl_InvocationID].gl_Position.xy);
      gl_out[gl_InvocationID].gl_Position.xy = pos / float(grid_size) * 2.0 - 1.0;

      gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   } else {
      gl_TessLevelOuter = float[4](0.0, 0.0, 0.0, 0.0);
   }
   gl_TessLevelInner = float[2](0.0, 0.0);
}
#version 450 core

layout(quads) in;

void main() {
   vec4 low = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord[0]);
   vec4 high = mix(gl_in[3].gl_Position, gl_in[2].gl_Position, gl_TessCoord[0]);
   gl_Position = mix(low, high, gl_TessCoord[1]);
}
#version 450 core

layout(location = 0) out vec4 color;

void main() {
   color = vec4(0.502, 1.0, 0.502, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIdx;
out gl_PerVertex {
    vec4 gl_Position;
};
void main(void) {
    gl_Position = inPos;
    instanceIdx = gl_InstanceIndex;
}
#version 460
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
layout (location=0) in flat int instanceIdxIn[];
layout (location=0) out flat int instanceIdxOut[];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];
void main() {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    instanceIdxOut[gl_InvocationID] = instanceIdxIn[gl_InvocationID];
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
}
#version 460
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
layout (location=0) in flat int instanceIdxIn[];
layout (location=0) out flat int instanceIdxOut;
out gl_PerVertex {
    vec4 gl_Position;
};
void main() {
    gl_Position = (gl_in[0].gl_Position * gl_TessCoord.x + 
                   gl_in[1].gl_Position * gl_TessCoord.y + 
                   gl_in[2].gl_Position * gl_TessCoord.z);
    instanceIdxOut = instanceIdxIn[0];
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat int instanceIdx;
void main(void) {
    outColor = vec4(0.0, 0.0, float(instanceIdx), 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
out gl_PerVertex
{
  vec4 gl_Position;
  float gl_PointSize;
};
layout (location=0, component=0) out float vsA;
layout (location=0, component=1) out float vsB;
layout (location=0, component=2) out vec2  vsCD;
layout (location=1)              out vec4  vsEFGH;
void main() {
    gl_Position = inPos;
    gl_PointSize = 1.0;
    vsA    = 0.125;
    vsB    = 0.375;
    vsCD   = vec2(0.625, 0.875);
    vsEFGH = vec4(0.1, 0.2, 0.3, 0.4);
}
#version 460
layout (vertices=3) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];
layout (location=0, component=0) in  float tcInA[];
layout (location=0, component=1) in  float tcInB[];
layout (location=0, component=2) in  vec2  tcInCD[];
layout (location=1)              in  vec4  tcInEFGH[];
layout (location=0, component=0) out float tcOutA[];
layout (location=0, component=1) out float tcOutB[];
layout (location=0, component=2) out vec2  tcOutCD[];
layout (location=1)              out vec4  tcOutEFGH[];
void main() {
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    tcOutA[gl_InvocationID]    = tcInA[gl_InvocationID];
    tcOutB[gl_InvocationID]    = tcInB[gl_InvocationID];
    tcOutCD[gl_InvocationID]   = tcInCD[gl_InvocationID];
    tcOutEFGH[gl_InvocationID] = tcInEFGH[gl_InvocationID];
}
#version 460
layout (triangles, equal_spacing, ccw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (location=0, component=0) in  float teInA[];
layout (location=0, component=1) in  float teInB[];
layout (location=0, component=2) in  vec2  teInCD[];
layout (location=1)              in  vec4  teInEFGH[];
layout (location=0, component=0) out float teOutA;
layout (location=0, component=1) out float teOutB;
layout (location=0, component=2) out vec2  teOutCD;
layout (location=1)              out vec4  teOutEFGH;
void main() {
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position
                + gl_TessCoord.y * gl_in[1].gl_Position
                + gl_TessCoord.z * gl_in[2].gl_Position;
    teOutA    = teInA[0];
    teOutB    = teInB[0];
    teOutCD   = teInCD[0];
    teOutEFGH = teInEFGH[0];
}
#version 460
layout (location=0, component=0) in  float fsA;
layout (location=0, component=1) in  float fsB;
layout (location=0, component=2) in  vec2  fsCD;
layout (location=1)              in  vec4  fsEFGH;
layout (location=0) out vec4 outColor;
void main() {
    const float eps = 0.01;
    bool ok = abs(fsA - 0.125) < eps
           && abs(fsB - 0.375) < eps
           && abs(fsCD.x - 0.625) < eps && abs(fsCD.y - 0.875) < eps
           && abs(fsEFGH.x - 0.1) < eps && abs(fsEFGH.y - 0.2) < eps
           && abs(fsEFGH.z - 0.3) < eps && abs(fsEFGH.w - 0.4) < eps;
    outColor = ok ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (location=0, component=0) out float vsA;
layout (location=0, component=1) out float vsB;
layout (location=0, component=2) out vec2  vsCD;
layout (location=1)              out vec4  vsEFGH;
void main() {
    gl_Position = inPos;
    vsA    = 0.125;
    vsB    = 0.375;
    vsCD   = vec2(0.625, 0.875);
    vsEFGH = vec4(0.1, 0.2, 0.3, 0.4);
}
#version 460
layout (vertices=3) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
  float gl_PointSize;
} gl_out[];
layout (location=0, component=0) in  float tcInA[];
layout (location=0, component=1) in  float tcInB[];
layout (location=0, component=2) in  vec2  tcInCD[];
layout (location=1)              in  vec4  tcInEFGH[];
layout (location=0, component=0) out float tcOutA[];
layout (location=0, component=1) out float tcOutB[];
layout (location=0, component=2) out vec2  tcOutCD[];
layout (location=1)              out vec4  tcOutEFGH[];
void main() {
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_out[gl_InvocationID].gl_PointSize = 1.0;
    tcOutA[gl_InvocationID]    = tcInA[gl_InvocationID];
    tcOutB[gl_InvocationID]    = tcInB[gl_InvocationID];
    tcOutCD[gl_InvocationID]   = tcInCD[gl_InvocationID];
    tcOutEFGH[gl_InvocationID] = tcInEFGH[gl_InvocationID];
}
#version 460
layout (triangles, equal_spacing, ccw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
  float gl_PointSize;
};
layout (location=0, component=0) in  float teInA[];
layout (location=0, component=1) in  float teInB[];
layout (location=0, component=2) in  vec2  teInCD[];
layout (location=1)              in  vec4  teInEFGH[];
layout (location=0, component=0) out float teOutA;
layout (location=0, component=1) out float teOutB;
layout (location=0, component=2) out vec2  teOutCD;
layout (location=1)              out vec4  teOutEFGH;
void main() {
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position
                + gl_TessCoord.y * gl_in[1].gl_Position
                + gl_TessCoord.z * gl_in[2].gl_Position;
    gl_PointSize = 1.0;
    teOutA    = teInA[0];
    teOutB    = teInB[0];
    teOutCD   = teInCD[0];
    teOutEFGH = teInEFGH[0];
}
#version 460

layout (location = 0) in vec4 inPos;
layout (location = 1) in vec4 instancePos;

void main()
{
    vec4 pos = inPos + instancePos;

    gl_Position = pos;
}
#version 460

layout (vertices = 3) out;

void main()
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    
    gl_TessLevelInner[0] = 1.0f;
    gl_TessLevelInner[1] = 1.0f;
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
    gl_TessLevelOuter[2] = 1.0f;
    gl_TessLevelOuter[3] = 1.0f;
    
}
#version 460

layout ( triangles ) in;

void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    gl_Position = (1 - u) * (1 - v) * gl_in[0].gl_Position + (1 - u) * v * gl_in[1].gl_Position + u * (1 - v) * gl_in[2].gl_Position;
}
#version 460

layout (location = 0) out vec4 fragColor;

void main()
{
    fragColor = vec4(1.0f, 0.0f, 1.0f, 1.0f);
}
#version 460

layout (vertices = 4) out;

void main()
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    
    gl_TessLevelInner[0] = 1.0f;
    gl_TessLevelInner[1] = 1.0f;
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
    gl_TessLevelOuter[2] = 1.0f;
    gl_TessLevelOuter[3] = 1.0f;
    
}
#version 460

layout ( quads ) in;

void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    gl_Position = (1 - u) * (1 - v) * gl_in[0].gl_Position + u * (1 - v) * gl_in[1].gl_Position + u * v * gl_in[2].gl_Position + (1 - u) * v * gl_in[3].gl_Position;
}
