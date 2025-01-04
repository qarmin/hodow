#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
layout(set = 0, binding = 4) uniform isampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
layout(set = 0, binding = 4) uniform isampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
layout(set = 0, binding = 4) uniform isampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
layout(set = 0, binding = 4) uniform usampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
layout(set = 0, binding = 4) uniform usampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r8ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
layout(set = 0, binding = 4) uniform usampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
	data[buffer_idx+1] = int8_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
layout(set = 0, binding = 4) uniform isampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
	data[buffer_idx+1] = int8_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
	data[buffer_idx+1] = int8_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
layout(set = 0, binding = 4) uniform isampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
	data[buffer_idx+1] = int8_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
	data[buffer_idx+1] = int8_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
layout(set = 0, binding = 4) uniform isampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
	data[buffer_idx+1] = int8_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
	data[buffer_idx+1] = uint8_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
layout(set = 0, binding = 4) uniform usampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
	data[buffer_idx+1] = uint8_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
	data[buffer_idx+1] = uint8_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
layout(set = 0, binding = 4) uniform usampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
	data[buffer_idx+1] = uint8_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
	data[buffer_idx+1] = uint8_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg8ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
layout(set = 0, binding = 4) uniform usampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
	data[buffer_idx+1] = uint8_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
	data[buffer_idx+1] = int8_t(pixel_data[1]);
	data[buffer_idx+2] = int8_t(pixel_data[2]);
	data[buffer_idx+3] = int8_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
layout(set = 0, binding = 4) uniform isampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
	data[buffer_idx+1] = int8_t(pixel_data[1]);
	data[buffer_idx+2] = int8_t(pixel_data[2]);
	data[buffer_idx+3] = int8_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
	data[buffer_idx+1] = int8_t(pixel_data[1]);
	data[buffer_idx+2] = int8_t(pixel_data[2]);
	data[buffer_idx+3] = int8_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
layout(set = 0, binding = 4) uniform isampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
	data[buffer_idx+1] = int8_t(pixel_data[1]);
	data[buffer_idx+2] = int8_t(pixel_data[2]);
	data[buffer_idx+3] = int8_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
	data[buffer_idx+1] = int8_t(pixel_data[1]);
	data[buffer_idx+2] = int8_t(pixel_data[2]);
	data[buffer_idx+3] = int8_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int8_t data[]; };
layout(set = 0, binding = 4) uniform isampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int8_t(pixel_data[0]);
	data[buffer_idx+1] = int8_t(pixel_data[1]);
	data[buffer_idx+2] = int8_t(pixel_data[2]);
	data[buffer_idx+3] = int8_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
	data[buffer_idx+1] = uint8_t(pixel_data[1]);
	data[buffer_idx+2] = uint8_t(pixel_data[2]);
	data[buffer_idx+3] = uint8_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
layout(set = 0, binding = 4) uniform usampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
	data[buffer_idx+1] = uint8_t(pixel_data[1]);
	data[buffer_idx+2] = uint8_t(pixel_data[2]);
	data[buffer_idx+3] = uint8_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
	data[buffer_idx+1] = uint8_t(pixel_data[1]);
	data[buffer_idx+2] = uint8_t(pixel_data[2]);
	data[buffer_idx+3] = uint8_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
layout(set = 0, binding = 4) uniform usampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
	data[buffer_idx+1] = uint8_t(pixel_data[1]);
	data[buffer_idx+2] = uint8_t(pixel_data[2]);
	data[buffer_idx+3] = uint8_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
	data[buffer_idx+1] = uint8_t(pixel_data[1]);
	data[buffer_idx+2] = uint8_t(pixel_data[2]);
	data[buffer_idx+3] = uint8_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba8ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint8_t data[]; };
layout(set = 0, binding = 4) uniform usampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint8_t(pixel_data[0]);
	data[buffer_idx+1] = uint8_t(pixel_data[1]);
	data[buffer_idx+2] = uint8_t(pixel_data[2]);
	data[buffer_idx+3] = uint8_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
layout(set = 0, binding = 4) uniform isampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
layout(set = 0, binding = 4) uniform isampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
layout(set = 0, binding = 4) uniform isampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
layout(set = 0, binding = 4) uniform usampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
layout(set = 0, binding = 4) uniform usampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r16ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
layout(set = 0, binding = 4) uniform usampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
	data[buffer_idx+1] = int16_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
layout(set = 0, binding = 4) uniform isampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
	data[buffer_idx+1] = int16_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
	data[buffer_idx+1] = int16_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
layout(set = 0, binding = 4) uniform isampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
	data[buffer_idx+1] = int16_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
	data[buffer_idx+1] = int16_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
layout(set = 0, binding = 4) uniform isampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
	data[buffer_idx+1] = int16_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
	data[buffer_idx+1] = uint16_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
layout(set = 0, binding = 4) uniform usampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
	data[buffer_idx+1] = uint16_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
	data[buffer_idx+1] = uint16_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
layout(set = 0, binding = 4) uniform usampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
	data[buffer_idx+1] = uint16_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
	data[buffer_idx+1] = uint16_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg16ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
layout(set = 0, binding = 4) uniform usampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
	data[buffer_idx+1] = uint16_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
	data[buffer_idx+1] = int16_t(pixel_data[1]);
	data[buffer_idx+2] = int16_t(pixel_data[2]);
	data[buffer_idx+3] = int16_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
layout(set = 0, binding = 4) uniform isampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
	data[buffer_idx+1] = int16_t(pixel_data[1]);
	data[buffer_idx+2] = int16_t(pixel_data[2]);
	data[buffer_idx+3] = int16_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
	data[buffer_idx+1] = int16_t(pixel_data[1]);
	data[buffer_idx+2] = int16_t(pixel_data[2]);
	data[buffer_idx+3] = int16_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
layout(set = 0, binding = 4) uniform isampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
	data[buffer_idx+1] = int16_t(pixel_data[1]);
	data[buffer_idx+2] = int16_t(pixel_data[2]);
	data[buffer_idx+3] = int16_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
	data[buffer_idx+1] = int16_t(pixel_data[1]);
	data[buffer_idx+2] = int16_t(pixel_data[2]);
	data[buffer_idx+3] = int16_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int16_t data[]; };
layout(set = 0, binding = 4) uniform isampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int16_t(pixel_data[0]);
	data[buffer_idx+1] = int16_t(pixel_data[1]);
	data[buffer_idx+2] = int16_t(pixel_data[2]);
	data[buffer_idx+3] = int16_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
	data[buffer_idx+1] = uint16_t(pixel_data[1]);
	data[buffer_idx+2] = uint16_t(pixel_data[2]);
	data[buffer_idx+3] = uint16_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
layout(set = 0, binding = 4) uniform usampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
	data[buffer_idx+1] = uint16_t(pixel_data[1]);
	data[buffer_idx+2] = uint16_t(pixel_data[2]);
	data[buffer_idx+3] = uint16_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
	data[buffer_idx+1] = uint16_t(pixel_data[1]);
	data[buffer_idx+2] = uint16_t(pixel_data[2]);
	data[buffer_idx+3] = uint16_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
layout(set = 0, binding = 4) uniform usampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
	data[buffer_idx+1] = uint16_t(pixel_data[1]);
	data[buffer_idx+2] = uint16_t(pixel_data[2]);
	data[buffer_idx+3] = uint16_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
	data[buffer_idx+1] = uint16_t(pixel_data[1]);
	data[buffer_idx+2] = uint16_t(pixel_data[2]);
	data[buffer_idx+3] = uint16_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba16ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint16_t data[]; };
layout(set = 0, binding = 4) uniform usampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint16_t(pixel_data[0]);
	data[buffer_idx+1] = uint16_t(pixel_data[1]);
	data[buffer_idx+2] = uint16_t(pixel_data[2]);
	data[buffer_idx+3] = uint16_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
layout(set = 0, binding = 4) uniform isampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
layout(set = 0, binding = 4) uniform isampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
layout(set = 0, binding = 4) uniform isampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
layout(set = 0, binding = 4) uniform usampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
layout(set = 0, binding = 4) uniform usampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r32ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
layout(set = 0, binding = 4) uniform usampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
	data[buffer_idx+1] = int32_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
layout(set = 0, binding = 4) uniform isampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
	data[buffer_idx+1] = int32_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
	data[buffer_idx+1] = int32_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
layout(set = 0, binding = 4) uniform isampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
	data[buffer_idx+1] = int32_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
	data[buffer_idx+1] = int32_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
layout(set = 0, binding = 4) uniform isampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
	data[buffer_idx+1] = int32_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
	data[buffer_idx+1] = uint32_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
layout(set = 0, binding = 4) uniform usampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
	data[buffer_idx+1] = uint32_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
	data[buffer_idx+1] = uint32_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
layout(set = 0, binding = 4) uniform usampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
	data[buffer_idx+1] = uint32_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
	data[buffer_idx+1] = uint32_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rg32ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
layout(set = 0, binding = 4) uniform usampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 2;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
	data[buffer_idx+1] = uint32_t(pixel_data[1]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
	data[buffer_idx+1] = int32_t(pixel_data[1]);
	data[buffer_idx+2] = int32_t(pixel_data[2]);
	data[buffer_idx+3] = int32_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32i) uniform iimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
layout(set = 0, binding = 4) uniform isampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
	data[buffer_idx+1] = int32_t(pixel_data[1]);
	data[buffer_idx+2] = int32_t(pixel_data[2]);
	data[buffer_idx+3] = int32_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
	data[buffer_idx+1] = int32_t(pixel_data[1]);
	data[buffer_idx+2] = int32_t(pixel_data[2]);
	data[buffer_idx+3] = int32_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32i) uniform iimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
layout(set = 0, binding = 4) uniform isampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
	data[buffer_idx+1] = int32_t(pixel_data[1]);
	data[buffer_idx+2] = int32_t(pixel_data[2]);
	data[buffer_idx+3] = int32_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = ivec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const ivec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
	data[buffer_idx+1] = int32_t(pixel_data[1]);
	data[buffer_idx+2] = int32_t(pixel_data[2]);
	data[buffer_idx+3] = int32_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32i) uniform iimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int32_t data[]; };
layout(set = 0, binding = 4) uniform isampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const ivec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = int32_t(pixel_data[0]);
	data[buffer_idx+1] = int32_t(pixel_data[1]);
	data[buffer_idx+2] = int32_t(pixel_data[2]);
	data[buffer_idx+3] = int32_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
	data[buffer_idx+1] = uint32_t(pixel_data[1]);
	data[buffer_idx+2] = uint32_t(pixel_data[2]);
	data[buffer_idx+3] = uint32_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32ui) uniform uimage1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
layout(set = 0, binding = 4) uniform usampler1D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);
	const float sampled_coord = float(sampled_coord_0);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
	data[buffer_idx+1] = uint32_t(pixel_data[1]);
	data[buffer_idx+2] = uint32_t(pixel_data[2]);
	data[buffer_idx+3] = uint32_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
	data[buffer_idx+1] = uint32_t(pixel_data[1]);
	data[buffer_idx+2] = uint32_t(pixel_data[2]);
	data[buffer_idx+3] = uint32_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32ui) uniform uimage2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
layout(set = 0, binding = 4) uniform usampler2D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const vec2 sampled_coord = vec2(sampled_coord_0, sampled_coord_1);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
	data[buffer_idx+1] = uint32_t(pixel_data[1]);
	data[buffer_idx+2] = uint32_t(pixel_data[2]);
	data[buffer_idx+3] = uint32_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = uvec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const uvec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
	data[buffer_idx+1] = uint32_t(pixel_data[1]);
	data[buffer_idx+2] = uint32_t(pixel_data[2]);
	data[buffer_idx+3] = uint32_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, rgba32ui) uniform uimage3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint32_t data[]; };
layout(set = 0, binding = 4) uniform usampler3D samplr;
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 4;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims[0]);
	const float sampled_coord_1 = (float(image_coord_1) + 0.5) / float(image_dims[1]);
	const float sampled_coord_2 = (float(image_coord_2) + 0.5) / float(image_dims[2]);
	const vec3 sampled_coord = vec3(sampled_coord_0, sampled_coord_1, sampled_coord_2);
	const uvec4 pixel_data = texture(samplr, sampled_coord);
	data[buffer_idx+0] = uint32_t(pixel_data[0]);
	data[buffer_idx+1] = uint32_t(pixel_data[1]);
	data[buffer_idx+2] = uint32_t(pixel_data[2]);
	data[buffer_idx+3] = uint32_t(pixel_data[3]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_shader_image_int64 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r64i) uniform i64image1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const i64vec4 pixel_data = i64vec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_shader_image_int64 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r64i) uniform i64image1D image;
layout(set = 0, binding = 3, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const i64vec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int64_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_shader_image_int64 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r64i) uniform i64image2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const i64vec4 pixel_data = i64vec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_shader_image_int64 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r64i) uniform i64image2D image;
layout(set = 0, binding = 3, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const i64vec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int64_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_shader_image_int64 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r64i) uniform i64image3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const i64vec4 pixel_data = i64vec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_shader_image_int64 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r64i) uniform i64image3D image;
layout(set = 0, binding = 3, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const i64vec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = int64_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_shader_image_int64 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r64ui) uniform u64image1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const u64vec4 pixel_data = u64vec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_shader_image_int64 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r64ui) uniform u64image1D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const int image_dims = imageSize(image);
	if (gl_GlobalInvocationID.x >= image_dims) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;
	const int image_coord = int(image_coord_0);
	const u64vec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint64_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_shader_image_int64 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r64ui) uniform u64image2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const u64vec4 pixel_data = u64vec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_shader_image_int64 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r64ui) uniform u64image2D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec2 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const ivec2 image_coord = ivec2(image_coord_0, image_coord_1);
	const u64vec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint64_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1) % size_d2;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), data[index]);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_shader_image_int64 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r64ui) uniform u64image3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const u64vec4 pixel_data = u64vec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);
	imageStore(image, image_coord, pixel_data);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_shader_image_int64 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 2, r64ui) uniform u64image3D image;
layout(set = 0, binding = 3, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint buffer_idx = gl_GlobalInvocationID.x * 1;
	const ivec3 image_dims = imageSize(image);
	const uint texel_count = image_dims[0] * image_dims[1] * image_dims[2];
	if (gl_GlobalInvocationID.x >= texel_count) return;
	const uint image_coord_0 = gl_GlobalInvocationID.x / (1) % image_dims[0];
	const uint image_coord_1 = gl_GlobalInvocationID.x / (1 * image_dims[0]) % image_dims[1];
	const uint image_coord_2 = gl_GlobalInvocationID.x / (1 * image_dims[0] * image_dims[1]) % image_dims[2];
	const ivec3 image_coord = ivec3(image_coord_0, image_coord_1, image_coord_2);
	const u64vec4 pixel_data = imageLoad(image, image_coord);
	data[buffer_idx+0] = uint64_t(pixel_data[0]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1) % size_d3;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), data[index]);
}
