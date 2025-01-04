#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0), data[index]);
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
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0), data[index]);
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
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0), data[index]);
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
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0), data[index]);
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
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	float32_t value;
	tensorReadARM(tens, uint[](coord_0), value);
	data[index] = float32_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	float32_t value;
	float floatValue = float(data[index]);
	value = float32_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	float32_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1), value);
	data[index] = float32_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	float32_t value;
	float floatValue = float(data[index]);
	value = float32_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
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
	float32_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), value);
	data[index] = float32_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
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
	float32_t value;
	float floatValue = float(data[index]);
	value = float32_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
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
	float32_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), value);
	data[index] = float32_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
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
	float32_t value;
	float floatValue = float(data[index]);
	value = float32_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	float32_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), value);
	data[index] = float32_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	float32_t value;
	float floatValue = float(data[index]);
	value = float32_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	float32_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), value);
	data[index] = float32_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	float32_t value;
	float floatValue = float(data[index]);
	value = float32_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	float32_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), value);
	data[index] = float32_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	float32_t value;
	float floatValue = float(data[index]);
	value = float32_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	float32_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), value);
	data[index] = float32_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	float32_t value;
	float floatValue = float(data[index]);
	value = float32_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0), data[index]);
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
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0), data[index]);
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
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	float16_t value;
	tensorReadARM(tens, uint[](coord_0), value);
	data[index] = float16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	float16_t value;
	float floatValue = float(data[index]);
	value = float16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	float16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1), value);
	data[index] = float16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	float16_t value;
	float floatValue = float(data[index]);
	value = float16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
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
	float16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), value);
	data[index] = float16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
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
	float16_t value;
	float floatValue = float(data[index]);
	value = float16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
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
	float16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), value);
	data[index] = float16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
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
	float16_t value;
	float floatValue = float(data[index]);
	value = float16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	float16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), value);
	data[index] = float16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	float16_t value;
	float floatValue = float(data[index]);
	value = float16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	float16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), value);
	data[index] = float16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	float16_t value;
	float floatValue = float(data[index]);
	value = float16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	float16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), value);
	data[index] = float16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	float16_t value;
	float floatValue = float(data[index]);
	value = float16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	float16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), value);
	data[index] = float16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	float16_t value;
	float floatValue = float(data[index]);
	value = float16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0), data[index]);
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
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0), data[index]);
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
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), data[index]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	floate5m2_t value;
	tensorReadARM(tens, uint[](coord_0), value);
	data[index] = floate5m2_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	floate5m2_t value;
	float floatValue = float(data[index]);
	value = floate5m2_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	floate5m2_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1), value);
	data[index] = floate5m2_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	floate5m2_t value;
	float floatValue = float(data[index]);
	value = floate5m2_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
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
	floate5m2_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), value);
	data[index] = floate5m2_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
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
	floate5m2_t value;
	float floatValue = float(data[index]);
	value = floate5m2_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
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
	floate5m2_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), value);
	data[index] = floate5m2_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
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
	floate5m2_t value;
	float floatValue = float(data[index]);
	value = floate5m2_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	floate5m2_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), value);
	data[index] = floate5m2_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	floate5m2_t value;
	float floatValue = float(data[index]);
	value = floate5m2_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	floate5m2_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), value);
	data[index] = floate5m2_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	floate5m2_t value;
	float floatValue = float(data[index]);
	value = floate5m2_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	floate5m2_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), value);
	data[index] = floate5m2_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	floate5m2_t value;
	float floatValue = float(data[index]);
	value = floate5m2_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	floate5m2_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), value);
	data[index] = floate5m2_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate5m2_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate5m2_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	floate5m2_t value;
	float floatValue = float(data[index]);
	value = floate5m2_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	floate4m3_t value;
	tensorReadARM(tens, uint[](coord_0), value);
	data[index] = floate4m3_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	floate4m3_t value;
	float floatValue = float(data[index]);
	value = floate4m3_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	floate4m3_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1), value);
	data[index] = floate4m3_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	floate4m3_t value;
	float floatValue = float(data[index]);
	value = floate4m3_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
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
	floate4m3_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), value);
	data[index] = floate4m3_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
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
	floate4m3_t value;
	float floatValue = float(data[index]);
	value = floate4m3_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
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
	floate4m3_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), value);
	data[index] = floate4m3_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
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
	floate4m3_t value;
	float floatValue = float(data[index]);
	value = floate4m3_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	floate4m3_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), value);
	data[index] = floate4m3_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	floate4m3_t value;
	float floatValue = float(data[index]);
	value = floate4m3_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	floate4m3_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), value);
	data[index] = floate4m3_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	floate4m3_t value;
	float floatValue = float(data[index]);
	value = floate4m3_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	floate4m3_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), value);
	data[index] = floate4m3_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	floate4m3_t value;
	float floatValue = float(data[index]);
	value = floate4m3_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	floate4m3_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), value);
	data[index] = floate4m3_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<floate4m3_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { floate4m3_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	floate4m3_t value;
	float floatValue = float(data[index]);
	value = floate4m3_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	bfloat16_t value;
	tensorReadARM(tens, uint[](coord_0), value);
	data[index] = bfloat16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint tensor_element_count = size_d0;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1) % size_d0;
	const uint index = gl_GlobalInvocationID.x;
	bfloat16_t value;
	float floatValue = float(data[index]);
	value = bfloat16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	bfloat16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1), value);
	data[index] = bfloat16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint tensor_element_count = size_d0 * size_d1;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1) % size_d1;
	const uint index = gl_GlobalInvocationID.x;
	bfloat16_t value;
	float floatValue = float(data[index]);
	value = bfloat16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
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
	bfloat16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2), value);
	data[index] = bfloat16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
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
	bfloat16_t value;
	float floatValue = float(data[index]);
	value = bfloat16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
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
	bfloat16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), value);
	data[index] = bfloat16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
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
	bfloat16_t value;
	float floatValue = float(data[index]);
	value = bfloat16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	bfloat16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), value);
	data[index] = bfloat16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 5> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1) % size_d4;
	const uint index = gl_GlobalInvocationID.x;
	bfloat16_t value;
	float floatValue = float(data[index]);
	value = bfloat16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	bfloat16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), value);
	data[index] = bfloat16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1) % size_d5;
	const uint index = gl_GlobalInvocationID.x;
	bfloat16_t value;
	float floatValue = float(data[index]);
	value = bfloat16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	bfloat16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), value);
	data[index] = bfloat16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 7> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1) % size_d6;
	const uint index = gl_GlobalInvocationID.x;
	bfloat16_t value;
	float floatValue = float(data[index]);
	value = bfloat16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6), value);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	bfloat16_t value;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), value);
	data[index] = bfloat16_t(float(value));
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<bfloat16_t, 8> tens;
layout(set=0, binding = 1, std430) buffer _buff { bfloat16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint size_d4 = tensorSizeARM(tens, 4);
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint size_d6 = tensorSizeARM(tens, 6);
	const uint size_d7 = tensorSizeARM(tens, 7);
	const uint tensor_element_count = size_d0 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7;
	if (gl_GlobalInvocationID.x >= tensor_element_count) return;
	const uint coord_0 = gl_GlobalInvocationID.x / (1 * size_d1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d0;
	const uint coord_1 = gl_GlobalInvocationID.x / (1 * size_d2 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d1;
	const uint coord_2 = gl_GlobalInvocationID.x / (1 * size_d3 * size_d4 * size_d5 * size_d6 * size_d7) % size_d2;
	const uint coord_3 = gl_GlobalInvocationID.x / (1 * size_d4 * size_d5 * size_d6 * size_d7) % size_d3;
	const uint coord_4 = gl_GlobalInvocationID.x / (1 * size_d5 * size_d6 * size_d7) % size_d4;
	const uint coord_5 = gl_GlobalInvocationID.x / (1 * size_d6 * size_d7) % size_d5;
	const uint coord_6 = gl_GlobalInvocationID.x / (1 * size_d7) % size_d6;
	const uint coord_7 = gl_GlobalInvocationID.x / (1) % size_d7;
	const uint index = gl_GlobalInvocationID.x;
	bfloat16_t value;
	float floatValue = float(data[index]);
	value = bfloat16_t(floatValue);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, coord_5, coord_6, coord_7), value);
}
