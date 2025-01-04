#version 440

layout(local_size_x = 1) in;

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(local_size_x = 1) in;

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[16384];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[16384];
} b_out;

void main (void)
{
    for (int i = 0; i < 16384; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(local_size_x = 1) in;

layout(set = 0, binding = 0, std140) readonly uniform Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(local_size_x = 1) in;

layout(set = 0, binding = 0) uniform utextureBuffer Input;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = texelFetch(Input, i);
    }
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    gl_Position = v_in_position;
    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(location = 0) out vec4 o_color;

void main (void)
{
    o_color = vec4(1.0);
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[16384];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[16384];
} b_out;

void main (void)
{
    gl_Position = v_in_position;
    for (int i = 0; i < 16384; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) readonly uniform Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    gl_Position = v_in_position;
    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0) uniform utextureBuffer Input;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    gl_Position = v_in_position;
    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = texelFetch(Input, i);
    }
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = v_in_position;
}
#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    o_color = vec4(1.0);

    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[16384];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[16384];
} b_out;

void main (void)
{
    o_color = vec4(1.0);

    for (int i = 0; i < 16384; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, std140) readonly uniform Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    o_color = vec4(1.0);

    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0) uniform utextureBuffer Input;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    o_color = vec4(1.0);

    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = texelFetch(Input, i);
    }
}
#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
}
#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[16384];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[16384];
} b_out;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int i = 0; i < 16384; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, std140) readonly uniform Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0) uniform utextureBuffer Input;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = texelFetch(Input, i);
    }
}
#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[16384];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[16384];
} b_out;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int i = 0; i < 16384; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) readonly uniform Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0) uniform utextureBuffer Input;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = texelFetch(Input, i);
    }
}
#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[16384];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[16384];
} b_out;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int i = 0; i < 16384; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) readonly uniform Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0) uniform utextureBuffer Input;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = texelFetch(Input, i);
    }
}
#version 440

layout(local_size_x = 1) in;

layout(set = 0, binding = 0, r32ui) readonly  uniform uimage1D srcImg;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage1D dstImg;

void main (void)
{
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, x, imageLoad(srcImg, x));
}
#version 440

layout(local_size_x = 1) in;

layout(set = 0, binding = 0, r8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, r8) writeonly uniform image2D dstImg;

void main (void)
{
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(local_size_x = 1) in;

layout(set = 0, binding = 0, r16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, r16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(local_size_x = 1) in;

layout(set = 0, binding = 0, rgba8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2D dstImg;

void main (void)
{
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(local_size_x = 1) in;

layout(set = 0, binding = 0, rgba16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(local_size_x = 1) in;

layout(set = 0, binding = 0, rgba32f) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2D dstImg;

void main (void)
{
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(local_size_x = 1) in;

layout(set = 0, binding = 0, r32f) readonly  uniform image3D srcImg;
layout(set = 0, binding = 1, r32f) writeonly uniform image3D dstImg;

void main (void)
{
    for (int z = 0; z < 8; ++z)
    for (int y = 0; y < 64; ++y)
    for (int x = 0; x < 64; ++x)
        imageStore(dstImg, ivec3(x, y, z), imageLoad(srcImg, ivec3(x, y, z)));
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r32ui) readonly  uniform uimage1D srcImg;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage1D dstImg;

void main (void)
{
    gl_Position = v_in_position;
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, x, imageLoad(srcImg, x));
}
#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, r32ui) readonly  uniform uimage1D srcImg;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage1D dstImg;

void main (void)
{
    o_color = vec4(1.0);

    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, x, imageLoad(srcImg, x));
}
#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, r32ui) readonly  uniform uimage1D srcImg;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage1D dstImg;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, x, imageLoad(srcImg, x));
}
#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r32ui) readonly  uniform uimage1D srcImg;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage1D dstImg;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, x, imageLoad(srcImg, x));
}
#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r32ui) readonly  uniform uimage1D srcImg;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage1D dstImg;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, x, imageLoad(srcImg, x));
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, r8) writeonly uniform image2D dstImg;

void main (void)
{
    gl_Position = v_in_position;
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, r8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, r8) writeonly uniform image2D dstImg;

void main (void)
{
    o_color = vec4(1.0);

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, r8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, r8) writeonly uniform image2D dstImg;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, r8) writeonly uniform image2D dstImg;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, r8) writeonly uniform image2D dstImg;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, r16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    gl_Position = v_in_position;
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, r16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, r16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    o_color = vec4(1.0);

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, r16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, r16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, r16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, r16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, rgba8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2D dstImg;

void main (void)
{
    gl_Position = v_in_position;
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, rgba8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2D dstImg;

void main (void)
{
    o_color = vec4(1.0);

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, rgba8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2D dstImg;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, rgba8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2D dstImg;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, rgba8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2D dstImg;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, rgba16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    gl_Position = v_in_position;
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, rgba16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    o_color = vec4(1.0);

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, rgba16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, rgba16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, rgba16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, rgba32f) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2D dstImg;

void main (void)
{
    gl_Position = v_in_position;
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, rgba32f) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2D dstImg;

void main (void)
{
    o_color = vec4(1.0);

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, rgba32f) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2D dstImg;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, rgba32f) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2D dstImg;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, rgba32f) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2D dstImg;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r32f) readonly  uniform image3D srcImg;
layout(set = 0, binding = 1, r32f) writeonly uniform image3D dstImg;

void main (void)
{
    gl_Position = v_in_position;
    for (int z = 0; z < 8; ++z)
    for (int y = 0; y < 64; ++y)
    for (int x = 0; x < 64; ++x)
        imageStore(dstImg, ivec3(x, y, z), imageLoad(srcImg, ivec3(x, y, z)));
}
#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, r32f) readonly  uniform image3D srcImg;
layout(set = 0, binding = 1, r32f) writeonly uniform image3D dstImg;

void main (void)
{
    o_color = vec4(1.0);

    for (int z = 0; z < 8; ++z)
    for (int y = 0; y < 64; ++y)
    for (int x = 0; x < 64; ++x)
        imageStore(dstImg, ivec3(x, y, z), imageLoad(srcImg, ivec3(x, y, z)));
}
#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, r32f) readonly  uniform image3D srcImg;
layout(set = 0, binding = 1, r32f) writeonly uniform image3D dstImg;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int z = 0; z < 8; ++z)
    for (int y = 0; y < 64; ++y)
    for (int x = 0; x < 64; ++x)
        imageStore(dstImg, ivec3(x, y, z), imageLoad(srcImg, ivec3(x, y, z)));
}
#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r32f) readonly  uniform image3D srcImg;
layout(set = 0, binding = 1, r32f) writeonly uniform image3D dstImg;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int z = 0; z < 8; ++z)
    for (int y = 0; y < 64; ++y)
    for (int x = 0; x < 64; ++x)
        imageStore(dstImg, ivec3(x, y, z), imageLoad(srcImg, ivec3(x, y, z)));
}
#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r32f) readonly  uniform image3D srcImg;
layout(set = 0, binding = 1, r32f) writeonly uniform image3D dstImg;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int z = 0; z < 8; ++z)
    for (int y = 0; y < 64; ++y)
    for (int x = 0; x < 64; ++x)
        imageStore(dstImg, ivec3(x, y, z), imageLoad(srcImg, ivec3(x, y, z)));
}
#version 440

layout(location = 0) out vec4 o_color;

void main (void)
{
    o_color = vec4(0.25, 0.49, 0.75, 1);
}
#version 440

layout(location = 0) out uvec4 o_color;

void main (void)
{
    o_color = uvec4(8, 16, 24, 32);
}
#version 440
layout(location = 0) in uvec4 v_in_data;
layout(set = 0, binding = 0, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    b_out.data[gl_VertexIndex] = v_in_data;
    gl_PointSize = 1.0f;
}
#version 440
layout(location = 0) in uvec4 v_in_data;
layout(set = 0, binding = 0, std140) writeonly buffer Output {
    uvec4 data[16384];
} b_out;

void main (void)
{
    b_out.data[gl_VertexIndex] = v_in_data;
    gl_PointSize = 1.0f;
}
#version 440
layout(location = 0) in uint v_in_data;
layout(set = 0, binding = 0, std430) writeonly buffer Output {
    uint data[5];
} b_out;

void main (void)
{
    b_out.data[gl_VertexIndex] = v_in_data;
    gl_PointSize = 1.0f;
}
#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) coherent buffer Data {
    uint value;
} sb_out;

void main (void)
{
    gl_Position = v_in_position;
    atomicAdd(sb_out.value, 1u);
}
#version 440

layout(local_size_x = 1) in;

layout(set = 0, binding = 0, std140) coherent buffer Data {
    uint value;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.value, 1u);
}
#version 440

layout(local_size_x = 1) in;
layout(set = 0, binding = 0, std430) readonly buffer Input {
    uint data[];
} inData;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS msImage;

void main (void)
{
  int  gx    = int(gl_GlobalInvocationID.x);
  int  gy    = int(gl_GlobalInvocationID.y);
  uint value = inData.data[gy * 64 + gx];
  for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx)
    imageStore(msImage, ivec2(gx, gy), sampleNdx, uvec4(value));
}
