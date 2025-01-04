#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 1) in  vec4 in_color;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
    out_color = in_color;
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 out_color;

void main(void)
{
    out_color = vec4(in_color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba32f) readonly uniform image2D in_image;
layout(binding=1, rgba32f) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2D u_tex;
layout(binding=1, rgba32f) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba32f) writeonly uniform image2D u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba16f) readonly uniform image2D in_image;
layout(binding=1, rgba16f) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2D u_tex;
layout(binding=1, rgba16f) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba16f) writeonly uniform image2D u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec2 out_color;

void main(void)
{
    out_color = vec2(in_color.rg);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg32f) readonly uniform image2D in_image;
layout(binding=1, rg32f) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2D u_tex;
layout(binding=1, rg32f) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg32f) writeonly uniform image2D u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg16f) readonly uniform image2D in_image;
layout(binding=1, rg16f) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2D u_tex;
layout(binding=1, rg16f) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg16f) writeonly uniform image2D u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out float out_color;

void main(void)
{
    out_color = float(in_color.r);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, r32f) readonly uniform image2D in_image;
layout(binding=1, r32f) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2D u_tex;
layout(binding=1, r32f) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, r32f) writeonly uniform image2D u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out uvec4 out_color;

void main(void)
{
    out_color = uvec4(in_color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba32ui) readonly uniform uimage2D in_image;
layout(binding=1, rgba32ui) writeonly uniform uimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform usampler2D u_tex;
layout(binding=1, rgba32ui) writeonly uniform uimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba32ui) writeonly uniform uimage2D u_image;

const uvec4 colorTable[] = uvec4[](
     uvec4(1886417008, 1010580540, 1701143909, 690563369),
     uvec4(1010580540, 1701143909, 690563369, 1886417008),
     uvec4(690563369, 1886417008, 1010580540, 1701143909),
     uvec4(1701143909, 690563369, 1886417008, 1010580540)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    uvec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba16ui) readonly uniform uimage2D in_image;
layout(binding=1, rgba16ui) writeonly uniform uimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform usampler2D u_tex;
layout(binding=1, rgba16ui) writeonly uniform uimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba16ui) writeonly uniform uimage2D u_image;

const uvec4 colorTable[] = uvec4[](
     uvec4(28784, 15420, 25957, 10537),
     uvec4(15420, 25957, 10537, 28784),
     uvec4(10537, 28784, 15420, 25957),
     uvec4(25957, 10537, 28784, 15420)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    uvec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8ui) readonly uniform uimage2D in_image;
layout(binding=1, rgba8ui) writeonly uniform uimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform usampler2D u_tex;
layout(binding=1, rgba8ui) writeonly uniform uimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8ui) writeonly uniform uimage2D u_image;

const uvec4 colorTable[] = uvec4[](
     uvec4(112, 60, 101, 41),
     uvec4(60, 101, 41, 112),
     uvec4(41, 112, 60, 101),
     uvec4(101, 41, 112, 60)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    uvec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out uvec2 out_color;

void main(void)
{
    out_color = uvec2(in_color.rg);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg32ui) readonly uniform uimage2D in_image;
layout(binding=1, rg32ui) writeonly uniform uimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform usampler2D u_tex;
layout(binding=1, rg32ui) writeonly uniform uimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg32ui) writeonly uniform uimage2D u_image;

const uvec4 colorTable[] = uvec4[](
     uvec4(1886417008, 1010580540, 1701143909, 690563369),
     uvec4(1010580540, 1701143909, 690563369, 1886417008),
     uvec4(690563369, 1886417008, 1010580540, 1701143909),
     uvec4(1701143909, 690563369, 1886417008, 1010580540)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    uvec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg16ui) readonly uniform uimage2D in_image;
layout(binding=1, rg16ui) writeonly uniform uimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform usampler2D u_tex;
layout(binding=1, rg16ui) writeonly uniform uimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg16ui) writeonly uniform uimage2D u_image;

const uvec4 colorTable[] = uvec4[](
     uvec4(28784, 15420, 25957, 10537),
     uvec4(15420, 25957, 10537, 28784),
     uvec4(10537, 28784, 15420, 25957),
     uvec4(25957, 10537, 28784, 15420)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    uvec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out uint out_color;

void main(void)
{
    out_color = uint(in_color.r);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, r32ui) readonly uniform uimage2D in_image;
layout(binding=1, r32ui) writeonly uniform uimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform usampler2D u_tex;
layout(binding=1, r32ui) writeonly uniform uimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, r32ui) writeonly uniform uimage2D u_image;

const uvec4 colorTable[] = uvec4[](
     uvec4(1886417008, 1010580540, 1701143909, 690563369),
     uvec4(1010580540, 1701143909, 690563369, 1886417008),
     uvec4(690563369, 1886417008, 1010580540, 1701143909),
     uvec4(1701143909, 690563369, 1886417008, 1010580540)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    uvec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out ivec4 out_color;

void main(void)
{
    out_color = ivec4(in_color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba32i) readonly uniform iimage2D in_image;
layout(binding=1, rgba32i) writeonly uniform iimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform isampler2D u_tex;
layout(binding=1, rgba32i) writeonly uniform iimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba32i) writeonly uniform iimage2D u_image;

const ivec4 colorTable[] = ivec4[](
     ivec4(1886417008, 1010580540, 1701143909, 690563369),
     ivec4(1010580540, 1701143909, 690563369, 1886417008),
     ivec4(690563369, 1886417008, 1010580540, 1701143909),
     ivec4(1701143909, 690563369, 1886417008, 1010580540)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba16i) readonly uniform iimage2D in_image;
layout(binding=1, rgba16i) writeonly uniform iimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform isampler2D u_tex;
layout(binding=1, rgba16i) writeonly uniform iimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba16i) writeonly uniform iimage2D u_image;

const ivec4 colorTable[] = ivec4[](
     ivec4(28784, 15420, 25957, 10537),
     ivec4(15420, 25957, 10537, 28784),
     ivec4(10537, 28784, 15420, 25957),
     ivec4(25957, 10537, 28784, 15420)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8i) readonly uniform iimage2D in_image;
layout(binding=1, rgba8i) writeonly uniform iimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform isampler2D u_tex;
layout(binding=1, rgba8i) writeonly uniform iimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8i) writeonly uniform iimage2D u_image;

const ivec4 colorTable[] = ivec4[](
     ivec4(112, 60, 101, 41),
     ivec4(60, 101, 41, 112),
     ivec4(41, 112, 60, 101),
     ivec4(101, 41, 112, 60)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out ivec2 out_color;

void main(void)
{
    out_color = ivec2(in_color.rg);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg32i) readonly uniform iimage2D in_image;
layout(binding=1, rg32i) writeonly uniform iimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform isampler2D u_tex;
layout(binding=1, rg32i) writeonly uniform iimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg32i) writeonly uniform iimage2D u_image;

const ivec4 colorTable[] = ivec4[](
     ivec4(1886417008, 1010580540, 1701143909, 690563369),
     ivec4(1010580540, 1701143909, 690563369, 1886417008),
     ivec4(690563369, 1886417008, 1010580540, 1701143909),
     ivec4(1701143909, 690563369, 1886417008, 1010580540)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg16i) readonly uniform iimage2D in_image;
layout(binding=1, rg16i) writeonly uniform iimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform isampler2D u_tex;
layout(binding=1, rg16i) writeonly uniform iimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg16i) writeonly uniform iimage2D u_image;

const ivec4 colorTable[] = ivec4[](
     ivec4(28784, 15420, 25957, 10537),
     ivec4(15420, 25957, 10537, 28784),
     ivec4(10537, 28784, 15420, 25957),
     ivec4(25957, 10537, 28784, 15420)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out int out_color;

void main(void)
{
    out_color = int(in_color.r);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, r32i) readonly uniform iimage2D in_image;
layout(binding=1, r32i) writeonly uniform iimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform isampler2D u_tex;
layout(binding=1, r32i) writeonly uniform iimage2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, r32i) writeonly uniform iimage2D u_image;

const ivec4 colorTable[] = ivec4[](
     ivec4(1886417008, 1010580540, 1701143909, 690563369),
     ivec4(1010580540, 1701143909, 690563369, 1886417008),
     ivec4(690563369, 1886417008, 1010580540, 1701143909),
     ivec4(1701143909, 690563369, 1886417008, 1010580540)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8) readonly uniform image2D in_image;
layout(binding=1, rgba8) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2D u_tex;
layout(binding=1, rgba8) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8) writeonly uniform image2D u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8_snorm) readonly uniform image2D in_image;
layout(binding=1, rgba8_snorm) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2D u_tex;
layout(binding=1, rgba8_snorm) writeonly uniform image2D out_image;

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8_snorm) writeonly uniform image2D u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba32f) readonly uniform image2DArray in_image;
layout(binding=1, rgba32f) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2DArray u_tex;
layout(binding=1, rgba32f) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba32f) writeonly uniform image2DArray u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba16f) readonly uniform image2DArray in_image;
layout(binding=1, rgba16f) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2DArray u_tex;
layout(binding=1, rgba16f) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba16f) writeonly uniform image2DArray u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg32f) readonly uniform image2DArray in_image;
layout(binding=1, rg32f) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2DArray u_tex;
layout(binding=1, rg32f) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg32f) writeonly uniform image2DArray u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg16f) readonly uniform image2DArray in_image;
layout(binding=1, rg16f) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2DArray u_tex;
layout(binding=1, rg16f) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg16f) writeonly uniform image2DArray u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, r32f) readonly uniform image2DArray in_image;
layout(binding=1, r32f) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2DArray u_tex;
layout(binding=1, r32f) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, r32f) writeonly uniform image2DArray u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba32ui) readonly uniform uimage2DArray in_image;
layout(binding=1, rgba32ui) writeonly uniform uimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform usampler2DArray u_tex;
layout(binding=1, rgba32ui) writeonly uniform uimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba32ui) writeonly uniform uimage2DArray u_image;

const uvec4 colorTable[] = uvec4[](
     uvec4(1886417008, 1010580540, 1701143909, 690563369),
     uvec4(1010580540, 1701143909, 690563369, 1886417008),
     uvec4(690563369, 1886417008, 1010580540, 1701143909),
     uvec4(1701143909, 690563369, 1886417008, 1010580540)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    uvec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba16ui) readonly uniform uimage2DArray in_image;
layout(binding=1, rgba16ui) writeonly uniform uimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform usampler2DArray u_tex;
layout(binding=1, rgba16ui) writeonly uniform uimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba16ui) writeonly uniform uimage2DArray u_image;

const uvec4 colorTable[] = uvec4[](
     uvec4(28784, 15420, 25957, 10537),
     uvec4(15420, 25957, 10537, 28784),
     uvec4(10537, 28784, 15420, 25957),
     uvec4(25957, 10537, 28784, 15420)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    uvec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8ui) readonly uniform uimage2DArray in_image;
layout(binding=1, rgba8ui) writeonly uniform uimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform usampler2DArray u_tex;
layout(binding=1, rgba8ui) writeonly uniform uimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8ui) writeonly uniform uimage2DArray u_image;

const uvec4 colorTable[] = uvec4[](
     uvec4(112, 60, 101, 41),
     uvec4(60, 101, 41, 112),
     uvec4(41, 112, 60, 101),
     uvec4(101, 41, 112, 60)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    uvec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg32ui) readonly uniform uimage2DArray in_image;
layout(binding=1, rg32ui) writeonly uniform uimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform usampler2DArray u_tex;
layout(binding=1, rg32ui) writeonly uniform uimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg32ui) writeonly uniform uimage2DArray u_image;

const uvec4 colorTable[] = uvec4[](
     uvec4(1886417008, 1010580540, 1701143909, 690563369),
     uvec4(1010580540, 1701143909, 690563369, 1886417008),
     uvec4(690563369, 1886417008, 1010580540, 1701143909),
     uvec4(1701143909, 690563369, 1886417008, 1010580540)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    uvec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg16ui) readonly uniform uimage2DArray in_image;
layout(binding=1, rg16ui) writeonly uniform uimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform usampler2DArray u_tex;
layout(binding=1, rg16ui) writeonly uniform uimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg16ui) writeonly uniform uimage2DArray u_image;

const uvec4 colorTable[] = uvec4[](
     uvec4(28784, 15420, 25957, 10537),
     uvec4(15420, 25957, 10537, 28784),
     uvec4(10537, 28784, 15420, 25957),
     uvec4(25957, 10537, 28784, 15420)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    uvec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, r32ui) readonly uniform uimage2DArray in_image;
layout(binding=1, r32ui) writeonly uniform uimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform usampler2DArray u_tex;
layout(binding=1, r32ui) writeonly uniform uimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, r32ui) writeonly uniform uimage2DArray u_image;

const uvec4 colorTable[] = uvec4[](
     uvec4(1886417008, 1010580540, 1701143909, 690563369),
     uvec4(1010580540, 1701143909, 690563369, 1886417008),
     uvec4(690563369, 1886417008, 1010580540, 1701143909),
     uvec4(1701143909, 690563369, 1886417008, 1010580540)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    uvec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba32i) readonly uniform iimage2DArray in_image;
layout(binding=1, rgba32i) writeonly uniform iimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform isampler2DArray u_tex;
layout(binding=1, rgba32i) writeonly uniform iimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba32i) writeonly uniform iimage2DArray u_image;

const ivec4 colorTable[] = ivec4[](
     ivec4(1886417008, 1010580540, 1701143909, 690563369),
     ivec4(1010580540, 1701143909, 690563369, 1886417008),
     ivec4(690563369, 1886417008, 1010580540, 1701143909),
     ivec4(1701143909, 690563369, 1886417008, 1010580540)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    ivec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba16i) readonly uniform iimage2DArray in_image;
layout(binding=1, rgba16i) writeonly uniform iimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform isampler2DArray u_tex;
layout(binding=1, rgba16i) writeonly uniform iimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba16i) writeonly uniform iimage2DArray u_image;

const ivec4 colorTable[] = ivec4[](
     ivec4(28784, 15420, 25957, 10537),
     ivec4(15420, 25957, 10537, 28784),
     ivec4(10537, 28784, 15420, 25957),
     ivec4(25957, 10537, 28784, 15420)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    ivec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8i) readonly uniform iimage2DArray in_image;
layout(binding=1, rgba8i) writeonly uniform iimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform isampler2DArray u_tex;
layout(binding=1, rgba8i) writeonly uniform iimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8i) writeonly uniform iimage2DArray u_image;

const ivec4 colorTable[] = ivec4[](
     ivec4(112, 60, 101, 41),
     ivec4(60, 101, 41, 112),
     ivec4(41, 112, 60, 101),
     ivec4(101, 41, 112, 60)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    ivec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg32i) readonly uniform iimage2DArray in_image;
layout(binding=1, rg32i) writeonly uniform iimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform isampler2DArray u_tex;
layout(binding=1, rg32i) writeonly uniform iimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg32i) writeonly uniform iimage2DArray u_image;

const ivec4 colorTable[] = ivec4[](
     ivec4(1886417008, 1010580540, 1701143909, 690563369),
     ivec4(1010580540, 1701143909, 690563369, 1886417008),
     ivec4(690563369, 1886417008, 1010580540, 1701143909),
     ivec4(1701143909, 690563369, 1886417008, 1010580540)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    ivec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg16i) readonly uniform iimage2DArray in_image;
layout(binding=1, rg16i) writeonly uniform iimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform isampler2DArray u_tex;
layout(binding=1, rg16i) writeonly uniform iimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rg16i) writeonly uniform iimage2DArray u_image;

const ivec4 colorTable[] = ivec4[](
     ivec4(28784, 15420, 25957, 10537),
     ivec4(15420, 25957, 10537, 28784),
     ivec4(10537, 28784, 15420, 25957),
     ivec4(25957, 10537, 28784, 15420)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    ivec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, r32i) readonly uniform iimage2DArray in_image;
layout(binding=1, r32i) writeonly uniform iimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform isampler2DArray u_tex;
layout(binding=1, r32i) writeonly uniform iimage2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, r32i) writeonly uniform iimage2DArray u_image;

const ivec4 colorTable[] = ivec4[](
     ivec4(1886417008, 1010580540, 1701143909, 690563369),
     ivec4(1010580540, 1701143909, 690563369, 1886417008),
     ivec4(690563369, 1886417008, 1010580540, 1701143909),
     ivec4(1701143909, 690563369, 1886417008, 1010580540)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    ivec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8) readonly uniform image2DArray in_image;
layout(binding=1, rgba8) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2DArray u_tex;
layout(binding=1, rgba8) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8) writeonly uniform image2DArray u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8_snorm) readonly uniform image2DArray in_image;
layout(binding=1, rgba8_snorm) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, imageLoad(in_image, pos));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0) uniform sampler2DArray u_tex;
layout(binding=1, rgba8_snorm) writeonly uniform image2DArray out_image;

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(out_image, pos, texelFetch(u_tex, pos, 0));
}
#version 450

layout (local_size_x = 1) in;

layout(binding=0, rgba8_snorm) writeonly uniform image2DArray u_image;

const vec4 colorTable[] = vec4[](
     vec4(0, 0.4, 0.8, 0.1),
     vec4(0.5, 0.1, 0.9, 0.2),
     vec4(0.2, 0.6, 1, 0.3),
     vec4(0.3, 0.7, 0, 0.4)
);

void main(void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    vec4 color = colorTable[gl_GlobalInvocationID.z];
    imageStore(u_image, pos, color);
}
