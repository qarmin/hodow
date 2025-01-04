#version 440
precision highp float;
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) in int64_t attr0;
layout(location = 1) in int64_t attr1;
layout(location = 2) in int64_t attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int64_t outData[27];
};

void main (void)
{
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
