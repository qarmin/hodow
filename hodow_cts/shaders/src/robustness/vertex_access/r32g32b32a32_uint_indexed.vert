#version 310 es
precision highp float;
layout(location = 0) in uvec4 attr0;
layout(location = 1) in uvec4 attr1;
layout(location = 2) in uvec4 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[72];
};

void main (void)
{
	outData[(gl_InstanceIndex * 72) + (vertexNum * 12 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 72) + (vertexNum * 12 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 72) + (vertexNum * 12 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 72) + (vertexNum * 12 + 3)] = attr0[3];
	outData[(gl_InstanceIndex * 72) + (vertexNum * 12 + 4)] = attr1[0];
	outData[(gl_InstanceIndex * 72) + (vertexNum * 12 + 5)] = attr1[1];
	outData[(gl_InstanceIndex * 72) + (vertexNum * 12 + 6)] = attr1[2];
	outData[(gl_InstanceIndex * 72) + (vertexNum * 12 + 7)] = attr1[3];
	outData[(gl_InstanceIndex * 72) + (vertexNum * 12 + 8)] = attr2[0];
	outData[(gl_InstanceIndex * 72) + (vertexNum * 12 + 9)] = attr2[1];
	outData[(gl_InstanceIndex * 72) + (vertexNum * 12 + 10)] = attr2[2];
	outData[(gl_InstanceIndex * 72) + (vertexNum * 12 + 11)] = attr2[3];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
