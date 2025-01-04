#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 1> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint64_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint64_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int64_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int64_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int64_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int64_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int64_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int64_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int64_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int64_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int64_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int64_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int64_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int64_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int64_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int64_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int64_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int64_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int64_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint32_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint32_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int32_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int32_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int32_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int32_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int32_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int32_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int32_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int32_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int32_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int32_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int32_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int32_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int32_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int32_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int32_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int32_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, float32_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, float32_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, float32_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, float32_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, float32_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, float32_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, float32_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, float32_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, float32_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, float32_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, float32_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, float32_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, float32_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, float32_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, float32_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float32_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { float32_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint16_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int16_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int16_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int16_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int16_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int16_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int16_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int16_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, float16_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, float16_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, float16_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, float16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, float16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, float16_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, float16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, float16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, float16_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, float16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, float16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, float16_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, float16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, float16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, float16_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<float16_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { float16_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, uint8_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<uint8_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { uint8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int8_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int8_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int8_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int8_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int8_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int8_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 2> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int8_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int8_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int8_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 3> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int8_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int8_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int8_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, int8_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, int8_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, int8_t(84)
);
}
#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding = 0) uniform tensorARM<int8_t, 6> tens;
layout(set=0, binding = 1, std430) buffer _buff { int8_t data[]; };
void main()
{
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(84)
);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(84)
);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(84)
);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, floate5m2_t(84)
);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(84)
);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(84)
);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(84)
);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, floate4m3_t(84)
);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(24)
);
	tensorReadARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(42)
);
	tensorReadARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(84)
);
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
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1;
	if (line >= line_count) return;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](size_d0 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](size_d0 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](size_d0 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](size_d0 + 65537), data[buffer_base_index + 3]);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(84)
);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0;
	if (line >= line_count) return;
	const uint coord_0 = line / (1) % size_d0;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, size_d1 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, size_d1 + 65537), data[buffer_base_index + 3]);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(84)
);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1) % size_d0;
	const uint coord_1 = line / (1) % size_d1;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, size_d2 + 65537), data[buffer_base_index + 3]);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(84)
);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2) % size_d0;
	const uint coord_1 = line / (1 * size_d2) % size_d1;
	const uint coord_2 = line / (1) % size_d2;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, size_d3 + 65537), data[buffer_base_index + 3]);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(24)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(42)
);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorReadARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3], gl_TensorOperandsOutOfBoundsValueARM, bfloat16_t(84)
);
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
	const uint size_d0 = tensorSizeARM(tens, 0) + 1;
	const uint size_d1 = tensorSizeARM(tens, 1) + 1;
	const uint size_d2 = tensorSizeARM(tens, 2) + 1;
	const uint size_d3 = tensorSizeARM(tens, 3) + 1;
	const uint size_d4 = tensorSizeARM(tens, 4) + 1;
	const uint size_d5 = tensorSizeARM(tens, 5);
	const uint line = gl_GlobalInvocationID.x;
	const uint line_count = 1 * size_d0 * size_d1 * size_d2 * size_d3 * size_d4;
	if (line >= line_count) return;
	const uint coord_0 = line / (1 * size_d1 * size_d2 * size_d3 * size_d4) % size_d0;
	const uint coord_1 = line / (1 * size_d2 * size_d3 * size_d4) % size_d1;
	const uint coord_2 = line / (1 * size_d3 * size_d4) % size_d2;
	const uint coord_3 = line / (1 * size_d4) % size_d3;
	const uint coord_4 = line / (1) % size_d4;
	const uint buffer_base_index = gl_GlobalInvocationID.x * 4;
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + -1), data[buffer_base_index + 0]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 0), data[buffer_base_index + 1]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 13), data[buffer_base_index + 2]);
	tensorWriteARM(tens, uint[](coord_0, coord_1, coord_2, coord_3, coord_4, size_d5 + 65537), data[buffer_base_index + 3]);
}
