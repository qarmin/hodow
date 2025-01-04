#version 310 es
precision highp float;
layout(location = 0) in uvec3 attr0;
layout(location = 1) in uvec3 attr1;
layout(location = 2) in uvec3 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[81];
};

void main (void)
{
	outData[(gl_InstanceIndex * 81) + (vertexNum * 9 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 81) + (vertexNum * 9 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 81) + (vertexNum * 9 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 81) + (vertexNum * 9 + 3)] = attr1[0];
	outData[(gl_InstanceIndex * 81) + (vertexNum * 9 + 4)] = attr1[1];
	outData[(gl_InstanceIndex * 81) + (vertexNum * 9 + 5)] = attr1[2];
	outData[(gl_InstanceIndex * 81) + (vertexNum * 9 + 6)] = attr2[0];
	outData[(gl_InstanceIndex * 81) + (vertexNum * 9 + 7)] = attr2[1];
	outData[(gl_InstanceIndex * 81) + (vertexNum * 9 + 8)] = attr2[2];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
