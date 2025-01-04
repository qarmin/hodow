#version 450 core
layout (set = 0, binding = 0) uniform texture2D image;
layout (set = 0, binding = 1) uniform sampler samp;
layout (rgba8, set = 0, binding = 2) uniform image2D verifyImage;
void main (void) {
    ivec2 uv = ivec2(gl_FragCoord.xy);
    vec2 texCoord = gl_FragCoord.xy / ${size}.0;
    vec4 color = texture(sampler2D(image, samp), texCoord);
    imageStore(verifyImage, uv, color);
}
