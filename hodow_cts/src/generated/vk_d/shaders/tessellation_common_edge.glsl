#version 310 es

layout(location = 0) in highp vec2  in_v_position;
layout(location = 1) in highp float in_v_tessParam;

layout(location = 0) out highp vec2  in_tc_position;
layout(location = 1) out highp float in_tc_tessParam;

void main (void)
{
    in_tc_position = in_v_position;
    in_tc_tessParam = in_v_tessParam;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;

layout(location = 0) in highp vec2  in_tc_position[];
layout(location = 1) in highp float in_tc_tessParam[];

layout(location = 0) out highp vec2 in_te_position[];

void main (void)
{
    in_te_position[gl_InvocationID] = in_tc_position[gl_InvocationID];

    gl_TessLevelInner[0] = 5.0;
    gl_TessLevelInner[1] = 5.0;

    gl_TessLevelOuter[0] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[1] + in_tc_tessParam[2]);
    gl_TessLevelOuter[1] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[2] + in_tc_tessParam[0]);
    gl_TessLevelOuter[2] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[0] + in_tc_tessParam[1]);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, equal_spacing) in;

layout(location = 0) in highp vec2 in_te_position[];

layout(location = 0) out mediump vec4 in_f_color;

void main (void)
{
    highp vec2 pos = gl_TessCoord.x*in_te_position[0] + gl_TessCoord.y*in_te_position[1] + gl_TessCoord.z*in_te_position[2];

    highp float f = sqrt(3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z))) * 0.5 + 0.5;
    in_f_color = vec4(gl_TessCoord*f, 1.0);

    // Offset the position slightly, based on the parity of the bits in the float representation.
    // This is done to detect possible small differences in edge vertex positions between patches.
    uvec2 bits = floatBitsToUint(pos);
    uint numBits = 0u;
    for (uint i = 0u; i < 32u; i++)
        numBits += ((bits[0] >> i) & 1u) + ((bits[1] >> i) & 1u);
    pos += float(numBits&1u)*0.04;

    gl_Position = vec4(pos, 0.0, 1.0);
}
#version 310 es

layout(location = 0) in mediump vec4 in_f_color;

layout(location = 0) out mediump vec4 o_color;

void main (void)
{
    o_color = in_f_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_odd_spacing) in;

layout(location = 0) in highp vec2 in_te_position[];

layout(location = 0) out mediump vec4 in_f_color;

void main (void)
{
    highp vec2 pos = gl_TessCoord.x*in_te_position[0] + gl_TessCoord.y*in_te_position[1] + gl_TessCoord.z*in_te_position[2];

    highp float f = sqrt(3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z))) * 0.5 + 0.5;
    in_f_color = vec4(gl_TessCoord*f, 1.0);

    // Offset the position slightly, based on the parity of the bits in the float representation.
    // This is done to detect possible small differences in edge vertex positions between patches.
    uvec2 bits = floatBitsToUint(pos);
    uint numBits = 0u;
    for (uint i = 0u; i < 32u; i++)
        numBits += ((bits[0] >> i) & 1u) + ((bits[1] >> i) & 1u);
    pos += float(numBits&1u)*0.04;

    gl_Position = vec4(pos, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_even_spacing) in;

layout(location = 0) in highp vec2 in_te_position[];

layout(location = 0) out mediump vec4 in_f_color;

void main (void)
{
    highp vec2 pos = gl_TessCoord.x*in_te_position[0] + gl_TessCoord.y*in_te_position[1] + gl_TessCoord.z*in_te_position[2];

    highp float f = sqrt(3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z))) * 0.5 + 0.5;
    in_f_color = vec4(gl_TessCoord*f, 1.0);

    // Offset the position slightly, based on the parity of the bits in the float representation.
    // This is done to detect possible small differences in edge vertex positions between patches.
    uvec2 bits = floatBitsToUint(pos);
    uint numBits = 0u;
    for (uint i = 0u; i < 32u; i++)
        numBits += ((bits[0] >> i) & 1u) + ((bits[1] >> i) & 1u);
    pos += float(numBits&1u)*0.04;

    gl_Position = vec4(pos, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_gpu_shader5 : require

layout(vertices = 3) out;

layout(location = 0) in highp vec2  in_tc_position[];
layout(location = 1) in highp float in_tc_tessParam[];

layout(location = 0) out highp vec2 in_te_position[];

precise gl_TessLevelOuter;

void main (void)
{
    in_te_position[gl_InvocationID] = in_tc_position[gl_InvocationID];

    gl_TessLevelInner[0] = 5.0;
    gl_TessLevelInner[1] = 5.0;

    gl_TessLevelOuter[0] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[1] + in_tc_tessParam[2]);
    gl_TessLevelOuter[1] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[2] + in_tc_tessParam[0]);
    gl_TessLevelOuter[2] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[0] + in_tc_tessParam[1]);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_gpu_shader5 : require

layout(triangles, equal_spacing) in;

layout(location = 0) in highp vec2 in_te_position[];

layout(location = 0) out mediump vec4 in_f_color;

precise gl_Position;

void main (void)
{
    highp vec2 pos = gl_TessCoord.x*in_te_position[0] + gl_TessCoord.y*in_te_position[1] + gl_TessCoord.z*in_te_position[2];

    highp float f = sqrt(3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z))) * 0.5 + 0.5;
    in_f_color = vec4(gl_TessCoord*f, 1.0);

    // Offset the position slightly, based on the parity of the bits in the float representation.
    // This is done to detect possible small differences in edge vertex positions between patches.
    uvec2 bits = floatBitsToUint(pos);
    uint numBits = 0u;
    for (uint i = 0u; i < 32u; i++)
        numBits += ((bits[0] >> i) & 1u) + ((bits[1] >> i) & 1u);
    pos += float(numBits&1u)*0.04;

    gl_Position = vec4(pos, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_gpu_shader5 : require

layout(triangles, fractional_odd_spacing) in;

layout(location = 0) in highp vec2 in_te_position[];

layout(location = 0) out mediump vec4 in_f_color;

precise gl_Position;

void main (void)
{
    highp vec2 pos = gl_TessCoord.x*in_te_position[0] + gl_TessCoord.y*in_te_position[1] + gl_TessCoord.z*in_te_position[2];

    highp float f = sqrt(3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z))) * 0.5 + 0.5;
    in_f_color = vec4(gl_TessCoord*f, 1.0);

    // Offset the position slightly, based on the parity of the bits in the float representation.
    // This is done to detect possible small differences in edge vertex positions between patches.
    uvec2 bits = floatBitsToUint(pos);
    uint numBits = 0u;
    for (uint i = 0u; i < 32u; i++)
        numBits += ((bits[0] >> i) & 1u) + ((bits[1] >> i) & 1u);
    pos += float(numBits&1u)*0.04;

    gl_Position = vec4(pos, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_gpu_shader5 : require

layout(triangles, fractional_even_spacing) in;

layout(location = 0) in highp vec2 in_te_position[];

layout(location = 0) out mediump vec4 in_f_color;

precise gl_Position;

void main (void)
{
    highp vec2 pos = gl_TessCoord.x*in_te_position[0] + gl_TessCoord.y*in_te_position[1] + gl_TessCoord.z*in_te_position[2];

    highp float f = sqrt(3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z))) * 0.5 + 0.5;
    in_f_color = vec4(gl_TessCoord*f, 1.0);

    // Offset the position slightly, based on the parity of the bits in the float representation.
    // This is done to detect possible small differences in edge vertex positions between patches.
    uvec2 bits = floatBitsToUint(pos);
    uint numBits = 0u;
    for (uint i = 0u; i < 32u; i++)
        numBits += ((bits[0] >> i) & 1u) + ((bits[1] >> i) & 1u);
    pos += float(numBits&1u)*0.04;

    gl_Position = vec4(pos, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 4) out;

layout(location = 0) in highp vec2  in_tc_position[];
layout(location = 1) in highp float in_tc_tessParam[];

layout(location = 0) out highp vec2 in_te_position[];

void main (void)
{
    in_te_position[gl_InvocationID] = in_tc_position[gl_InvocationID];

    gl_TessLevelInner[0] = 5.0;
    gl_TessLevelInner[1] = 5.0;

    gl_TessLevelOuter[0] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[0] + in_tc_tessParam[2]);
    gl_TessLevelOuter[1] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[1] + in_tc_tessParam[0]);
    gl_TessLevelOuter[2] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[3] + in_tc_tessParam[1]);
    gl_TessLevelOuter[3] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[2] + in_tc_tessParam[3]);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, equal_spacing) in;

layout(location = 0) in highp vec2 in_te_position[];

layout(location = 0) out mediump vec4 in_f_color;

void main (void)
{
    highp vec2 pos = (1.0-gl_TessCoord.x)*(1.0-gl_TessCoord.y)*in_te_position[0]
                   + (    gl_TessCoord.x)*(1.0-gl_TessCoord.y)*in_te_position[1]
                   + (1.0-gl_TessCoord.x)*(    gl_TessCoord.y)*in_te_position[2]
                   + (    gl_TessCoord.x)*(    gl_TessCoord.y)*in_te_position[3];

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_odd_spacing) in;

layout(location = 0) in highp vec2 in_te_position[];

layout(location = 0) out mediump vec4 in_f_color;

void main (void)
{
    highp vec2 pos = (1.0-gl_TessCoord.x)*(1.0-gl_TessCoord.y)*in_te_position[0]
                   + (    gl_TessCoord.x)*(1.0-gl_TessCoord.y)*in_te_position[1]
                   + (1.0-gl_TessCoord.x)*(    gl_TessCoord.y)*in_te_position[2]
                   + (    gl_TessCoord.x)*(    gl_TessCoord.y)*in_te_position[3];

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_even_spacing) in;

layout(location = 0) in highp vec2 in_te_position[];

layout(location = 0) out mediump vec4 in_f_color;

void main (void)
{
    highp vec2 pos = (1.0-gl_TessCoord.x)*(1.0-gl_TessCoord.y)*in_te_position[0]
                   + (    gl_TessCoord.x)*(1.0-gl_TessCoord.y)*in_te_position[1]
                   + (1.0-gl_TessCoord.x)*(    gl_TessCoord.y)*in_te_position[2]
                   + (    gl_TessCoord.x)*(    gl_TessCoord.y)*in_te_position[3];

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
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_gpu_shader5 : require

layout(vertices = 4) out;

layout(location = 0) in highp vec2  in_tc_position[];
layout(location = 1) in highp float in_tc_tessParam[];

layout(location = 0) out highp vec2 in_te_position[];

precise gl_TessLevelOuter;

void main (void)
{
    in_te_position[gl_InvocationID] = in_tc_position[gl_InvocationID];

    gl_TessLevelInner[0] = 5.0;
    gl_TessLevelInner[1] = 5.0;

    gl_TessLevelOuter[0] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[0] + in_tc_tessParam[2]);
    gl_TessLevelOuter[1] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[1] + in_tc_tessParam[0]);
    gl_TessLevelOuter[2] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[3] + in_tc_tessParam[1]);
    gl_TessLevelOuter[3] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[2] + in_tc_tessParam[3]);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_gpu_shader5 : require

layout(quads, equal_spacing) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_gpu_shader5 : require

layout(quads, fractional_odd_spacing) in;

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
