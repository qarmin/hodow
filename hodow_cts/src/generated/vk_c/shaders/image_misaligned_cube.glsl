#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) readonly uniform highp imageCube u_cubeImage0;
layout (binding = 1, rgba8) readonly uniform highp imageCube u_cubeImage1;
layout (binding = 2) writeonly buffer Output
{
    vec4 cube0_color0;
    vec4 cube0_color1;
    vec4 cube0_color2;
    vec4 cube0_color3;
    vec4 cube0_color4;
    vec4 cube0_color5;
    vec4 cube1_color0;
    vec4 cube1_color1;
    vec4 cube1_color2;
    vec4 cube1_color3;
    vec4 cube1_color4;
    vec4 cube1_color5;
} sb_out;

void main (void)
{
    sb_out.cube0_color0 = imageLoad(u_cubeImage0, ivec3(1, 1, 0));
    sb_out.cube0_color1 = imageLoad(u_cubeImage0, ivec3(1, 1, 1));
    sb_out.cube0_color2 = imageLoad(u_cubeImage0, ivec3(1, 1, 2));
    sb_out.cube0_color3 = imageLoad(u_cubeImage0, ivec3(1, 1, 3));
    sb_out.cube0_color4 = imageLoad(u_cubeImage0, ivec3(1, 1, 4));
    sb_out.cube0_color5 = imageLoad(u_cubeImage0, ivec3(1, 1, 5));
    sb_out.cube1_color0 = imageLoad(u_cubeImage1, ivec3(1, 1, 0));
    sb_out.cube1_color1 = imageLoad(u_cubeImage1, ivec3(1, 1, 1));
    sb_out.cube1_color2 = imageLoad(u_cubeImage1, ivec3(1, 1, 2));
    sb_out.cube1_color3 = imageLoad(u_cubeImage1, ivec3(1, 1, 3));
    sb_out.cube1_color4 = imageLoad(u_cubeImage1, ivec3(1, 1, 4));
    sb_out.cube1_color5 = imageLoad(u_cubeImage1, ivec3(1, 1, 5));
}
