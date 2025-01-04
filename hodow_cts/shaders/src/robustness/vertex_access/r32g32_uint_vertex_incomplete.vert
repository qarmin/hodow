#version 310 es
precision highp float;
layout(location = 0) in uvec2 attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in uvec2 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[18];
};

void main (void)
{
	outData[(gl_InstanceIndex * 18) + (vertexNum * 6 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 18) + (vertexNum * 6 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 18) + (vertexNum * 6 + 2)] = attr1[0];
	outData[(gl_InstanceIndex * 18) + (vertexNum * 6 + 3)] = attr1[1];
	outData[(gl_InstanceIndex * 18) + (vertexNum * 6 + 4)] = attr2[0];
	outData[(gl_InstanceIndex * 18) + (vertexNum * 6 + 5)] = attr2[1];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
