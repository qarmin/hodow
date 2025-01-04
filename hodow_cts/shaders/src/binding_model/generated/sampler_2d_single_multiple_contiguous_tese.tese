#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture2D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler2D(u_separateTexture, u_separateSamplerA), vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler2D(u_separateTexture, u_separateSamplerB), vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler2D(u_separateTexture, u_separateSamplerA), vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(sampler2D(u_separateTexture, u_separateSamplerB), vec2(float(1.00781), float(0.175781)), 0.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
