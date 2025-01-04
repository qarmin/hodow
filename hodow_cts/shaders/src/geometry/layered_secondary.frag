#version 450

layout(location = 0) out vec4 o_color;
layout(location = 0) in  vec4 vert_color;
layout(set = 0, binding = 0, rgba8) uniform ${'image1DArray' if view == '1d_array' else 'image2DArray' if view == '2d_array' else 'imageCube' if view == 'cube' else 'imageCubeArray' if view == 'cube_array' else 'image3D'} storageImage;

void main(void)
{
    ${'ivec2 coord = ivec2(int(gl_FragCoord.x), gl_Layer);' if view == '1d_array' else 'ivec3 coord = ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), gl_Layer);'}
    vec4 src_color = imageLoad(storageImage, coord);
    o_color = (vert_color + src_color) / 2.0;
    imageStore(storageImage, coord, o_color);
}
