#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture2DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture2DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler2DArray(u_separateTexture0, u_separateSampler0), vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler2DArray(u_separateTexture0, u_separateSampler0), vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler2DArray(u_separateTexture0, u_separateSampler0), vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(sampler2DArray(u_separateTexture0, u_separateSampler0), vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler2DArray(u_separateTexture1, u_separateSampler1), vec3(float(0.0234375), float(0.015625), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler2DArray(u_separateTexture1, u_separateSampler1), vec3(float(0.726562), float(0.296875), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler2DArray(u_separateTexture1, u_separateSampler1), vec3(float(-0.335938), float(1.64062), float(1)), 0.0);
    else
        result_color += textureLod(sampler2DArray(u_separateTexture1, u_separateSampler1), vec3(float(1.01562), float(0.351562), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
