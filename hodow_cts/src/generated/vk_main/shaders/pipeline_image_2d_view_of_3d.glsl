#version 450 core
layout (local_size_x = 1, local_size_y = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp image2D storageImage;
void main (void) {
    ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
    float c = float((uv.x + uv.y) & 1);
    vec4 color = vec4(c, c, c, 1.0);
    imageStore(storageImage, uv, color);
}
#version 450 core
layout (local_size_x = 1, local_size_y = 1) in;
layout (set=0, binding = 0) uniform texture2D image;
layout (set=0, binding = 1) uniform sampler samp;
layout (rgba8, set=0, binding = 2) writeonly uniform highp image2D verifyImage;
void main (void) {
    ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
    vec2 texCoord = vec2(gl_GlobalInvocationID.xy) / 16.0;
    vec4 color = texture(sampler2D(image, samp), texCoord);
    imageStore(verifyImage, uv, color);
}
#version 450 core
layout (local_size_x = 1, local_size_y = 1) in;
layout (set=0, binding = 0) uniform texture2D image;
layout (set=0, binding = 1) uniform sampler samp;
layout (rgba8, set=0, binding = 2) writeonly uniform highp image2D verifyImage;
void main (void) {
    ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
    vec2 texCoord = vec2(gl_GlobalInvocationID.xy) / 64.0;
    vec4 color = texture(sampler2D(image, samp), texCoord);
    imageStore(verifyImage, uv, color);
}
#version 450 core
layout (local_size_x = 1, local_size_y = 1) in;
layout (binding = 0) uniform sampler2D combinedSampler;
layout (rgba8, set=0, binding=1) writeonly uniform highp image2D verifyImage;
void main (void) {
    ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
    vec2 texCoord = vec2(gl_GlobalInvocationID.xy) / 16.0;
    vec4 color = texture(combinedSampler, texCoord);
    imageStore(verifyImage, uv, color);
}
#version 450 core
layout (local_size_x = 1, local_size_y = 1) in;
layout (binding = 0) uniform sampler2D combinedSampler;
layout (rgba8, set=0, binding=1) writeonly uniform highp image2D verifyImage;
void main (void) {
    ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
    vec2 texCoord = vec2(gl_GlobalInvocationID.xy) / 64.0;
    vec4 color = texture(combinedSampler, texCoord);
    imageStore(verifyImage, uv, color);
}
#version 450 core
layout(location = 0) in vec4 in_position;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main() {
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450 core
layout(rgba8, set = 0, binding = 0) uniform image2D storageImage;
void main()
{
    ivec2 uv = ivec2(gl_FragCoord.xy);
    float c = float((uv.x + uv.y) & 1);
    vec4 color = vec4(c, c, c, 1.0);
    imageStore(storageImage, uv, color);
}
#version 450 core
layout (set = 0, binding = 0) uniform texture2D image;
layout (set = 0, binding = 1) uniform sampler samp;
layout (rgba8, set = 0, binding = 2) uniform image2D verifyImage;
void main (void) {
    ivec2 uv = ivec2(gl_FragCoord.xy);
    vec2 texCoord = gl_FragCoord.xy / 16.0;
    vec4 color = texture(sampler2D(image, samp), texCoord);
    imageStore(verifyImage, uv, color);
}
#version 450 core
layout (set = 0, binding = 0) uniform texture2D image;
layout (set = 0, binding = 1) uniform sampler samp;
layout (rgba8, set = 0, binding = 2) uniform image2D verifyImage;
void main (void) {
    ivec2 uv = ivec2(gl_FragCoord.xy);
    vec2 texCoord = gl_FragCoord.xy / 64.0;
    vec4 color = texture(sampler2D(image, samp), texCoord);
    imageStore(verifyImage, uv, color);
}
#version 450 core
layout (set = 0, binding = 0) uniform sampler2D combinedSampler;
layout (rgba8, set = 0, binding = 1) uniform image2D verifyImage;
void main (void) {
    ivec2 uv = ivec2(gl_FragCoord.xy);
    vec2 texCoord = gl_FragCoord.xy / 16.0;
    vec4 color = texture(combinedSampler, texCoord);
    imageStore(verifyImage, uv, color);
}
#version 450 core
layout (set = 0, binding = 0) uniform sampler2D combinedSampler;
layout (rgba8, set = 0, binding = 1) uniform image2D verifyImage;
void main (void) {
    ivec2 uv = ivec2(gl_FragCoord.xy);
    vec2 texCoord = gl_FragCoord.xy / 64.0;
    vec4 color = texture(combinedSampler, texCoord);
    imageStore(verifyImage, uv, color);
}
