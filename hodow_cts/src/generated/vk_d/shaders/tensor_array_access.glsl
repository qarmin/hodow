#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	uint64_t tmp[1];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	uint64_t tmp[2];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	uint64_t tmp[3];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	uint64_t tmp[4];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	uint64_t tmp[5];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	uint64_t tmp[6];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	uint64_t tmp[7];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	uint64_t tmp[8];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	uint64_t tmp[12];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	uint64_t tmp[16];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	uint64_t tmp[24];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	uint64_t tmp[32];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	uint64_t tmp[48];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	uint64_t tmp[64];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	uint64_t tmp[1];
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	uint64_t tmp[2];
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	uint64_t tmp[3];
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	uint64_t tmp[4];
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	uint64_t tmp[5];
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	uint64_t tmp[6];
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	uint64_t tmp[7];
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	uint64_t tmp[8];
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	uint64_t tmp[12];
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	uint64_t tmp[16];
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	uint64_t tmp[24];
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	uint64_t tmp[32];
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	uint64_t tmp[48];
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	uint64_t tmp[64];
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	int64_t tmp[1];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	int64_t tmp[2];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	int64_t tmp[3];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	int64_t tmp[4];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	int64_t tmp[5];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	int64_t tmp[6];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	int64_t tmp[7];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	int64_t tmp[8];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	int64_t tmp[12];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	int64_t tmp[16];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	int64_t tmp[24];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	int64_t tmp[32];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	int64_t tmp[48];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	int64_t tmp[64];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	int64_t tmp[1];
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	int64_t tmp[2];
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	int64_t tmp[3];
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	int64_t tmp[4];
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	int64_t tmp[5];
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	int64_t tmp[6];
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	int64_t tmp[7];
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	int64_t tmp[8];
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	int64_t tmp[12];
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	int64_t tmp[16];
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	int64_t tmp[24];
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	int64_t tmp[32];
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	int64_t tmp[48];
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	int64_t tmp[64];
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	uint32_t tmp[1];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	uint32_t tmp[2];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	uint32_t tmp[3];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	uint32_t tmp[4];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	uint32_t tmp[5];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	uint32_t tmp[6];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	uint32_t tmp[7];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	uint32_t tmp[8];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	uint32_t tmp[12];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	uint32_t tmp[16];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	uint32_t tmp[24];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	uint32_t tmp[32];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	uint32_t tmp[48];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	uint32_t tmp[64];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	uint32_t tmp[1];
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	uint32_t tmp[2];
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	uint32_t tmp[3];
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	uint32_t tmp[4];
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	uint32_t tmp[5];
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	uint32_t tmp[6];
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	uint32_t tmp[7];
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	uint32_t tmp[8];
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	uint32_t tmp[12];
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	uint32_t tmp[16];
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	uint32_t tmp[24];
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	uint32_t tmp[32];
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	uint32_t tmp[48];
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	uint32_t tmp[64];
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	int32_t tmp[1];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	int32_t tmp[2];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	int32_t tmp[3];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	int32_t tmp[4];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	int32_t tmp[5];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	int32_t tmp[6];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	int32_t tmp[7];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	int32_t tmp[8];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	int32_t tmp[12];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	int32_t tmp[16];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	int32_t tmp[24];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	int32_t tmp[32];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	int32_t tmp[48];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	int32_t tmp[64];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	int32_t tmp[1];
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	int32_t tmp[2];
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	int32_t tmp[3];
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	int32_t tmp[4];
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	int32_t tmp[5];
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	int32_t tmp[6];
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	int32_t tmp[7];
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	int32_t tmp[8];
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	int32_t tmp[12];
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	int32_t tmp[16];
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	int32_t tmp[24];
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	int32_t tmp[32];
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	int32_t tmp[48];
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	int32_t tmp[64];
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	float32_t tmp[1];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	float32_t tmp[2];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	float32_t tmp[3];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	float32_t tmp[4];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	float32_t tmp[5];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	float32_t tmp[6];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	float32_t tmp[7];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	float32_t tmp[8];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	float32_t tmp[12];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	float32_t tmp[16];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	float32_t tmp[24];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	float32_t tmp[32];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	float32_t tmp[48];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	float32_t tmp[64];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	float32_t tmp[1];
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	float32_t tmp[2];
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	float32_t tmp[3];
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	float32_t tmp[4];
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	float32_t tmp[5];
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	float32_t tmp[6];
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	float32_t tmp[7];
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	float32_t tmp[8];
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	float32_t tmp[12];
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	float32_t tmp[16];
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	float32_t tmp[24];
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	float32_t tmp[32];
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	float32_t tmp[48];
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	float32_t tmp[64];
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	uint16_t tmp[1];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	uint16_t tmp[2];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	uint16_t tmp[3];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	uint16_t tmp[4];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	uint16_t tmp[5];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	uint16_t tmp[6];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	uint16_t tmp[7];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	uint16_t tmp[8];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	uint16_t tmp[12];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	uint16_t tmp[16];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	uint16_t tmp[24];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	uint16_t tmp[32];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	uint16_t tmp[48];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	uint16_t tmp[64];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	uint16_t tmp[1];
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	uint16_t tmp[2];
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	uint16_t tmp[3];
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	uint16_t tmp[4];
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	uint16_t tmp[5];
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	uint16_t tmp[6];
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	uint16_t tmp[7];
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	uint16_t tmp[8];
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	uint16_t tmp[12];
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	uint16_t tmp[16];
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	uint16_t tmp[24];
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	uint16_t tmp[32];
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	uint16_t tmp[48];
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	uint16_t tmp[64];
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	int16_t tmp[1];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	int16_t tmp[2];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	int16_t tmp[3];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	int16_t tmp[4];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	int16_t tmp[5];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	int16_t tmp[6];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	int16_t tmp[7];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	int16_t tmp[8];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	int16_t tmp[12];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	int16_t tmp[16];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	int16_t tmp[24];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	int16_t tmp[32];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	int16_t tmp[48];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	int16_t tmp[64];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	int16_t tmp[1];
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	int16_t tmp[2];
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	int16_t tmp[3];
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	int16_t tmp[4];
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	int16_t tmp[5];
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	int16_t tmp[6];
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	int16_t tmp[7];
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	int16_t tmp[8];
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	int16_t tmp[12];
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	int16_t tmp[16];
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	int16_t tmp[24];
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	int16_t tmp[32];
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	int16_t tmp[48];
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	int16_t tmp[64];
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	float16_t tmp[1];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	float16_t tmp[2];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	float16_t tmp[3];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	float16_t tmp[4];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	float16_t tmp[5];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	float16_t tmp[6];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	float16_t tmp[7];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	float16_t tmp[8];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	float16_t tmp[12];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	float16_t tmp[16];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	float16_t tmp[24];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	float16_t tmp[32];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	float16_t tmp[48];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	float16_t tmp[64];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	float16_t tmp[1];
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	float16_t tmp[2];
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	float16_t tmp[3];
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	float16_t tmp[4];
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	float16_t tmp[5];
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	float16_t tmp[6];
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	float16_t tmp[7];
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	float16_t tmp[8];
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	float16_t tmp[12];
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	float16_t tmp[16];
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	float16_t tmp[24];
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	float16_t tmp[32];
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	float16_t tmp[48];
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	float16_t tmp[64];
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	uint8_t tmp[1];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	uint8_t tmp[2];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	uint8_t tmp[3];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	uint8_t tmp[4];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	uint8_t tmp[5];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	uint8_t tmp[6];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	uint8_t tmp[7];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	uint8_t tmp[8];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	uint8_t tmp[12];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	uint8_t tmp[16];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	uint8_t tmp[24];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	uint8_t tmp[32];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	uint8_t tmp[48];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	uint8_t tmp[64];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	uint8_t tmp[1];
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	uint8_t tmp[2];
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	uint8_t tmp[3];
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	uint8_t tmp[4];
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	uint8_t tmp[5];
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	uint8_t tmp[6];
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	uint8_t tmp[7];
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	uint8_t tmp[8];
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	uint8_t tmp[12];
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	uint8_t tmp[16];
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	uint8_t tmp[24];
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	uint8_t tmp[32];
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	uint8_t tmp[48];
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	uint8_t tmp[64];
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	int8_t tmp[1];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	int8_t tmp[2];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	int8_t tmp[3];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	int8_t tmp[4];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	int8_t tmp[5];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	int8_t tmp[6];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	int8_t tmp[7];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	int8_t tmp[8];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	int8_t tmp[12];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	int8_t tmp[16];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	int8_t tmp[24];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	int8_t tmp[32];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	int8_t tmp[48];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	int8_t tmp[64];
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		data[buffer_index + i] = tmp[i];	}
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 1 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 1 * gl_GlobalInvocationID.x;
	int8_t tmp[1];
	for (int i = 0; (i < 1) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 2 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 2 * gl_GlobalInvocationID.x;
	int8_t tmp[2];
	for (int i = 0; (i < 2) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 3 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 3 * gl_GlobalInvocationID.x;
	int8_t tmp[3];
	for (int i = 0; (i < 3) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 4 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 4 * gl_GlobalInvocationID.x;
	int8_t tmp[4];
	for (int i = 0; (i < 4) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 5 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 5 * gl_GlobalInvocationID.x;
	int8_t tmp[5];
	for (int i = 0; (i < 5) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 6 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 6 * gl_GlobalInvocationID.x;
	int8_t tmp[6];
	for (int i = 0; (i < 6) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 7 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 7 * gl_GlobalInvocationID.x;
	int8_t tmp[7];
	for (int i = 0; (i < 7) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 8 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 8 * gl_GlobalInvocationID.x;
	int8_t tmp[8];
	for (int i = 0; (i < 8) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 12 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 12 * gl_GlobalInvocationID.x;
	int8_t tmp[12];
	for (int i = 0; (i < 12) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 16 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 16 * gl_GlobalInvocationID.x;
	int8_t tmp[16];
	for (int i = 0; (i < 16) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 24 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 24 * gl_GlobalInvocationID.x;
	int8_t tmp[24];
	for (int i = 0; (i < 24) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 32 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 32 * gl_GlobalInvocationID.x;
	int8_t tmp[32];
	for (int i = 0; (i < 32) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 48 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 48 * gl_GlobalInvocationID.x;
	int8_t tmp[48];
	for (int i = 0; (i < 48) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint offset_x = 64 * gl_GlobalInvocationID.x;
	const uint offset_y = gl_GlobalInvocationID.y;
	const uint coord_0 = offset_y / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = offset_y / (1 * size_d2) % size_d1;
	const uint coord_2 = offset_y / (1) % size_d2;
	const uint coord_3 = offset_x;
	const uint buffer_index = size_d3 * gl_GlobalInvocationID.y + 64 * gl_GlobalInvocationID.x;
	int8_t tmp[64];
	for (int i = 0; (i < 64) && (coord_3 + i < size_d3); ++i)
	{
		tmp[i] = data[buffer_index + i];
	}
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3), tmp);
}
