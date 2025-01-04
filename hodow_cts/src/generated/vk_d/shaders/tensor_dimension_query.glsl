#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint64_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int64_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint32_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int32_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<float32_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint16_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int16_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<float16_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint8_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int8_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<bool, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<floate5m2_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<floate4m3_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<bfloat16_t, 1> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint64_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int64_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint32_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int32_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<float32_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint16_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int16_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<float16_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint8_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int8_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<bool, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<floate5m2_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<floate4m3_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<bfloat16_t, 2> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint64_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int64_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint32_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int32_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<float32_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint16_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int16_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<float16_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint8_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int8_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<bool, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<floate5m2_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<floate4m3_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<bfloat16_t, 3> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint64_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int64_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint32_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int32_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<float32_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint16_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int16_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<float16_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint8_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int8_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<bool, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<floate5m2_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<floate4m3_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<bfloat16_t, 4> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint64_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int64_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint32_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int32_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<float32_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint16_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int16_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<float16_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint8_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int8_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<bool, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<floate5m2_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<floate4m3_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<bfloat16_t, 5> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint64_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int64_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint32_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int32_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<float32_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint16_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int16_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<float16_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<uint8_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<int8_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<bool, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_float_e5m2 : require
#extension GL_ARM_tensors_float_e5m2 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<floate5m2_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_float_e4m3 : require
#extension GL_ARM_tensors_float_e4m3 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<floate4m3_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

#extension GL_EXT_bfloat16: require
#extension GL_ARM_tensors_bfloat16 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0, binding=0) uniform tensorARM<bfloat16_t, 6> tens;
layout(set=0, binding=1, std430) buffer _buff { uint data[]; };

void main()
{
	data[0] = tensorSizeARM(tens, 0);
	data[1] = tensorSizeARM(tens, 1);
	data[2] = tensorSizeARM(tens, 2);
	data[3] = tensorSizeARM(tens, 3);
	data[4] = tensorSizeARM(tens, 4);
	data[5] = tensorSizeARM(tens, 5);
}