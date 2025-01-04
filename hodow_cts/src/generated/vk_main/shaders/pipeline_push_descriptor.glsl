#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) uniform Block
{
    vec4 color;
} inputData;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = inputData.color;
}
#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    fragColor = vtxColor;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 1) uniform Block
{
    vec4 color;
} inputData;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = inputData.color;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 3) uniform Block
{
    vec4 color;
} inputData;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = inputData.color;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) readonly buffer Block
{
    vec4 color;
} inputData;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = inputData.color;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 1) readonly buffer Block
{
    vec4 color;
} inputData;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = inputData.color;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 3) readonly buffer Block
{
    vec4 color;
} inputData;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = inputData.color;
}
#version 450
layout(set = 0, binding = 0) uniform Block
{
    vec4 color;
} inputData;

layout(set = 0, binding = 1) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = inputData.color;
}
#version 450
layout(set = 0, binding = 1) uniform Block
{
    vec4 color;
} inputData;

layout(set = 0, binding = 2) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = inputData.color;
}
#version 450
layout(set = 0, binding = 3) uniform Block
{
    vec4 color;
} inputData;

layout(set = 0, binding = 4) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = inputData.color;
}
#version 450
layout(set = 0, binding = 0) buffer Block
{
    vec4 color;
} inputData;

layout(set = 0, binding = 1) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = inputData.color;
}
#version 450
layout(set = 0, binding = 1) buffer Block
{
    vec4 color;
} inputData;

layout(set = 0, binding = 2) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = inputData.color;
}
#version 450
layout(set = 0, binding = 3) buffer Block
{
    vec4 color;
} inputData;

layout(set = 0, binding = 4) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = inputData.color;
}
#version 450

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std140) uniform Input {
    uint data[16];
} ubo;

layout(set = 0, binding = 1, std430) buffer Output {
    uint data[16];
} ssbo;

void main() {
    ssbo.data[gl_GlobalInvocationID.x] += ubo.data[gl_GlobalInvocationID.x];
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 texcoordVtx;
layout(location = 0) out highp vec2 texcoordFrag;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    texcoordFrag = texcoordVtx.xy;
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 0) uniform sampler2D combinedSampler;

void main (void)
{
    fragColor = texture(combinedSampler, texcoordFrag);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 1) uniform sampler2D combinedSampler;

void main (void)
{
    fragColor = texture(combinedSampler, texcoordFrag);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 3) uniform sampler2D combinedSampler;

void main (void)
{
    fragColor = texture(combinedSampler, texcoordFrag);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 0) uniform sampler texSampler;
layout(set = 0, binding = 1) uniform texture2D texImage;

void main (void)
{
    fragColor = texture(sampler2D(texImage, texSampler), texcoordFrag);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 1) uniform sampler texSampler;
layout(set = 0, binding = 2) uniform texture2D texImage;

void main (void)
{
    fragColor = texture(sampler2D(texImage, texSampler), texcoordFrag);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 3) uniform sampler texSampler;
layout(set = 0, binding = 4) uniform texture2D texImage;

void main (void)
{
    fragColor = texture(sampler2D(texImage, texSampler), texcoordFrag);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 1) uniform sampler texSampler;
layout(set = 0, binding = 0) uniform texture2D texImage;

void main (void)
{
    fragColor = texture(sampler2D(texImage, texSampler), texcoordFrag);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 2) uniform sampler texSampler;
layout(set = 0, binding = 1) uniform texture2D texImage;

void main (void)
{
    fragColor = texture(sampler2D(texImage, texSampler), texcoordFrag);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 4) uniform sampler texSampler;
layout(set = 0, binding = 3) uniform texture2D texImage;

void main (void)
{
    fragColor = texture(sampler2D(texImage, texSampler), texcoordFrag);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 0, rgba8) uniform readonly image2D storageImage;

void main (void)
{
    fragColor = imageLoad(storageImage, ivec2(0));
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 1, rgba8) uniform readonly image2D storageImage;

void main (void)
{
    fragColor = imageLoad(storageImage, ivec2(0));
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 3, rgba8) uniform readonly image2D storageImage;

void main (void)
{
    fragColor = imageLoad(storageImage, ivec2(0));
}
#version 450
layout(set = 0, binding = 0) uniform sampler2D combinedSampler;
layout(set = 0, binding = 1) writeonly buffer Output
{
    vec4 innerColor;
    vec4 outerColor;
} outData;

void main()
{
    outData.innerColor = texture(combinedSampler, vec2(0.5));
    outData.outerColor = texture(combinedSampler, vec2(-0.1));
}
#version 450
layout(set = 0, binding = 1) uniform sampler2D combinedSampler;
layout(set = 0, binding = 2) writeonly buffer Output
{
    vec4 innerColor;
    vec4 outerColor;
} outData;

void main()
{
    outData.innerColor = texture(combinedSampler, vec2(0.5));
    outData.outerColor = texture(combinedSampler, vec2(-0.1));
}
#version 450
layout(set = 0, binding = 3) uniform sampler2D combinedSampler;
layout(set = 0, binding = 4) writeonly buffer Output
{
    vec4 innerColor;
    vec4 outerColor;
} outData;

void main()
{
    outData.innerColor = texture(combinedSampler, vec2(0.5));
    outData.outerColor = texture(combinedSampler, vec2(-0.1));
}
#version 450
layout(set = 0, binding = 0) uniform sampler texSampler;
layout(set = 0, binding = 1) uniform texture2D texImage;
layout(set = 0, binding = 2) writeonly buffer Output
{
    vec4 innerColor;
    vec4 outerColor;
} outData;

void main()
{
    outData.innerColor = texture(sampler2D(texImage, texSampler), vec2(0.5));
    outData.outerColor = texture(sampler2D(texImage, texSampler), vec2(-0.1));
}
#version 450
layout(set = 0, binding = 1) uniform sampler texSampler;
layout(set = 0, binding = 2) uniform texture2D texImage;
layout(set = 0, binding = 3) writeonly buffer Output
{
    vec4 innerColor;
    vec4 outerColor;
} outData;

void main()
{
    outData.innerColor = texture(sampler2D(texImage, texSampler), vec2(0.5));
    outData.outerColor = texture(sampler2D(texImage, texSampler), vec2(-0.1));
}
#version 450
layout(set = 0, binding = 3) uniform sampler texSampler;
layout(set = 0, binding = 4) uniform texture2D texImage;
layout(set = 0, binding = 5) writeonly buffer Output
{
    vec4 innerColor;
    vec4 outerColor;
} outData;

void main()
{
    outData.innerColor = texture(sampler2D(texImage, texSampler), vec2(0.5));
    outData.outerColor = texture(sampler2D(texImage, texSampler), vec2(-0.1));
}
#version 450
layout(set = 0, binding = 1) uniform sampler texSampler;
layout(set = 0, binding = 0) uniform texture2D texImage;
layout(set = 0, binding = 2) writeonly buffer Output
{
    vec4 innerColor;
    vec4 outerColor;
} outData;

void main()
{
    outData.innerColor = texture(sampler2D(texImage, texSampler), vec2(0.5));
    outData.outerColor = texture(sampler2D(texImage, texSampler), vec2(-0.1));
}
#version 450
layout(set = 0, binding = 2) uniform sampler texSampler;
layout(set = 0, binding = 1) uniform texture2D texImage;
layout(set = 0, binding = 3) writeonly buffer Output
{
    vec4 innerColor;
    vec4 outerColor;
} outData;

void main()
{
    outData.innerColor = texture(sampler2D(texImage, texSampler), vec2(0.5));
    outData.outerColor = texture(sampler2D(texImage, texSampler), vec2(-0.1));
}
#version 450
layout(set = 0, binding = 4) uniform sampler texSampler;
layout(set = 0, binding = 3) uniform texture2D texImage;
layout(set = 0, binding = 5) writeonly buffer Output
{
    vec4 innerColor;
    vec4 outerColor;
} outData;

void main()
{
    outData.innerColor = texture(sampler2D(texImage, texSampler), vec2(0.5));
    outData.outerColor = texture(sampler2D(texImage, texSampler), vec2(-0.1));
}
#version 450
layout(set = 0, binding = 0, rgba8) uniform readonly image2D storageImage;
layout(set = 0, binding = 1) writeonly buffer Output
{
    vec4 innerColor;
    vec4 outerColor;
} outData;

void main()
{
    outData.innerColor = imageLoad(storageImage, ivec2(0));
    outData.outerColor = imageLoad(storageImage, ivec2(0));
}
#version 450
layout(set = 0, binding = 1, rgba8) uniform readonly image2D storageImage;
layout(set = 0, binding = 2) writeonly buffer Output
{
    vec4 innerColor;
    vec4 outerColor;
} outData;

void main()
{
    outData.innerColor = imageLoad(storageImage, ivec2(0));
    outData.outerColor = imageLoad(storageImage, ivec2(0));
}
#version 450
layout(set = 0, binding = 3, rgba8) uniform readonly image2D storageImage;
layout(set = 0, binding = 4) writeonly buffer Output
{
    vec4 innerColor;
    vec4 outerColor;
} outData;

void main()
{
    outData.innerColor = imageLoad(storageImage, ivec2(0));
    outData.outerColor = imageLoad(storageImage, ivec2(0));
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 0) uniform textureBuffer texelBuffer;

void main (void)
{
    fragColor = texelFetch(texelBuffer, 0);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 1) uniform textureBuffer texelBuffer;

void main (void)
{
    fragColor = texelFetch(texelBuffer, 0);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 3) uniform textureBuffer texelBuffer;

void main (void)
{
    fragColor = texelFetch(texelBuffer, 0);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 0, rgba32f) uniform readonly imageBuffer texelBuffer;

void main (void)
{
    fragColor = imageLoad(texelBuffer, 0);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 1, rgba32f) uniform readonly imageBuffer texelBuffer;

void main (void)
{
    fragColor = imageLoad(texelBuffer, 0);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 3, rgba32f) uniform readonly imageBuffer texelBuffer;

void main (void)
{
    fragColor = imageLoad(texelBuffer, 0);
}
#version 450
layout(set = 0, binding = 0) uniform textureBuffer texelBuffer;
layout(set = 0, binding = 1) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = texelFetch(texelBuffer, 0);
}
#version 450
layout(set = 0, binding = 1) uniform textureBuffer texelBuffer;
layout(set = 0, binding = 2) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = texelFetch(texelBuffer, 0);
}
#version 450
layout(set = 0, binding = 3) uniform textureBuffer texelBuffer;
layout(set = 0, binding = 4) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = texelFetch(texelBuffer, 0);
}
#version 450
layout(set = 0, binding = 0, rgba32f) uniform readonly imageBuffer texelBuffer;
layout(set = 0, binding = 1) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = imageLoad(texelBuffer, 0);
}
#version 450
layout(set = 0, binding = 1, rgba32f) uniform readonly imageBuffer texelBuffer;
layout(set = 0, binding = 2) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = imageLoad(texelBuffer, 0);
}
#version 450
layout(set = 0, binding = 3, rgba32f) uniform readonly imageBuffer texelBuffer;
layout(set = 0, binding = 4) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = imageLoad(texelBuffer, 0);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput inputColor;

void main (void)
{
    fragColor = subpassLoad(inputColor);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(input_attachment_index = 0, set = 0, binding = 1) uniform subpassInput inputColor;

void main (void)
{
    fragColor = subpassLoad(inputColor);
}
#version 450
layout(location = 0) in highp vec2 texcoordFrag;
layout(location = 0) out highp vec4 fragColor;
layout(input_attachment_index = 0, set = 0, binding = 3) uniform subpassInput inputColor;

void main (void)
{
    fragColor = subpassLoad(inputColor);
}
