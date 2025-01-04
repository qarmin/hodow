#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) sampler2DShadow tex;
void main()
{
    // Sample border color of opaque white which makes the depth comparison 0.5 > 1.0 false.
    color_out = vec4(texture(tex, vec3(2.0, 2.0, 0.5)), 0.0, 0.0, 1.0);
}
