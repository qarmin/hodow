#version 450
#extension GL_EXT_nonuniform_qualifier : require

layout(local_size_x = 8) in;

layout(set = 0, binding = 0) uniform utexture2D Tex0[];
layout(set = 1, binding = 0) uniform utexture2D Tex1[];
layout(set = 2, binding = 0) uniform utexture2D Tex2[];
layout(set = 3, binding = 0) writeonly buffer SSBO { uvec4 data[]; };
layout(set = 3, binding = 1) uniform sampler Samp;

void main()
{
    uint index = gl_GlobalInvocationID.x;
    uvec4 a = textureLod(nonuniformEXT(usampler2D(Tex0[index], Samp)), vec2(0.0,0.0), 0.0);
    uvec4 b = textureLod(nonuniformEXT(usampler2D(Tex1[index], Samp)), vec2(0.0,0.0), 0.0);
    uvec4 c = textureLod(nonuniformEXT(usampler2D(Tex2[index], Samp)), vec2(0.0,0.0), 0.0);
    data[index] = a * b + c;
}
#version 450
#extension GL_EXT_nonuniform_qualifier : require

layout(local_size_x = 8) in;

layout(set = 0, binding = 0) uniform utexture2D Tex0[];
layout(set = 1, binding = 0) uniform utexture2D Tex1[];
layout(set = 2, binding = 0) uniform utexture2D Tex2[];
layout(set = 3, binding = 0) writeonly buffer SSBO { uvec4 data[]; };
layout(set = 3, binding = 1) uniform sampler Samp;

void main()
{
    uint index = gl_GlobalInvocationID.x;
    uvec4 a = textureLod(nonuniformEXT(usampler2D(Tex0[index], Samp)), vec2(0.5,0.5), 0.0);
    uvec4 b = textureLod(nonuniformEXT(usampler2D(Tex1[index], Samp)), vec2(0.5,0.5), 0.0);
    uvec4 c = textureLod(nonuniformEXT(usampler2D(Tex2[index], Samp)), vec2(0.5,0.5), 0.0);
    data[index] = a * b + c;
}
#version 450
#extension GL_EXT_nonuniform_qualifier : require

layout(local_size_x = 64) in;

layout(set = 0, binding = 0) uniform utexture2D Tex0[];
layout(set = 1, binding = 0) uniform utexture2D Tex1[];
layout(set = 2, binding = 0) uniform utexture2D Tex2[];
layout(set = 3, binding = 0) writeonly buffer SSBO { uvec4 data[]; };
layout(set = 3, binding = 1) uniform sampler Samp;

void main()
{
    uint index = gl_GlobalInvocationID.x;
    uvec4 a = textureLod(nonuniformEXT(usampler2D(Tex0[index], Samp)), vec2(0.0,0.0), 0.0);
    uvec4 b = textureLod(nonuniformEXT(usampler2D(Tex1[index], Samp)), vec2(0.0,0.0), 0.0);
    uvec4 c = textureLod(nonuniformEXT(usampler2D(Tex2[index], Samp)), vec2(0.0,0.0), 0.0);
    data[index] = a * b + c;
}
#version 450
#extension GL_EXT_nonuniform_qualifier : require

layout(local_size_x = 64) in;

layout(set = 0, binding = 0) uniform utexture2D Tex0[];
layout(set = 1, binding = 0) uniform utexture2D Tex1[];
layout(set = 2, binding = 0) uniform utexture2D Tex2[];
layout(set = 3, binding = 0) writeonly buffer SSBO { uvec4 data[]; };
layout(set = 3, binding = 1) uniform sampler Samp;

void main()
{
    uint index = gl_GlobalInvocationID.x;
    uvec4 a = textureLod(nonuniformEXT(usampler2D(Tex0[index], Samp)), vec2(0.5,0.5), 0.0);
    uvec4 b = textureLod(nonuniformEXT(usampler2D(Tex1[index], Samp)), vec2(0.5,0.5), 0.0);
    uvec4 c = textureLod(nonuniformEXT(usampler2D(Tex2[index], Samp)), vec2(0.5,0.5), 0.0);
    data[index] = a * b + c;
}
#version 450
layout(location = 0) out vec2 uv;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * 2.0f - 1.0f, 0.0f, 1.0f);
    uv = pos;
}
#version 450
layout(location = 0) in vec2 uv;
layout(location = 0) out vec4 color;
layout(set = 0, binding = 1) uniform sampler2D tex[8];
void main() {
    color = texture(tex[0], uv) * texture(tex[1], uv);
}
#version 450
#extension GL_EXT_nonuniform_qualifier : require
layout(local_size_x=64, local_size_y=1, local_size_z=1) in;

layout(set=0, binding=0, std430) writeonly buffer SSBO
{
    uint singleValue[];
} indicesSSBO[];

layout(set=1, binding=0, std430) buffer AtomicCounterSSBO
{
    uint counter;
} counterSSBO[];

void main()
{
    if (gl_GlobalInvocationID.x < 128u)
    {
        indicesSSBO[nonuniformEXT(gl_GlobalInvocationID.x)].singleValue[0u] = gl_GlobalInvocationID.x + 1u;
        uint unused = atomicAdd(counterSSBO[nonuniformEXT(gl_GlobalInvocationID.x & 0x7FFFFCu)].counter, 1u);
    }
}
