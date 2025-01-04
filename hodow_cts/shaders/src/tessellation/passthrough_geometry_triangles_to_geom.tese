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
