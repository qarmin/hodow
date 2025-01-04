#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_gpu_shader5 : require

layout(quads, fractional_even_spacing) in;

layout(location = 0) in highp vec2 in_te_position[];

layout(location = 0) out mediump vec4 in_f_color;

precise gl_Position;

void main (void)
{
    highp vec2 a = (1.0-gl_TessCoord.x)*(1.0-gl_TessCoord.y)*in_te_position[0];
    highp vec2 b = (    gl_TessCoord.x)*(1.0-gl_TessCoord.y)*in_te_position[1];
    highp vec2 c = (1.0-gl_TessCoord.x)*(    gl_TessCoord.y)*in_te_position[2];
    highp vec2 d = (    gl_TessCoord.x)*(    gl_TessCoord.y)*in_te_position[3];
    highp vec2 pos = a+b+c+d;

    highp float f = sqrt(1.0 - 2.0 * max(abs(gl_TessCoord.x - 0.5), abs(gl_TessCoord.y - 0.5)))*0.5 + 0.5;
    in_f_color = vec4(0.1, gl_TessCoord.xy*f, 1.0);

    // Offset the position slightly, based on the parity of the bits in the float representation.
    // This is done to detect possible small differences in edge vertex positions between patches.
    uvec2 bits = floatBitsToUint(pos);
    uint numBits = 0u;
    for (uint i = 0u; i < 32u; i++)
        numBits += ((bits[0] >> i) & 1u) + ((bits[1] >> i) & 1u);
    pos += float(numBits&1u)*0.04;

    gl_Position = vec4(pos, 0.0, 1.0);
}
