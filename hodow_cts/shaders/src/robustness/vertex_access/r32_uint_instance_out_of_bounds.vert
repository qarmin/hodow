#version 310 es
precision highp float;
layout(location = 0) in uint  attr0;
layout(location = 1) in uint  attr1;
layout(location = 2) in uint  attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[27];
};

void main (void)
{
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
