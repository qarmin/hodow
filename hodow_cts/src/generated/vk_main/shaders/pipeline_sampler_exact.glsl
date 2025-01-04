#version 450

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
} pushc;

layout(location = 0) in vec2 inPosition;
layout(location = 1) in vec2 inTexCoord;

layout(location = 0) out vec2 fragTexCoord;

void main() {
    gl_Position = vec4(inPosition, 0.0, 1.0);
    fragTexCoord = vec2(inTexCoord.x, inTexCoord.y);
}
#version 450

layout(set = 0, binding = 0) uniform sampler2D texSampler;

layout(location = 0) in vec2 fragTexCoord;

layout(location = 0) out vec4 outColor;

void main() {
    outColor = texture(texSampler, fragTexCoord);
}
#version 450

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
} pushc;

layout(location = 0) in vec2 inPosition;
layout(location = 1) in vec2 inTexCoord;

layout(location = 0) out vec2 fragTexCoord;

void main() {
    gl_Position = vec4(inPosition, 0.0, 1.0);
    fragTexCoord = vec2(inTexCoord.x * pushc.texWidth, inTexCoord.y * pushc.texHeight);
}
#version 450

layout(set = 0, binding = 0) uniform sampler2D texSampler;

layout(location = 0) in vec2 fragTexCoord;

layout(location = 0) out vec4 outColor;

void main() {
    outColor = textureLod(texSampler, fragTexCoord, 0.0f);
}
#version 450

layout(set = 0, binding = 0) uniform isampler2D texSampler;

layout(location = 0) in vec2 fragTexCoord;

layout(location = 0) out ivec4 outColor;

void main() {
    outColor = texture(texSampler, fragTexCoord);
}
#version 450

layout(set = 0, binding = 0) uniform isampler2D texSampler;

layout(location = 0) in vec2 fragTexCoord;

layout(location = 0) out ivec4 outColor;

void main() {
    outColor = textureLod(texSampler, fragTexCoord, 0.0f);
}
#version 450

layout(set = 0, binding = 0) uniform usampler2D texSampler;

layout(location = 0) in vec2 fragTexCoord;

layout(location = 0) out uvec4 outColor;

void main() {
    outColor = texture(texSampler, fragTexCoord);
}
#version 450

layout(set = 0, binding = 0) uniform usampler2D texSampler;

layout(location = 0) in vec2 fragTexCoord;

layout(location = 0) out uvec4 outColor;

void main() {
    outColor = textureLod(texSampler, fragTexCoord, 0.0f);
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, r8) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, r8) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rg8) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rg8) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, r8_snorm) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, r8_snorm) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rg8_snorm) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rg8_snorm) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rgba8_snorm) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rgba8_snorm) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform usampler2D texSampler;
layout(set = 0, binding = 1, r8ui) uniform writeonly uimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        uvec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        uvec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform usampler2D texSampler;
layout(set = 0, binding = 1, r8ui) uniform writeonly uimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        uvec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        uvec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform usampler2D texSampler;
layout(set = 0, binding = 1, rg8ui) uniform writeonly uimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        uvec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        uvec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform usampler2D texSampler;
layout(set = 0, binding = 1, rg8ui) uniform writeonly uimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        uvec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        uvec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform usampler2D texSampler;
layout(set = 0, binding = 1, rgba8ui) uniform writeonly uimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        uvec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        uvec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform usampler2D texSampler;
layout(set = 0, binding = 1, rgba8ui) uniform writeonly uimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        uvec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        uvec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform isampler2D texSampler;
layout(set = 0, binding = 1, r8i) uniform writeonly iimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        ivec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        ivec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform isampler2D texSampler;
layout(set = 0, binding = 1, r8i) uniform writeonly iimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        ivec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        ivec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform isampler2D texSampler;
layout(set = 0, binding = 1, rg8i) uniform writeonly iimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        ivec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        ivec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform isampler2D texSampler;
layout(set = 0, binding = 1, rg8i) uniform writeonly iimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        ivec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        ivec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, r16f) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, r16f) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rg32f) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rg32f) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rgba16f) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rgba16f) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform usampler2D texSampler;
layout(set = 0, binding = 1, rg16ui) uniform writeonly uimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        uvec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        uvec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform usampler2D texSampler;
layout(set = 0, binding = 1, rg16ui) uniform writeonly uimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        uvec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        uvec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform isampler2D texSampler;
layout(set = 0, binding = 1, rg16i) uniform writeonly iimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        ivec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        ivec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform isampler2D texSampler;
layout(set = 0, binding = 1, rg16i) uniform writeonly iimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        ivec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        ivec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, r16_snorm) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, r16_snorm) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, r32f) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, r32f) uniform writeonly image2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        vec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        vec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform isampler2D texSampler;
layout(set = 0, binding = 1, r32i) uniform writeonly iimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        ivec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        ivec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform isampler2D texSampler;
layout(set = 0, binding = 1, r32i) uniform writeonly iimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        ivec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        ivec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform usampler2D texSampler;
layout(set = 0, binding = 1, r32ui) uniform writeonly uimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        uvec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        uvec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform usampler2D texSampler;
layout(set = 0, binding = 1, r32ui) uniform writeonly uimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        uvec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        uvec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform isampler2D texSampler;
layout(set = 0, binding = 1, rgba32i) uniform writeonly iimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (false) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        ivec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        ivec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 450
layout(local_size_x = 16, local_size_y = 16) in;

layout(set = 0, binding = 0) uniform isampler2D texSampler;
layout(set = 0, binding = 1, rgba32i) uniform writeonly iimage2D outImage;

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
    float minU;
    float minV;
    float scaleU;
    float scaleV;
} pushc;

void main() {
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outImage);
    if (pos.x >= size.x || pos.y >= size.y) return;

    vec2 normPos = (vec2(pos) + 0.5) / vec2(size);
    vec2 uv = vec2(pushc.minU, pushc.minV) + normPos * vec2(pushc.scaleU, pushc.scaleV);

    if (true) {
        uv.x *= pushc.texWidth;
        uv.y *= pushc.texHeight;
        ivec4 color = textureLod(texSampler, uv, 0.0f);
        imageStore(outImage, pos, color);
    } else {
        ivec4 color = texture(texSampler, uv);
        imageStore(outImage, pos, color);
    }
}
#version 460
layout (location=0) in vec4 inPos;
void main (void) {
    gl_Position = inPos;
}
#version 460
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D texSampler;
layout (push_constant, std430) uniform PushConstantBlock {
    float lodLevel;
    float fbWidth;
    float fbHeight;
} pc;
void main (void) {
    outColor = textureLod(texSampler, vec2(gl_FragCoord.x / pc.fbWidth, gl_FragCoord.y / pc.fbHeight), pc.lodLevel);
}
#version 460
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D texSampler;
layout (push_constant, std430) uniform PushConstantBlock {
    float lodLevel;
    float fbWidth;
    float fbHeight;
} pc;
void main (void) {
    outColor = texture(texSampler, vec2(gl_FragCoord.x / pc.fbWidth, gl_FragCoord.y / pc.fbHeight), pc.lodLevel);
}
#version 460
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D texSampler;
layout (push_constant, std430) uniform PushConstantBlock {
    float lodLevel;
    float fbWidth;
    float fbHeight;
} pc;
void main (void) {
    outColor = textureLod(texSampler, vec2(gl_FragCoord.x / pc.fbWidth, gl_FragCoord.y / pc.fbHeight), 0.0);
}
#version 460
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly image2D outImage;
layout(push_constant, std430) uniform PushConstantBlock {
    float lodLevel;
    float fbWidth;
    float fbHeight;
} pc;
void main (void) {
    vec4 color = textureLod(texSampler, vec2((vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pc.fbWidth, pc.fbHeight)), pc.lodLevel);
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460
layout(local_size_x = 1, local_size_y = 1) in;
layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1, rgba8) uniform writeonly image2D outImage;
layout(push_constant, std430) uniform PushConstantBlock {
    float lodLevel;
    float fbWidth;
    float fbHeight;
} pc;
void main (void) {
    vec4 color = textureLod(texSampler, vec2((vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pc.fbWidth, pc.fbHeight)), 0.0);
    imageStore(outImage, ivec2(gl_GlobalInvocationID.xy), color);
}
