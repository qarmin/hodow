#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140, set = 0, binding = 0) writeonly buffer Output {
  vec4 elements[];
} outData;
layout(push_constant) uniform Material{
  vec4 element;
} matInst;
void main (void)
{
  outData.elements[gl_GlobalInvocationID.x] = matInst.element;
}
#version 450
layout (push_constant, std430) uniform PushConstants {
    ivec4   coords;
    uvec4   baseColor;
    uvec4   multiplier;
    uint    colorOffsets[4];
    uvec4   transparentGreen;
} pc;
layout(rgba8ui, set=0, binding=0) uniform uimage2D simage;
void main() {
    uvec4   colorOffsets = uvec4(pc.colorOffsets[0], pc.colorOffsets[1], pc.colorOffsets[2], pc.colorOffsets[3]);
    uvec4   finalColor   = pc.baseColor * pc.multiplier + colorOffsets + pc.transparentGreen;
    imageStore(simage, pc.coords.xy, finalColor);
}
#version 450

void main()
{
    const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
    const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 inColor;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex
{
  vec4 gl_Position;
};
layout(push_constant) uniform Material {
    layout(offset = 16) vec4 color;
}matInst;
void main()
{
    gl_Position = position;
    vtxColor = vec4(inColor.x + matInst.color.x,
                    inColor.y - matInst.color.y,
                    inColor.z + matInst.color.z,
                    inColor.w + matInst.color.w);
}
#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vtxColor;
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140, set = 0, binding = 0) writeonly buffer Output {
  vec4 elements[];
} outData;
layout(push_constant) uniform Material{
    layout(offset = 16) vec4 element;
} matInst;
void main (void)
{
  outData.elements[gl_GlobalInvocationID.x] = matInst.element;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
int kind;
} matInst;
void main()
{
    gl_Position = position;
switch (matInst.kind) {
case 0: vtxColor = vec4(0.0, 1.0, 0, 1.0); break;
case 1: vtxColor = vec4(0.0, 0.0, 1.0, 1.0); break;
case 2: vtxColor = vec4(1.0, 0.0, 0, 1.0); break;
default: vtxColor = color; break;}
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
vec4 color;
} matInst;
layout(std140, binding = 0) uniform UniformBuf {
vec4 element;
} uniformBuf;
void main()
{
    gl_Position = position;
vtxColor = (matInst.color + uniformBuf.element) * 0.5;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
vec4 color[8];
} matInst;
void main()
{
    gl_Position = position;
vec4 color = vec4(0.0, 0, 0, 0.0);
for (int i = 0; i < 8; i++)
{
  color = color + matInst.color[i];
}
vtxColor = color * 0.125;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
vec4 color[16];
} matInst;
void main()
{
    gl_Position = position;
vec4 color = vec4(0.0, 0, 0, 0.0);
for (int i = 0; i < 16; i++)
{
  color = color + matInst.color[i];
}
vtxColor = color * 0.0625;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
vector<float, 32> color;
} matInst;
void main()
{
    gl_Position = position;
vec4 color = vec4(0.0, 0, 0, 0.0);
for (int i = 0; i < 8; i++)
{
  color = color + vec4(matInst.color[i*4], matInst.color[i*4+1], matInst.color[i*4+2], matInst.color[i*4+3]);
}
vtxColor = color * 0.125;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
vector<float, 64> color;
} matInst;
void main()
{
    gl_Position = position;
vec4 color = vec4(0.0, 0, 0, 0.0);
for (int i = 0; i < 16; i++)
{
  color = color + vec4(matInst.color[i*4], matInst.color[i*4+1], matInst.color[i*4+2], matInst.color[i*4+3]);
}
vtxColor = color * 0.0625;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout (constant_id = 0) const uint MaxPushConstantSize = 128;
layout(push_constant) uniform Material {
vec4 color[(MaxPushConstantSize + 12) / 16];
} matInst;
void main()
{
    gl_Position = position;
vec4 color = vec4(0.0, 0, 0, 0.0);
for (int i = 0; i < (MaxPushConstantSize / 16); i++)
{
  color = color + matInst.color[i];
}
for (int i = 0; i < ((MaxPushConstantSize % 16) / 4); i++)
{
  switch (i) {
  case 0: if (matInst.color[(MaxPushConstantSize + 12) / 16 - 1].x != 1.0) color = vec4(0.0); break;
  case 1: if (matInst.color[(MaxPushConstantSize + 12) / 16 - 1].y != 0.0) color = vec4(0.0); break;
  case 2: if (matInst.color[(MaxPushConstantSize + 12) / 16 - 1].z != 0.0) color = vec4(0.0); break;
  default: break;}
}
vtxColor = color / (MaxPushConstantSize / 16);
}
#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
layout(push_constant) uniform Material {
    layout(offset = 16) int kind;
} matInst;
void main (void)
{
    switch (matInst.kind) {
    case 0: fragColor = vec4(0, 1.0, 0, 1.0); break;
    case 1: fragColor = vec4(0, 0.0, 1.0, 1.0); break;
    case 2: fragColor = vtxColor; break;
    default: fragColor = vec4(1.0, 1.0, 1.0, 1.0); break;}
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(push_constant) uniform Material {
    layout(offset = 20) int kind;
} matInst;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex { vec4 gl_Position; } gl_in[];
out gl_PerVertex { vec4 gl_Position; };
void main()
{
  for(int i=0; i<3; i++)
  {
    gl_Position.xyz = gl_in[i].gl_Position.xyz / matInst.kind;
    gl_Position.w = gl_in[i].gl_Position.w;
    vtxColor = color[i];
    EmitVertex();
  }
  EndPrimitive();
}
#version 450
layout (vertices = 3) out;
layout(push_constant) uniform TessLevel {
    layout(offset = 24) int level;
} tessLevel;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor[];
in gl_PerVertex { vec4 gl_Position; } gl_in[gl_MaxPatchVertices];
out gl_PerVertex { vec4 gl_Position; } gl_out[];
void main()
{
  gl_TessLevelInner[0] = tessLevel.level;
  gl_TessLevelOuter[0] = tessLevel.level;
  gl_TessLevelOuter[1] = tessLevel.level;
  gl_TessLevelOuter[2] = tessLevel.level;
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  vtxColor[gl_InvocationID] = color[gl_InvocationID];
}
#version 450
layout (triangles) in;
layout(push_constant) uniform Material {
    layout(offset = 32) vec4 color;
} matInst;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex { vec4 gl_Position; } gl_in[gl_MaxPatchVertices];
out gl_PerVertex { vec4 gl_Position; };
void main()
{
  gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
  vtxColor = matInst.color;
}
#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
layout(push_constant) uniform Material {
    layout(offset = 0) int kind; 
} matInst;
void main (void)
{
    switch (matInst.kind) {
    case 0: fragColor = vec4(0, 1.0, 0, 1.0); break;
    case 1: fragColor = vec4(0, 0.0, 1.0, 1.0); break;
    case 2: fragColor = vtxColor; break;
    default: fragColor = vec4(1.0, 1.0, 1.0, 1.0); break;}
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
vec4 color[2];
} matInst;
void main()
{
    gl_Position = position;
vtxColor = (matInst.color[0] + matInst.color[1]) * 0.5;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
int unused1;
vec4 unused2;
vec4 color;
} matInst;
void main()
{
    gl_Position = position;
vtxColor = matInst.color;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
layout(push_constant) uniform Material {
    layout(offset = 0)  vec4 index; 
    layout(offset = 16) vec4 vecType; 
    layout(offset = 32) mat2 matType; 
    layout(offset = 48) float[4] arrType; 
} matInst;
void main()
{
    gl_Position = position;
    vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
    // Mix in gl_Position to (hopefully) prevent optimizing our index away
    int vec_selector = int(abs(gl_Position.x) * 0.0000001 + 0);
    int mat_selector = int(abs(gl_Position.x) * 0.0000001 + 1);
    int arr_selector = int(abs(gl_Position.x) * 0.0000001 + 2);
    if (matInst.vecType[int(matInst.index[vec_selector])] != 0.25)
        vtxColor += vec4(0.0, 0.5, 0.0, 1.0);
    if (matInst.matType[int(matInst.index[mat_selector])][0] != 0.5)
        vtxColor += vec4(0.0, 0.0, 0.5, 1.0);
    if (matInst.arrType[int(matInst.index[arr_selector])] != 0.75)
        vtxColor = vec4(0.0, 0.5, 0.5, 1.0);
}
#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
layout(push_constant) uniform Material {
    layout(offset = 0)  vec4 index; 
    layout(offset = 16) vec4 vecType; 
    layout(offset = 32) mat2 matType; 
    layout(offset = 48) float[4] arrType; 
} matInst;
void main (void)
{
    fragColor = vec4(1.0, 0.0, 0.0, 1.0);
    // Mix in gl_FragCoord to (hopefully) prevent optimizing our index away
    int vec_selector = int(gl_FragCoord.x * 0.0000001 + 0);
    int mat_selector = int(gl_FragCoord.x * 0.0000001 + 1);
    int arr_selector = int(gl_FragCoord.x * 0.0000001 + 2);
    if (matInst.vecType[int(matInst.index[vec_selector])] != 0.25)
        fragColor += vec4(0.0, 0.5, 0.0, 1.0);
    if (matInst.matType[int(matInst.index[mat_selector])][0] != 0.5)
        fragColor += vec4(0.0, 0.0, 0.5, 1.0);
    if (matInst.arrType[int(matInst.index[arr_selector])] != 0.75)
        fragColor = vec4(0.0, 0.5, 0.5, 1.0);
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
void main()
{
    gl_Position = position;
    vtxColor = color;
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex { vec4 gl_Position; } gl_in[];
out gl_PerVertex { vec4 gl_Position; };
void main()
{
  for(int i=0; i<3; i++)
  {
    gl_Position.xyz = gl_in[i].gl_Position.xyz;
    gl_Position.w = gl_in[i].gl_Position.w;
    vtxColor = color[i];
    EmitVertex();
  }
  EndPrimitive();
}
#version 450
layout (vertices = 3) out;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor[];
in gl_PerVertex { vec4 gl_Position; } gl_in[gl_MaxPatchVertices];
out gl_PerVertex { vec4 gl_Position; } gl_out[];
void main()
{
  gl_TessLevelInner[0] = 2.0;
  gl_TessLevelOuter[0] = 2.0;
  gl_TessLevelOuter[1] = 2.0;
  gl_TessLevelOuter[2] = 2.0;
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  vtxColor[gl_InvocationID] = color[gl_InvocationID];
}
#version 450
layout (triangles) in;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex { vec4 gl_Position; } gl_in[gl_MaxPatchVertices];
out gl_PerVertex { vec4 gl_Position; };
void main()
{
  gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
  vtxColor = gl_TessCoord.x * color[0] + gl_TessCoord.y * color[1] + gl_TessCoord.z * color[2];
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 inColor;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
layout(push_constant) uniform Material
{
    layout(offset = 0) vec4 color;
} matInst;
void main()
{
    gl_Position = position;
    vec4 color = inColor;
    color += matInst.color;
    vtxColor = color;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
layout(push_constant) uniform Material
{
    layout(offset = 12) int unused1;
    layout(offset = 16) vec4 unused2;
    layout(offset = 32) vec4 color;
} matInst;
void main (void)
{
    fragColor = vtxColor;
    fragColor += matInst.color;
    fragColor = min(mod(fragColor, 2.0), 2.0 - mod(fragColor, 2.0));
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 inColor;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
layout(push_constant) uniform Material
{
    layout(offset = 12) int unused1;
    layout(offset = 16) vec4 unused2;
    layout(offset = 32) vec4 color;
} matInst;
void main()
{
    gl_Position = position;
    vec4 color = inColor;
    color += matInst.color;
    vtxColor = color;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(push_constant) uniform Material
{
    layout(offset = 0) vec4 color[2];
} matInst;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main()
{
    for(int i = 0; i < 3; i++)
    {
        gl_Position.xyz = gl_in[i].gl_Position.xyz/2.0;
        gl_Position.w = gl_in[i].gl_Position.w;
        vtxColor = color[i];
        vtxColor += matInst.color[1];
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
layout(push_constant) uniform Material
{
    layout(offset = 20) float color;
} matInst;
void main (void)
{
    fragColor = vtxColor;
    fragColor.x += matInst.color;
    fragColor = min(mod(fragColor, 2.0), 2.0 - mod(fragColor, 2.0));
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 inColor;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
layout(push_constant) uniform Material
{
    layout(offset = 8) float color;
} matInst;
void main()
{
    gl_Position = position;
    vec4 color = inColor;
    color.x += matInst.color;
    vtxColor = color;
}
#version 450
#extension GL_EXT_long_vector : enable
layout (vertices = 3) out;
layout(push_constant) uniform Material
{
    layout(offset = 0) vec4 color[8];
} matInst;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor[];
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];
void main()
{
    gl_TessLevelInner[0] = 2.0;
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 2.0;
    gl_TessLevelOuter[2] = 2.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    vec4 outColor = color[gl_InvocationID];
    outColor += matInst.color[7];
    vtxColor[gl_InvocationID] = outColor;
}
#version 450
#extension GL_EXT_long_vector : enable
layout (triangles) in;
layout(push_constant) uniform Material
{
    layout(offset = 56) vec2 color;
} matInst;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main()
{
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
    vtxColor = gl_TessCoord.x * color[0] + gl_TessCoord.y * color[1] + gl_TessCoord.z * color[2];
    vtxColor.xy += matInst.color;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
layout(push_constant) uniform Material
{
    layout(offset = 60) int unused1;
    layout(offset = 64) vec4 unused2;
    layout(offset = 80) vec4 color;
} matInst;
void main (void)
{
    fragColor = vtxColor;
    fragColor += matInst.color;
    fragColor = min(mod(fragColor, 2.0), 2.0 - mod(fragColor, 2.0));
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 inColor;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
layout(push_constant) uniform Material
{
    layout(offset = 40) vec2 color;
} matInst;
void main()
{
    gl_Position = position;
    vec4 color = inColor;
    color.xy += matInst.color;
    vtxColor = color;
}
#version 450
#extension GL_EXT_long_vector : enable
layout (vertices = 3) out;
layout(push_constant) uniform Material
{
    layout(offset = 32) vec3 color;
} matInst;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor[];
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];
void main()
{
    gl_TessLevelInner[0] = 2.0;
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 2.0;
    gl_TessLevelOuter[2] = 2.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    vec4 outColor = color[gl_InvocationID];
    outColor.xyz += matInst.color;
    vtxColor[gl_InvocationID] = outColor;
}
#version 450
#extension GL_EXT_long_vector : enable
layout (triangles) in;
layout(push_constant) uniform Material
{
    layout(offset = 48) vec4 color;
} matInst;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main()
{
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
    vtxColor = gl_TessCoord.x * color[0] + gl_TessCoord.y * color[1] + gl_TessCoord.z * color[2];
    vtxColor += matInst.color;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(push_constant) uniform Material
{
    layout(offset = 28) int unused1;
    layout(offset = 32) vec4 unused2;
    layout(offset = 48) vec4 color;
} matInst;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main()
{
    for(int i = 0; i < 3; i++)
    {
        gl_Position.xyz = gl_in[i].gl_Position.xyz/2.0;
        gl_Position.w = gl_in[i].gl_Position.w;
        vtxColor = color[i];
        vtxColor += matInst.color;
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
layout(push_constant) uniform Material
{
    layout(offset = 56) vec2 color;
} matInst;
void main (void)
{
    fragColor = vtxColor;
    fragColor.xy += matInst.color;
    fragColor = min(mod(fragColor, 2.0), 2.0 - mod(fragColor, 2.0));
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 inColor;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex
{
    vec4 gl_Position;
};

void main()
{
    gl_Position = position;
    vec4 color = inColor;

    vtxColor = color;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    fragColor = vtxColor;

    fragColor = min(mod(fragColor, 2.0), 2.0 - mod(fragColor, 2.0));
}
#version 450
#extension GL_EXT_long_vector : enable
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;

layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main()
{
    for(int i = 0; i < 3; i++)
    {
        gl_Position.xyz = gl_in[i].gl_Position.xyz;
        gl_Position.w = gl_in[i].gl_Position.w;
        vtxColor = color[i];

        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_long_vector : enable
layout (vertices = 3) out;

layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor[];
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];
void main()
{
    gl_TessLevelInner[0] = 2.0;
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 2.0;
    gl_TessLevelOuter[2] = 2.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    vec4 outColor = color[gl_InvocationID];

    vtxColor[gl_InvocationID] = outColor;
}
#version 450
#extension GL_EXT_long_vector : enable
layout (triangles) in;

layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main()
{
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
    vtxColor = gl_TessCoord.x * color[0] + gl_TessCoord.y * color[1] + gl_TessCoord.z * color[2];

}
