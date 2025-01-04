#version 450 core
layout(rgba8, set = 0, binding = 0) uniform image2D storageImage;
void main()
{
    ivec2 uv = ivec2(gl_FragCoord.xy);
    float c = float((uv.x + uv.y) & 1);
    vec4 color = vec4(c, c, c, 1.0);
    imageStore(storageImage, uv, color);
}
