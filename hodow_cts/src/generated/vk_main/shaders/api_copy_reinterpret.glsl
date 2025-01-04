#version 450
layout(location=0) out float texCoord;
vec2 positions[6] = vec2[](
    vec2(-1.0f, 1.0f),
    vec2(1.0f, 1.0f),
    vec2(-1.0f, -1.0f),
    vec2(-1.0f, -1.0f),
    vec2(1.0f, 1.0f),
    vec2(1.0f, -1.0f)
);

void main() {
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
    texCoord.x = (positions[gl_VertexIndex].x < 0.0) ? 0.0 : positions[gl_VertexIndex].x;
}
#version 450
layout(set=0, binding=0) uniform sampler1D tex;
layout(location=0) in float texCoord;
layout(location=0) out vec2 outColor;

void main() {
    vec4 texColor = texelFetch(tex, int(texCoord.x * 64), 0);
    outColor = vec2(texColor.rg);
}
#version 450
layout(set=0, binding=0) uniform usampler1D tex;
layout(location=0) in float texCoord;
layout(location=0) out uvec2 outColor;

void main() {
    uvec4 texColor = texelFetch(tex, int(texCoord.x * 16), 0);
    outColor = uvec2(texColor.rg);
}
#version 450
layout(set = 0, binding = 0, rg32ui) uniform highp uimage1D srcImg;
layout(set = 0, binding = 1, rg32ui) uniform highp uimage1D dstImg;
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
    uvec4 srcColor = uvec4(2031647, 0u, 2031647, 0u); // blue
    uvec4 dstColor = uvec4(4160813056u, 0u, 4160813056u, 0u); // red
    imageStore(srcImg, int(gl_GlobalInvocationID.x), srcColor);
    imageStore(dstImg, int(gl_GlobalInvocationID.x), dstColor);
}
#version 450
layout(set = 0, binding = 0, rg32ui) uniform highp uimage1D dstImg;
layout(set = 0, binding = 1, rgba8) uniform highp image1D outputImg;
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
    uvec2 color = uvec2(2031647, 0u); // blue
    vec4 green = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    vec4 red = vec4(1.0f, 0.0f, 0.0f, 1.0f);
    uvec2 dstColor = imageLoad(dstImg, int(gl_GlobalInvocationID.x)).rg;
    imageStore(outputImg, int(gl_GlobalInvocationID.x), color == dstColor ? green : red );
}
#version 450
layout(set=0, binding=0) uniform usampler1D tex;
layout(location=0) in float texCoord;
layout(location=0) out uvec4 outColor;

void main() {
    uvec4 texColor = texelFetch(tex, int(texCoord.x * 16), 0);
    outColor = uvec4(texColor.rgba);
}
#version 450
layout(set = 0, binding = 0, rgba32ui) uniform highp uimage1D srcImg;
layout(set = 0, binding = 1, rgba32ui) uniform highp uimage1D dstImg;
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
    uvec4 srcColor = uvec4(4294967295u, 4294967295u, 2031647, 0u); // blue
    uvec4 dstColor = uvec4(4294967295u, 4294967295u, 4160813056u, 0u); // red
    imageStore(srcImg, int(gl_GlobalInvocationID.x), srcColor);
    imageStore(dstImg, int(gl_GlobalInvocationID.x), dstColor);
}
#version 450
layout(set = 0, binding = 0, rgba32ui) uniform highp uimage1D dstImg;
layout(set = 0, binding = 1, rgba8) uniform highp image1D outputImg;
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
    uvec4 color = uvec4(4294967295u, 4294967295u, 2031647, 0u); // blue
    vec4 green = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    vec4 red = vec4(1.0f, 0.0f, 0.0f, 1.0f);
    uvec4 dstColor = imageLoad(dstImg, int(gl_GlobalInvocationID.x)).rgba;
    imageStore(outputImg, int(gl_GlobalInvocationID.x), color == dstColor ? green : red );
}
#version 450
layout(location=0) out vec2 texCoord;
vec2 positions[6] = vec2[](
    vec2(-1.0f, 1.0f),
    vec2(1.0f, 1.0f),
    vec2(-1.0f, -1.0f),
    vec2(-1.0f, -1.0f),
    vec2(1.0f, 1.0f),
    vec2(1.0f, -1.0f)
);

void main() {
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
    texCoord.x = (positions[gl_VertexIndex].x < 0.0) ? 0.0 : positions[gl_VertexIndex].x;
    texCoord.y = (positions[gl_VertexIndex].y < 0.0) ? 0.0 : positions[gl_VertexIndex].y;
}
#version 450
layout(set=0, binding=0) uniform sampler2D tex;
layout(location=0) in vec2 texCoord;
layout(location=0) out vec2 outColor;

void main() {
    vec4 texColor = texelFetch(tex, ivec2(texCoord.x * 64, texCoord.y * 64), 0);
    outColor = vec2(texColor.rg);
}
#version 450
layout(set=0, binding=0) uniform usampler2D tex;
layout(location=0) in vec2 texCoord;
layout(location=0) out uvec2 outColor;

void main() {
    uvec4 texColor = texelFetch(tex, ivec2(texCoord.x * 16, texCoord.y * 16), 0);
    outColor = uvec2(texColor.rg);
}
#version 450
layout(set = 0, binding = 0, rg32ui) uniform highp uimage2D srcImg;
layout(set = 0, binding = 1, rg32ui) uniform highp uimage2D dstImg;
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
    uvec4 srcColor = uvec4(2031647, 0u, 2031647, 0u); // blue
    uvec4 dstColor = uvec4(4160813056u, 0u, 4160813056u, 0u); // red
    imageStore(srcImg, ivec2(gl_GlobalInvocationID.xy), srcColor);
    imageStore(dstImg, ivec2(gl_GlobalInvocationID.xy), dstColor);
}
#version 450
layout(set = 0, binding = 0, rg32ui) uniform highp uimage2D dstImg;
layout(set = 0, binding = 1, rgba8) uniform highp image2D outputImg;
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
    uvec2 color = uvec2(2031647, 0u); // blue
    vec4 green = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    vec4 red = vec4(1.0f, 0.0f, 0.0f, 1.0f);
    uvec2 dstColor = imageLoad(dstImg, ivec2(gl_GlobalInvocationID.xy)).rg;
    imageStore(outputImg, ivec2(gl_GlobalInvocationID.xy), color == dstColor ? green : red );
}
#version 450
layout(set=0, binding=0) uniform usampler2D tex;
layout(location=0) in vec2 texCoord;
layout(location=0) out uvec4 outColor;

void main() {
    uvec4 texColor = texelFetch(tex, ivec2(texCoord.x * 16, texCoord.y * 16), 0);
    outColor = uvec4(texColor.rgba);
}
#version 450
layout(set = 0, binding = 0, rgba32ui) uniform highp uimage2D srcImg;
layout(set = 0, binding = 1, rgba32ui) uniform highp uimage2D dstImg;
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
    uvec4 srcColor = uvec4(4294967295u, 4294967295u, 2031647, 0u); // blue
    uvec4 dstColor = uvec4(4294967295u, 4294967295u, 4160813056u, 0u); // red
    imageStore(srcImg, ivec2(gl_GlobalInvocationID.xy), srcColor);
    imageStore(dstImg, ivec2(gl_GlobalInvocationID.xy), dstColor);
}
#version 450
layout(set = 0, binding = 0, rgba32ui) uniform highp uimage2D dstImg;
layout(set = 0, binding = 1, rgba8) uniform highp image2D outputImg;
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
    uvec4 color = uvec4(4294967295u, 4294967295u, 2031647, 0u); // blue
    vec4 green = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    vec4 red = vec4(1.0f, 0.0f, 0.0f, 1.0f);
    uvec4 dstColor = imageLoad(dstImg, ivec2(gl_GlobalInvocationID.xy)).rgba;
    imageStore(outputImg, ivec2(gl_GlobalInvocationID.xy), color == dstColor ? green : red );
}
