#version 460
layout (location=0) in vec4 inPos;
layout (location=0) out float added;
layout (location=1) out float multiplied;
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    gl_Position  = inPos;
    gl_PointSize = 1.0;
    added        = inPos.x + 1000.0;
    multiplied   = inPos.y * 1000.0;
}
#version 460
layout (location=0) in float added;
layout (location=1) in float multiplied;
void main (void) {}
#version 460
layout (location=0) in vec4 inPos;
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    gl_Position  = inPos;
    gl_PointSize = 1.0;
}
#version 460
layout (vertices=3) out;
in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position;
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 460
layout (triangles, fractional_odd_spacing, cw) in;
layout (location=0) out float added;
layout (location=1) out float multiplied;
in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    vec4 pos     = (gl_TessCoord.x * gl_in[0].gl_Position) +
                   (gl_TessCoord.y * gl_in[1].gl_Position) +
                   (gl_TessCoord.z * gl_in[2].gl_Position);
    gl_Position  = pos;
    gl_PointSize = gl_in[0].gl_PointSize;
    added        = pos.x + 1000.0;
    multiplied   = pos.y * 1000.0;
}
#version 460
layout (location=0) in vec2 inPos;
out gl_PerVertex {
  vec4 gl_Position;
  float gl_CullDistance[1];
};
void main (void)
{
    gl_CullDistance[0] = 0.5 - float((gl_VertexIndex < 5));
    gl_Position = vec4(inPos, 1.0, 1.0);
}
#version 460
layout (location=0) in vec2 inPos;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    gl_Position = vec4(inPos, 1.0, 1.0);
}
#version 460
#extension GL_EXT_samplerless_texture_functions : enable
layout(local_size_x = 8, local_size_y = 8) in;
layout(set = 0, binding = 0) uniform texture2DMS inputImage;
layout(set = 0, binding = 1) buffer Data { float v[]; };
void main()
{
  ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
  float samplesOne  = texelFetch(inputImage, uv, 0).r +
                      texelFetch(inputImage, uv, 2).r;
  float samplesZero = texelFetch(inputImage, uv, 1).r +
                      texelFetch(inputImage, uv, 3).r;
  v[gl_LocalInvocationIndex] = samplesOne - samplesZero;
}
