#version 310 es
layout(location = 0) in highp vec4 a_position;
void main (void)
{
       gl_Position = a_position;
}
#version 310 es
layout(set=0, binding=0) uniform Scale { highp vec3 u_scale; };
layout(location = 0) out highp vec4 o_color;
void main (void)
{
       o_color = vec4(gl_FragCoord.xyz * u_scale, 1.0);
}
#version 310 es
layout(location = 0) out highp vec4 o_color;
void main (void)
{
       o_color = vec4(0.0, 1.0 / gl_FragCoord.w - 1.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) in highp vec3 a_position;
void main (void)
{
    gl_Position = vec4(a_position.xy, 0.0, 1.0);
    gl_PointSize = a_position.z;
}
#version 310 es
layout(location = 0) out lowp vec4 o_color;
void main (void)
{
    o_color = vec4(gl_PointCoord, 0.0, 1.0);
}
#version 310 es
layout(set=0, binding=0) uniform Scale { highp vec3 u_scale; };
layout(location = 0) out lowp vec4 o_color;
void main (void)
{
    o_color = vec4(gl_PointCoord, 0.0, 1.0) * vec4(u_scale, 1.0);
}
#version 310 es
layout(set=0, binding=0) uniform Scale { highp vec3 u_scale; };
layout(location = 0) in highp vec3 a_position;
void main (void)
{
    gl_Position = vec4(a_position.xy, 0.0, 1.0) * vec4(u_scale, 1.0);
    gl_PointSize = a_position.z;
}
#version 310 es

layout(location = 0) in highp vec4 position;
void main()
{
gl_Position = position;
gl_PointSize = 1.0;
}
#version 310 es

layout(location = 0) out mediump vec4 color;
void main()
{
if (gl_FrontFacing)
    color = vec4(1.0, 0.0, 0.0, 1.0);
else
    color = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 310 es

layout(location = 0) out highp vec4 color;
layout(set = 0, binding = 0) uniform UboData {
    highp float data;
} ubo;
void main()
{
    highp float c = (gl_FrontFacing ? 1.0 : -1.0) + ubo.data;
    color = vec4(c);
}
#version 450
layout(location = 0) in highp vec4 a_position;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    }
#version 450
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.1, 0.2, 0.3, 1.0);
        o_color += vec4(0.3, 0.2, 0.1, 0.0);
    }
#version 450
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.1, 0.2, 0.3, 1.0);
    if (gl_FrontFacing)
    o_color += vec4(0.3, 0.2, 0.1, 0.0);
    }
#version 450
layout(location = 0) in highp vec4 a_position;
out gl_PerVertex {
    vec4 gl_Position;
};
layout(location = 1) in highp vec4 a_color;
layout(location = 0) out highp vec4 v_color;
void main (void)
{
    gl_Position = a_position;
    v_color = a_color;
}
#version 450
layout(location = 0) in highp vec4 a_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.1, 0.2, 0.3, 1.0);
        o_color += vec4(a_color.xyz, 0.0);
    }
#version 450
layout(location = 0) in highp vec4 a_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.1, 0.2, 0.3, 1.0);
    if (gl_FrontFacing)
    o_color += vec4(a_color.xyz, 0.0);
    }
#version 450
layout(push_constant) uniform PCBlock {
  vec4 color;
} pc;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.1, 0.2, 0.3, 1.0);
        o_color += vec4(0.3, 0.2, 0.1, 0.0);
    o_color += pc.color;
}
#version 450
layout(push_constant) uniform PCBlock {
  vec4 color;
} pc;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.1, 0.2, 0.3, 1.0);
    if (gl_FrontFacing)
    o_color += vec4(0.3, 0.2, 0.1, 0.0);
    o_color += pc.color;
}
#version 450
layout(location = 0) in highp vec4 a_color;
layout(push_constant) uniform PCBlock {
  vec4 color;
} pc;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.1, 0.2, 0.3, 1.0);
        o_color += vec4(a_color.xyz, 0.0);
    o_color += pc.color;
}
#version 450
layout(location = 0) in highp vec4 a_color;
layout(push_constant) uniform PCBlock {
  vec4 color;
} pc;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.1, 0.2, 0.3, 1.0);
    if (gl_FrontFacing)
    o_color += vec4(a_color.xyz, 0.0);
    o_color += pc.color;
}
#version 450

layout (location = 0) in vec4 position;
void main()
{
    gl_Position = position;
    gl_PointSize = 1.0;
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (std140, set = 0, binding = 0) uniform control_buffer_t
{
    float data[256];
} control_buffer;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D storageImage;
float controlDepthValue;
void recheck(float controlDepthValue)
{
    if (gl_FragDepth != controlDepthValue)
        gl_FragDepth = 1.0;
}
void main()
{
    const int numSamples = 1;
    if (int(gl_FragCoord.x) == 4)
        discard;
    highp int index =int(gl_FragCoord.y) * 16 + int(gl_FragCoord.x);
    controlDepthValue = control_buffer.data[index];
    gl_FragDepth = controlDepthValue;
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 1, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, uvec4(1));
    recheck(controlDepthValue);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout (location = 0) in vec4 position;
layout (location = 1) out vec2 texCoord;
void main()
{
    gl_Position = position;
    gl_PointSize = 1.0;
    texCoord = position.xy/2 + vec2(0.5);
}
#version 450

layout (location = 0) out mediump vec4 color;
layout (location = 1) in vec2 texCoord;
layout (binding = 0, set = 0) uniform sampler2D u_depthTex;
layout (binding = 1, set = 0, r32f) writeonly uniform image2D u_outImage;
void main (void)
{
    const int numSamples = 1;
    const int sampleNdx = int(gl_SampleID);
    ivec2 renderSize = ivec2(16,16);
    ivec2 imageCoord = ivec2(int(texCoord.x * renderSize.x), int(texCoord.y * renderSize.y));
    vec4 depthVal = texelFetch(u_depthTex, imageCoord, sampleNdx);
    imageStore(u_outImage, ivec2(sampleNdx + int(texCoord.x * renderSize.x) * numSamples, int(texCoord.y * renderSize.y)), depthVal);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (std140, set = 0, binding = 0) uniform control_buffer_t
{
    float data[256];
} control_buffer;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D storageImage;
float controlDepthValue;
void recheck(float controlDepthValue)
{
    if (gl_FragDepth != controlDepthValue)
        gl_FragDepth = 1.0;
}
void main()
{
    const int numSamples = 2;
    if (int(gl_FragCoord.x) == 4)
        discard;
    highp int index =int(gl_FragCoord.y) * 16 + int(gl_FragCoord.x);
    controlDepthValue = control_buffer.data[index];
    gl_FragDepth = controlDepthValue;
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 2, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, uvec4(1));
    recheck(controlDepthValue);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout (location = 0) out mediump vec4 color;
layout (location = 1) in vec2 texCoord;
layout (binding = 0, set = 0) uniform sampler2DMS u_depthTex;
layout (binding = 1, set = 0, r32f) writeonly uniform image2D u_outImage;
void main (void)
{
    const int numSamples = 2;
    const int sampleNdx = int(gl_SampleID);
    ivec2 renderSize = ivec2(16,16);
    ivec2 imageCoord = ivec2(int(texCoord.x * renderSize.x), int(texCoord.y * renderSize.y));
    vec4 depthVal = texelFetch(u_depthTex, imageCoord, sampleNdx);
    imageStore(u_outImage, ivec2(sampleNdx + int(texCoord.x * renderSize.x) * numSamples, int(texCoord.y * renderSize.y)), depthVal);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (std140, set = 0, binding = 0) uniform control_buffer_t
{
    float data[256];
} control_buffer;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D storageImage;
float controlDepthValue;
void recheck(float controlDepthValue)
{
    if (gl_FragDepth != controlDepthValue)
        gl_FragDepth = 1.0;
}
void main()
{
    const int numSamples = 4;
    if (int(gl_FragCoord.x) == 4)
        discard;
    highp int index =int(gl_FragCoord.y) * 16 + int(gl_FragCoord.x);
    controlDepthValue = control_buffer.data[index];
    gl_FragDepth = controlDepthValue;
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 4, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, uvec4(1));
    recheck(controlDepthValue);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout (location = 0) out mediump vec4 color;
layout (location = 1) in vec2 texCoord;
layout (binding = 0, set = 0) uniform sampler2DMS u_depthTex;
layout (binding = 1, set = 0, r32f) writeonly uniform image2D u_outImage;
void main (void)
{
    const int numSamples = 4;
    const int sampleNdx = int(gl_SampleID);
    ivec2 renderSize = ivec2(16,16);
    ivec2 imageCoord = ivec2(int(texCoord.x * renderSize.x), int(texCoord.y * renderSize.y));
    vec4 depthVal = texelFetch(u_depthTex, imageCoord, sampleNdx);
    imageStore(u_outImage, ivec2(sampleNdx + int(texCoord.x * renderSize.x) * numSamples, int(texCoord.y * renderSize.y)), depthVal);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (std140, set = 0, binding = 0) uniform control_buffer_t
{
    float data[256];
} control_buffer;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D storageImage;
float controlDepthValue;
void recheck(float controlDepthValue)
{
    if (gl_FragDepth != controlDepthValue)
        gl_FragDepth = 1.0;
}
void main()
{
    const int numSamples = 8;
    if (int(gl_FragCoord.x) == 4)
        discard;
    highp int index =int(gl_FragCoord.y) * 16 + int(gl_FragCoord.x);
    controlDepthValue = control_buffer.data[index];
    gl_FragDepth = controlDepthValue;
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 8, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, uvec4(1));
    recheck(controlDepthValue);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout (location = 0) out mediump vec4 color;
layout (location = 1) in vec2 texCoord;
layout (binding = 0, set = 0) uniform sampler2DMS u_depthTex;
layout (binding = 1, set = 0, r32f) writeonly uniform image2D u_outImage;
void main (void)
{
    const int numSamples = 8;
    const int sampleNdx = int(gl_SampleID);
    ivec2 renderSize = ivec2(16,16);
    ivec2 imageCoord = ivec2(int(texCoord.x * renderSize.x), int(texCoord.y * renderSize.y));
    vec4 depthVal = texelFetch(u_depthTex, imageCoord, sampleNdx);
    imageStore(u_outImage, ivec2(sampleNdx + int(texCoord.x * renderSize.x) * numSamples, int(texCoord.y * renderSize.y)), depthVal);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (std140, set = 0, binding = 0) uniform control_buffer_t
{
    float data[256];
} control_buffer;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D storageImage;
float controlDepthValue;
void recheck(float controlDepthValue)
{
    if (gl_FragDepth != controlDepthValue)
        gl_FragDepth = 1.0;
}
void main()
{
    const int numSamples = 16;
    if (int(gl_FragCoord.x) == 4)
        discard;
    highp int index =int(gl_FragCoord.y) * 16 + int(gl_FragCoord.x);
    controlDepthValue = control_buffer.data[index];
    gl_FragDepth = controlDepthValue;
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 16, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, uvec4(1));
    recheck(controlDepthValue);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout (location = 0) out mediump vec4 color;
layout (location = 1) in vec2 texCoord;
layout (binding = 0, set = 0) uniform sampler2DMS u_depthTex;
layout (binding = 1, set = 0, r32f) writeonly uniform image2D u_outImage;
void main (void)
{
    const int numSamples = 16;
    const int sampleNdx = int(gl_SampleID);
    ivec2 renderSize = ivec2(16,16);
    ivec2 imageCoord = ivec2(int(texCoord.x * renderSize.x), int(texCoord.y * renderSize.y));
    vec4 depthVal = texelFetch(u_depthTex, imageCoord, sampleNdx);
    imageStore(u_outImage, ivec2(sampleNdx + int(texCoord.x * renderSize.x) * numSamples, int(texCoord.y * renderSize.y)), depthVal);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (std140, set = 0, binding = 0) uniform control_buffer_t
{
    float data[256];
} control_buffer;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D storageImage;
float controlDepthValue;
void recheck(float controlDepthValue)
{
    if (gl_FragDepth != controlDepthValue)
        gl_FragDepth = 1.0;
}
void main()
{
    const int numSamples = 32;
    if (int(gl_FragCoord.x) == 4)
        discard;
    highp int index =int(gl_FragCoord.y) * 16 + int(gl_FragCoord.x);
    controlDepthValue = control_buffer.data[index];
    gl_FragDepth = controlDepthValue;
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 32, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, uvec4(1));
    recheck(controlDepthValue);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout (location = 0) out mediump vec4 color;
layout (location = 1) in vec2 texCoord;
layout (binding = 0, set = 0) uniform sampler2DMS u_depthTex;
layout (binding = 1, set = 0, r32f) writeonly uniform image2D u_outImage;
void main (void)
{
    const int numSamples = 32;
    const int sampleNdx = int(gl_SampleID);
    ivec2 renderSize = ivec2(16,16);
    ivec2 imageCoord = ivec2(int(texCoord.x * renderSize.x), int(texCoord.y * renderSize.y));
    vec4 depthVal = texelFetch(u_depthTex, imageCoord, sampleNdx);
    imageStore(u_outImage, ivec2(sampleNdx + int(texCoord.x * renderSize.x) * numSamples, int(texCoord.y * renderSize.y)), depthVal);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (std140, set = 0, binding = 0) uniform control_buffer_t
{
    float data[256];
} control_buffer;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D storageImage;
float controlDepthValue;
void recheck(float controlDepthValue)
{
    if (gl_FragDepth != controlDepthValue)
        gl_FragDepth = 1.0;
}
void main()
{
    const int numSamples = 64;
    if (int(gl_FragCoord.x) == 4)
        discard;
    highp int index =int(gl_FragCoord.y) * 16 + int(gl_FragCoord.x);
    controlDepthValue = control_buffer.data[index];
    gl_FragDepth = controlDepthValue;
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 64, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, uvec4(1));
    recheck(controlDepthValue);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout (location = 0) out mediump vec4 color;
layout (location = 1) in vec2 texCoord;
layout (binding = 0, set = 0) uniform sampler2DMS u_depthTex;
layout (binding = 1, set = 0, r32f) writeonly uniform image2D u_outImage;
void main (void)
{
    const int numSamples = 64;
    const int sampleNdx = int(gl_SampleID);
    ivec2 renderSize = ivec2(16,16);
    ivec2 imageCoord = ivec2(int(texCoord.x * renderSize.x), int(texCoord.y * renderSize.y));
    vec4 depthVal = texelFetch(u_depthTex, imageCoord, sampleNdx);
    imageStore(u_outImage, ivec2(sampleNdx + int(texCoord.x * renderSize.x) * numSamples, int(texCoord.y * renderSize.y)), depthVal);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout (location = 0) in vec4 position;
void main()
{
    gl_Position = position;
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (set = 0, binding = 0, rgba32f) writeonly uniform image2D storageImage;
void main()
{
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 1, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, gl_FragCoord);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (set = 0, binding = 0, rgba32f) writeonly uniform image2D storageImage;
void main()
{
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 2, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, gl_FragCoord);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (set = 0, binding = 0, rgba32f) writeonly uniform image2D storageImage;
void main()
{
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 4, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, gl_FragCoord);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (set = 0, binding = 0, rgba32f) writeonly uniform image2D storageImage;
void main()
{
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 8, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, gl_FragCoord);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (set = 0, binding = 0, rgba32f) writeonly uniform image2D storageImage;
void main()
{
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 16, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, gl_FragCoord);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (set = 0, binding = 0, rgba32f) writeonly uniform image2D storageImage;
void main()
{
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 32, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, gl_FragCoord);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) out mediump vec4 color;
layout (set = 0, binding = 0, rgba32f) writeonly uniform image2D storageImage;
void main()
{
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 64, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, gl_FragCoord);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout (location = 0) out mediump vec4 color;
layout (set = 0, binding = 0, rgba32f) writeonly uniform image2D storageImage;
void main()
{
    ivec2 imageCoord = ivec2(int(gl_FragCoord.x), int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, gl_FragCoord);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
; SPIR - V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 36
; Schema: 0
OpCapability Shader
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %gl_FragCoord %color
OpExecutionMode %main OriginUpperLeft
OpSource GLSL 450
OpName %main "main"
OpName %imageCoord "imageCoord"
OpName %gl_FragCoord "gl_FragCoord"
OpName %storageImage "storageImage"
OpName %color "color"
OpDecorate %gl_FragCoord BuiltIn FragCoord
OpDecorate %gl_FragCoord Centroid
OpDecorate %storageImage DescriptorSet 0
OpDecorate %storageImage Binding 0
OpDecorate %storageImage NonReadable
OpDecorate %color RelaxedPrecision
OpDecorate %color Location 0
%void = OpTypeVoid
%3 = OpTypeFunction %void
%int = OpTypeInt 32 1
%v2int = OpTypeVector %int 2
%_ptr_Function_v2int = OpTypePointer Function %v2int
%float = OpTypeFloat 32
%v4float = OpTypeVector %float 4
%_ptr_Input_v4float = OpTypePointer Input %v4float
%gl_FragCoord = OpVariable %_ptr_Input_v4float Input
%uint = OpTypeInt 32 0
%uint_0 = OpConstant %uint 0
%_ptr_Input_float = OpTypePointer Input %float
%uint_1 = OpConstant %uint 1
%25 = OpTypeImage %float 2D 0 0 0 2 Rgba32f
%_ptr_UniformConstant_25 = OpTypePointer UniformConstant %25
%storageImage = OpVariable %_ptr_UniformConstant_25 UniformConstant
%_ptr_Output_v4float = OpTypePointer Output %v4float
%color = OpVariable %_ptr_Output_v4float Output
%float_1 = OpConstant %float 1
%float_0 = OpConstant %float 0
%35 = OpConstantComposite %v4float %float_1 %float_0 %float_0 %float_1
%main = OpFunction %void None %3
%5 = OpLabel
%imageCoord = OpVariable %_ptr_Function_v2int Function
%17 = OpAccessChain %_ptr_Input_float %gl_FragCoord %uint_0
%18 = OpLoad %float %17
%19 = OpConvertFToS %int %18
%21 = OpAccessChain %_ptr_Input_float %gl_FragCoord %uint_1
%22 = OpLoad %float %21
%23 = OpConvertFToS %int %22
%24 = OpCompositeConstruct %v2int %19 %23
OpStore %imageCoord %24
%28 = OpLoad %25 %storageImage
%29 = OpLoad %v2int %imageCoord
%30 = OpLoad %v4float %gl_FragCoord
OpImageWrite %28 %29 %30
OpStore %color %35
OpReturn
OpFunctionEnd
