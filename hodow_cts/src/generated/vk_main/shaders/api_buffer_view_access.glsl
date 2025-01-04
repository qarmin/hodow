#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp textureBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0);
    if (quadrant_id == 0)
        result_color += vec4(texelFetch(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += vec4(texelFetch(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += vec4(texelFetch(texelBuffer, 42));
    else
        result_color += vec4(texelFetch(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp itextureBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp ivec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp ivec4 result_color;
    result_color = ivec4(0);
    if (quadrant_id == 0)
        result_color += ivec4(texelFetch(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += ivec4(texelFetch(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += ivec4(texelFetch(texelBuffer, 42));
    else
        result_color += ivec4(texelFetch(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp utextureBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp uvec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp uvec4 result_color;
    result_color = uvec4(0);
    if (quadrant_id == 0)
        result_color += uvec4(texelFetch(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += uvec4(texelFetch(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += uvec4(texelFetch(texelBuffer, 42));
    else
        result_color += uvec4(texelFetch(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp textureBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp ivec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp ivec4 result_color;
    result_color = ivec4(0);
    if (quadrant_id == 0)
        result_color += ivec4(texelFetch(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += ivec4(texelFetch(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += ivec4(texelFetch(texelBuffer, 42));
    else
        result_color += ivec4(texelFetch(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1) uniform highp textureBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp uvec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp uvec4 result_color;
    result_color = uvec4(0);
    if (quadrant_id == 0)
        result_color += uvec4(texelFetch(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += uvec4(texelFetch(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += uvec4(texelFetch(texelBuffer, 42));
    else
        result_color += uvec4(texelFetch(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgb10_a2) uniform highp readonly imageBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0);
    if (quadrant_id == 0)
        result_color += vec4(imageLoad(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += vec4(imageLoad(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += vec4(imageLoad(texelBuffer, 42));
    else
        result_color += vec4(imageLoad(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgb10_a2ui) uniform highp readonly uimageBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp uvec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp uvec4 result_color;
    result_color = uvec4(0);
    if (quadrant_id == 0)
        result_color += uvec4(imageLoad(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += uvec4(imageLoad(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += uvec4(imageLoad(texelBuffer, 42));
    else
        result_color += uvec4(imageLoad(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba16) uniform highp readonly imageBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0);
    if (quadrant_id == 0)
        result_color += vec4(imageLoad(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += vec4(imageLoad(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += vec4(imageLoad(texelBuffer, 42));
    else
        result_color += vec4(imageLoad(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba16_snorm) uniform highp readonly imageBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0);
    if (quadrant_id == 0)
        result_color += vec4(imageLoad(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += vec4(imageLoad(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += vec4(imageLoad(texelBuffer, 42));
    else
        result_color += vec4(imageLoad(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba16f) uniform highp readonly imageBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0);
    if (quadrant_id == 0)
        result_color += vec4(imageLoad(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += vec4(imageLoad(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += vec4(imageLoad(texelBuffer, 42));
    else
        result_color += vec4(imageLoad(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba16i) uniform highp readonly iimageBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp ivec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp ivec4 result_color;
    result_color = ivec4(0);
    if (quadrant_id == 0)
        result_color += ivec4(imageLoad(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += ivec4(imageLoad(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += ivec4(imageLoad(texelBuffer, 42));
    else
        result_color += ivec4(imageLoad(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba16ui) uniform highp readonly uimageBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp uvec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp uvec4 result_color;
    result_color = uvec4(0);
    if (quadrant_id == 0)
        result_color += uvec4(imageLoad(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += uvec4(imageLoad(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += uvec4(imageLoad(texelBuffer, 42));
    else
        result_color += uvec4(imageLoad(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8) uniform highp readonly imageBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0);
    if (quadrant_id == 0)
        result_color += vec4(imageLoad(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += vec4(imageLoad(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += vec4(imageLoad(texelBuffer, 42));
    else
        result_color += vec4(imageLoad(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) uniform highp readonly imageBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    result_color = vec4(0);
    if (quadrant_id == 0)
        result_color += vec4(imageLoad(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += vec4(imageLoad(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += vec4(imageLoad(texelBuffer, 42));
    else
        result_color += vec4(imageLoad(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8i) uniform highp readonly iimageBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp ivec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp ivec4 result_color;
    result_color = ivec4(0);
    if (quadrant_id == 0)
        result_color += ivec4(imageLoad(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += ivec4(imageLoad(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += ivec4(imageLoad(texelBuffer, 42));
    else
        result_color += ivec4(imageLoad(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 440
#extension GL_EXT_texture_buffer : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 1, rgba8ui) uniform highp readonly uimageBuffer  texelBuffer;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp uvec4 read_colors[4];
} b_out;
void main (void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp uvec4 result_color;
    result_color = uvec4(0);
    if (quadrant_id == 0)
        result_color += uvec4(imageLoad(texelBuffer, 6));
    else if (quadrant_id == 1)
        result_color += uvec4(imageLoad(texelBuffer, 51));
    else if (quadrant_id == 2)
        result_color += uvec4(imageLoad(texelBuffer, 42));
    else
        result_color += uvec4(imageLoad(texelBuffer, 25));
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es
layout (location = 0) in highp vec4 a_position;
void main()
{
    gl_Position = a_position;
}
#version 310 es
#extension GL_EXT_texture_buffer : enable
layout (set=0, binding=0) uniform highp utextureBuffer u_buffer;
layout (location = 0) out highp uint o_color;
void main()
{
    o_color = texelFetch(u_buffer, int(gl_FragCoord.x)).x;
}
#version 450
#extension GL_EXT_texture_buffer : enable
#extension GL_EXT_shader_image_load_store : enable
layout (set=0, binding=0) uniform highp utextureBuffer u_buffer;
layout (set=0, binding=1, r32ui) uniform writeonly uimage2D o_color;
void main()
{
    uint index = gl_GlobalInvocationID.x;
    uint value = texelFetch(u_buffer, int(index)).x;
    imageStore(o_color, ivec2(index, index), uvec4(value, 0, 0, 0));
}
