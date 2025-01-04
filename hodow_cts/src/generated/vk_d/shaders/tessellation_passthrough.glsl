#version 310 es

layout(location = 0) in  highp vec4 a_position;
layout(location = 0) out highp vec4 v_vertex_color;

void main (void)
{
    gl_Position = a_position;
    v_vertex_color = vec4(a_position.x * 0.5 + 0.5, a_position.y * 0.5 + 0.5, 1.0, 0.4);
}
#version 310 es

layout(location = 0) in  highp   vec4 v_fragment_color;
layout(location = 0) out mediump vec4 fragColor;
void main (void)
{
    fragColor = v_fragment_color;
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

layout(location = 0) in  highp vec4 v_vertex_color[];
layout(location = 0) out highp vec4 v_patch_color[];

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    v_patch_color[gl_InvocationID] = v_vertex_color[gl_InvocationID];

    gl_TessLevelInner[0] = sb_levels.inner0;
    gl_TessLevelInner[1] = sb_levels.inner1;
    gl_TessLevelOuter[0] = sb_levels.outer0;
    gl_TessLevelOuter[1] = sb_levels.outer1;
    gl_TessLevelOuter[2] = sb_levels.outer2;
    gl_TessLevelOuter[3] = sb_levels.outer3;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;

layout(location = 0) in  highp vec4 v_patch_color[];
layout(location = 0) out highp vec4 v_fragment_color;

// note: No need to use precise gl_Position since we do not require gapless geometry
void main (void)
{
    vec3 weights = vec3(pow(gl_TessCoord.x, 1.3), pow(gl_TessCoord.y, 1.3), pow(gl_TessCoord.z, 1.3));
    vec3 cweights = gl_TessCoord;
    gl_Position = vec4(weights.x * gl_in[0].gl_Position.xyz + weights.y * gl_in[1].gl_Position.xyz + weights.z * gl_in[2].gl_Position.xyz, 1.0);
    v_fragment_color = cweights.x * v_patch_color[0] + cweights.y * v_patch_color[1] + cweights.z * v_patch_color[2];
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;

layout(location = 0) in  highp vec4 v_patch_color[];
layout(location = 0) out highp vec4 v_evaluated_color;

// note: No need to use precise gl_Position since we do not require gapless geometry
void main (void)
{
    vec3 weights = vec3(pow(gl_TessCoord.x, 1.3), pow(gl_TessCoord.y, 1.3), pow(gl_TessCoord.z, 1.3));
    vec3 cweights = gl_TessCoord;
    gl_Position = vec4(weights.x * gl_in[0].gl_Position.xyz + weights.y * gl_in[1].gl_Position.xyz + weights.z * gl_in[2].gl_Position.xyz, 1.0);
    v_evaluated_color = cweights.x * v_patch_color[0] + cweights.y * v_patch_color[1] + cweights.z * v_patch_color[2];
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;

layout(location = 0) in  highp vec4 v_evaluated_color[];
layout(location = 0) out highp vec4 v_fragment_color;

void main (void)
{
    for (int ndx = 0; ndx < gl_in.length(); ++ndx)
    {
        gl_Position = gl_in[ndx].gl_Position;
        v_fragment_color = v_evaluated_color[ndx];
        EmitVertex();
    }
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

layout(location = 0) in  highp vec4 v_vertex_color[];
layout(location = 0) out highp vec4 v_patch_color[];

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    v_patch_color[gl_InvocationID] = v_vertex_color[gl_InvocationID];

    gl_TessLevelInner[0] = sb_levels.inner0;
    gl_TessLevelInner[1] = sb_levels.inner1;
    gl_TessLevelOuter[0] = sb_levels.outer0;
    gl_TessLevelOuter[1] = sb_levels.outer1;
    gl_TessLevelOuter[2] = sb_levels.outer2;
    gl_TessLevelOuter[3] = sb_levels.outer3;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(quads) in;

layout(location = 0) in  highp vec4 v_patch_color[];
layout(location = 0) out highp vec4 v_fragment_color;

// note: No need to use precise gl_Position since we do not require gapless geometry
void main (void)
{
    vec2 normalizedCoord = (gl_TessCoord.xy * 2.0 - vec2(1.0));
    vec2 normalizedWeights = normalizedCoord * (vec2(1.0) - 0.3 * cos(normalizedCoord.yx * 1.57));
    vec2 weights = normalizedWeights * 0.5 + vec2(0.5);
    vec2 cweights = gl_TessCoord.xy;
    gl_Position = mix(mix(gl_in[0].gl_Position, gl_in[1].gl_Position, weights.y), mix(gl_in[2].gl_Position, gl_in[3].gl_Position, weights.y), weights.x);
    v_fragment_color = mix(mix(v_patch_color[0], v_patch_color[1], cweights.y), mix(v_patch_color[2], v_patch_color[3], cweights.y), cweights.x);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(quads) in;

layout(location = 0) in  highp vec4 v_patch_color[];
layout(location = 0) out highp vec4 v_evaluated_color;

// note: No need to use precise gl_Position since we do not require gapless geometry
void main (void)
{
    vec2 normalizedCoord = (gl_TessCoord.xy * 2.0 - vec2(1.0));
    vec2 normalizedWeights = normalizedCoord * (vec2(1.0) - 0.3 * cos(normalizedCoord.yx * 1.57));
    vec2 weights = normalizedWeights * 0.5 + vec2(0.5);
    vec2 cweights = gl_TessCoord.xy;
    gl_Position = mix(mix(gl_in[0].gl_Position, gl_in[1].gl_Position, weights.y), mix(gl_in[2].gl_Position, gl_in[3].gl_Position, weights.y), weights.x);
    v_evaluated_color = mix(mix(v_patch_color[0], v_patch_color[1], cweights.y), mix(v_patch_color[2], v_patch_color[3], cweights.y), cweights.x);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(isolines) in;

layout(location = 0) in  highp vec4 v_patch_color[];
layout(location = 0) out highp vec4 v_fragment_color;

// note: No need to use precise gl_Position since we do not require gapless geometry
void main (void)
{
    vec2 normalizedCoord = (gl_TessCoord.xy * 2.0 - vec2(1.0));
    vec2 normalizedWeights = normalizedCoord * (vec2(1.0) - 0.3 * cos(normalizedCoord.yx * 1.57));
    vec2 weights = normalizedWeights * 0.5 + vec2(0.5);
    vec2 cweights = gl_TessCoord.xy;
    gl_Position = mix(mix(gl_in[0].gl_Position, gl_in[1].gl_Position, weights.y), mix(gl_in[2].gl_Position, gl_in[3].gl_Position, weights.y), weights.x);
    v_fragment_color = mix(mix(v_patch_color[0], v_patch_color[1], cweights.y), mix(v_patch_color[2], v_patch_color[3], cweights.y), cweights.x);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(isolines) in;

layout(location = 0) in  highp vec4 v_patch_color[];
layout(location = 0) out highp vec4 v_evaluated_color;

// note: No need to use precise gl_Position since we do not require gapless geometry
void main (void)
{
    vec2 normalizedCoord = (gl_TessCoord.xy * 2.0 - vec2(1.0));
    vec2 normalizedWeights = normalizedCoord * (vec2(1.0) - 0.3 * cos(normalizedCoord.yx * 1.57));
    vec2 weights = normalizedWeights * 0.5 + vec2(0.5);
    vec2 cweights = gl_TessCoord.xy;
    gl_Position = mix(mix(gl_in[0].gl_Position, gl_in[1].gl_Position, weights.y), mix(gl_in[2].gl_Position, gl_in[3].gl_Position, weights.y), weights.x);
    v_evaluated_color = mix(mix(v_patch_color[0], v_patch_color[1], cweights.y), mix(v_patch_color[2], v_patch_color[3], cweights.y), cweights.x);
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(lines) in;
layout(line_strip, max_vertices=2) out;

layout(location = 0) in  highp vec4 v_evaluated_color[];
layout(location = 0) out highp vec4 v_fragment_color;

void main (void)
{
    for (int ndx = 0; ndx < gl_in.length(); ++ndx)
    {
        gl_Position = gl_in[ndx].gl_Position;
        v_fragment_color = v_evaluated_color[ndx];
        EmitVertex();
    }
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;

layout(location = 0) in  highp vec4 v_control_color[];
layout(location = 0) out highp vec4 v_evaluated_color;

// note: No need to use precise gl_Position since we do not require gapless geometry
void main (void)
{
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
    v_evaluated_color = gl_TessCoord.x * v_control_color[0] + gl_TessCoord.y * v_control_color[1] + gl_TessCoord.z * v_control_color[2];
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=8) out;

layout(location = 0) in  highp vec4 v_evaluated_color[];
layout(location = 0) out highp vec4 v_fragment_color;

void main (void)
{
    vec4 centerPos = (gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position) / 3.0f;

    for (int ndx = 0; ndx < 4; ++ndx)
    {
        gl_Position = centerPos + (centerPos - gl_in[ndx % 3].gl_Position);
        v_fragment_color = v_evaluated_color[ndx % 3];
        EmitVertex();

        gl_Position = centerPos + 0.7 * (centerPos - gl_in[ndx % 3].gl_Position);
        v_fragment_color = v_evaluated_color[ndx % 3];
        EmitVertex();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=8) out;

layout(location = 0) in  highp vec4 v_vertex_color[];
layout(location = 0) out highp vec4 v_fragment_color;

void main (void)
{
    vec4 centerPos = (gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position) / 3.0f;

    for (int ndx = 0; ndx < 4; ++ndx)
    {
        gl_Position = centerPos + (centerPos - gl_in[ndx % 3].gl_Position);
        v_fragment_color = v_vertex_color[ndx % 3];
        EmitVertex();

        gl_Position = centerPos + 0.7 * (centerPos - gl_in[ndx % 3].gl_Position);
        v_fragment_color = v_vertex_color[ndx % 3];
        EmitVertex();
    }
}
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
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(lines) in;
layout(line_strip, max_vertices=11) out;

layout(location = 0) in  highp vec4 v_evaluated_color[];
layout(location = 0) out highp vec4 v_fragment_color;

void main (void)
{
    vec4 mdir = vec4(gl_in[0].gl_Position.y - gl_in[1].gl_Position.y, gl_in[1].gl_Position.x - gl_in[0].gl_Position.x, 0.0, 0.0);
    for (int i = 0; i <= 10; ++i)
    {
        float xweight = cos(float(i) / 10.0 * 6.28) * 0.5 + 0.5;
        float mweight = sin(float(i) / 10.0 * 6.28) * 0.1 + 0.1;
        gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, xweight) + mweight * mdir;
        v_fragment_color = mix(v_evaluated_color[0], v_evaluated_color[1], xweight);
        EmitVertex();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(lines) in;
layout(line_strip, max_vertices=11) out;

layout(location = 0) in  highp vec4 v_vertex_color[];
layout(location = 0) out highp vec4 v_fragment_color;

void main (void)
{
    vec4 mdir = vec4(gl_in[0].gl_Position.y - gl_in[1].gl_Position.y, gl_in[1].gl_Position.x - gl_in[0].gl_Position.x, 0.0, 0.0);
    for (int i = 0; i <= 10; ++i)
    {
        float xweight = cos(float(i) / 10.0 * 6.28) * 0.5 + 0.5;
        float mweight = sin(float(i) / 10.0 * 6.28) * 0.1 + 0.1;
        gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, xweight) + mweight * mdir;
        v_fragment_color = mix(v_vertex_color[0], v_vertex_color[1], xweight);
        EmitVertex();
    }
}
