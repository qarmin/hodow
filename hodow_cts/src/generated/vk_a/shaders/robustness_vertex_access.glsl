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
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) out vec4 fragColor;
void main (void)
{
	fragColor = vec4(1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in uint  attr0;
layout(location = 1) in uint  attr1;
layout(location = 2) in uint  attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[9];
};

void main (void)
{
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
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
#version 310 es
precision highp float;
layout(location = 0) in uint  attr0;
layout(location = 1) in uint  attr1;
layout(location = 2) in uint  attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[18];
};

void main (void)
{
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in int  attr0;
layout(location = 1) in int  attr1;
layout(location = 2) in int  attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[27];
};

void main (void)
{
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in int  attr0;
layout(location = 1) in int  attr1;
layout(location = 2) in int  attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[9];
};

void main (void)
{
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in int  attr0;
layout(location = 1) in int  attr1;
layout(location = 2) in int  attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[27];
};

void main (void)
{
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in int  attr0;
layout(location = 1) in int  attr1;
layout(location = 2) in int  attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[18];
};

void main (void)
{
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in float  attr0;
layout(location = 1) in float  attr1;
layout(location = 2) in float  attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[27];
};

void main (void)
{
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in float  attr0;
layout(location = 1) in float  attr1;
layout(location = 2) in float  attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[9];
};

void main (void)
{
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in float  attr0;
layout(location = 1) in float  attr1;
layout(location = 2) in float  attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[27];
};

void main (void)
{
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in float  attr0;
layout(location = 1) in float  attr1;
layout(location = 2) in float  attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[18];
};

void main (void)
{
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in uvec2 attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in uvec2 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[54];
};

void main (void)
{
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 2)] = attr1[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 3)] = attr1[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 4)] = attr2[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 5)] = attr2[1];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
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
#version 310 es
precision highp float;
layout(location = 0) in uvec2 attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in uvec2 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[54];
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
#version 310 es
precision highp float;
layout(location = 0) in uvec2 attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in uvec2 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[36];
};

void main (void)
{
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 2)] = attr1[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 3)] = attr1[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 4)] = attr2[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 5)] = attr2[1];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in ivec2 attr1;
layout(location = 2) in ivec2 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[54];
};

void main (void)
{
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 2)] = attr1[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 3)] = attr1[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 4)] = attr2[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 5)] = attr2[1];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in ivec2 attr1;
layout(location = 2) in ivec2 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[18];
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
#version 310 es
precision highp float;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in ivec2 attr1;
layout(location = 2) in ivec2 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[54];
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
#version 310 es
precision highp float;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in ivec2 attr1;
layout(location = 2) in ivec2 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[36];
};

void main (void)
{
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 2)] = attr1[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 3)] = attr1[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 4)] = attr2[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 5)] = attr2[1];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in vec2 attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in vec2 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[54];
};

void main (void)
{
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 2)] = attr1[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 3)] = attr1[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 4)] = attr2[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 6 + 5)] = attr2[1];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in vec2 attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in vec2 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[18];
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
#version 310 es
precision highp float;
layout(location = 0) in vec2 attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in vec2 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[54];
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
#version 310 es
precision highp float;
layout(location = 0) in vec2 attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in vec2 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[36];
};

void main (void)
{
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 2)] = attr1[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 3)] = attr1[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 4)] = attr2[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 6 + 5)] = attr2[1];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
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
#version 310 es
precision highp float;
layout(location = 0) in uvec3 attr0;
layout(location = 1) in uvec3 attr1;
layout(location = 2) in uvec3 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[27];
};

void main (void)
{
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 3)] = attr1[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 4)] = attr1[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 5)] = attr1[2];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 6)] = attr2[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 7)] = attr2[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 8)] = attr2[2];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
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
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 3)] = attr1[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 4)] = attr1[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 5)] = attr1[2];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 6)] = attr2[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 7)] = attr2[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 8)] = attr2[2];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in uvec3 attr0;
layout(location = 1) in uvec3 attr1;
layout(location = 2) in uvec3 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[54];
};

void main (void)
{
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 3)] = attr1[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 4)] = attr1[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 5)] = attr1[2];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 6)] = attr2[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 7)] = attr2[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 8)] = attr2[2];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in ivec3 attr1;
layout(location = 2) in ivec3 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[81];
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
#version 310 es
precision highp float;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in ivec3 attr1;
layout(location = 2) in ivec3 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[27];
};

void main (void)
{
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 3)] = attr1[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 4)] = attr1[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 5)] = attr1[2];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 6)] = attr2[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 7)] = attr2[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 8)] = attr2[2];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in ivec3 attr1;
layout(location = 2) in ivec3 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[81];
};

void main (void)
{
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 3)] = attr1[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 4)] = attr1[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 5)] = attr1[2];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 6)] = attr2[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 7)] = attr2[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 8)] = attr2[2];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in ivec3 attr1;
layout(location = 2) in ivec3 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[54];
};

void main (void)
{
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 3)] = attr1[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 4)] = attr1[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 5)] = attr1[2];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 6)] = attr2[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 7)] = attr2[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 8)] = attr2[2];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in vec3 attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in vec3 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[81];
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
#version 310 es
precision highp float;
layout(location = 0) in vec3 attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in vec3 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[27];
};

void main (void)
{
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 3)] = attr1[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 4)] = attr1[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 5)] = attr1[2];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 6)] = attr2[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 7)] = attr2[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 8)] = attr2[2];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in vec3 attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in vec3 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[81];
};

void main (void)
{
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 3)] = attr1[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 4)] = attr1[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 5)] = attr1[2];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 6)] = attr2[0];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 7)] = attr2[1];
	outData[(gl_InstanceIndex * 27) + (vertexNum * 9 + 8)] = attr2[2];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in vec3 attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in vec3 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[54];
};

void main (void)
{
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 3)] = attr1[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 4)] = attr1[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 5)] = attr1[2];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 6)] = attr2[0];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 7)] = attr2[1];
	outData[(gl_InstanceIndex * 54) + (vertexNum * 9 + 8)] = attr2[2];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in uvec4 attr0;
layout(location = 1) in uvec4 attr1;
layout(location = 2) in uvec4 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[108];
};

void main (void)
{
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 3)] = attr0[3];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 4)] = attr1[0];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 5)] = attr1[1];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 6)] = attr1[2];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 7)] = attr1[3];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 8)] = attr2[0];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 9)] = attr2[1];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 10)] = attr2[2];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 11)] = attr2[3];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in uvec4 attr0;
layout(location = 1) in uvec4 attr1;
layout(location = 2) in uvec4 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[36];
};

void main (void)
{
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 3)] = attr0[3];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 4)] = attr1[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 5)] = attr1[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 6)] = attr1[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 7)] = attr1[3];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 8)] = attr2[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 9)] = attr2[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 10)] = attr2[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 11)] = attr2[3];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in uvec4 attr0;
layout(location = 1) in uvec4 attr1;
layout(location = 2) in uvec4 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint outData[108];
};

void main (void)
{
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 3)] = attr0[3];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 4)] = attr1[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 5)] = attr1[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 6)] = attr1[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 7)] = attr1[3];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 8)] = attr2[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 9)] = attr2[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 10)] = attr2[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 11)] = attr2[3];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
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
#version 310 es
precision highp float;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in ivec4 attr1;
layout(location = 2) in ivec4 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[108];
};

void main (void)
{
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 3)] = attr0[3];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 4)] = attr1[0];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 5)] = attr1[1];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 6)] = attr1[2];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 7)] = attr1[3];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 8)] = attr2[0];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 9)] = attr2[1];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 10)] = attr2[2];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 11)] = attr2[3];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in ivec4 attr1;
layout(location = 2) in ivec4 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[36];
};

void main (void)
{
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 3)] = attr0[3];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 4)] = attr1[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 5)] = attr1[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 6)] = attr1[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 7)] = attr1[3];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 8)] = attr2[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 9)] = attr2[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 10)] = attr2[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 11)] = attr2[3];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in ivec4 attr1;
layout(location = 2) in ivec4 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[108];
};

void main (void)
{
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 3)] = attr0[3];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 4)] = attr1[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 5)] = attr1[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 6)] = attr1[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 7)] = attr1[3];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 8)] = attr2[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 9)] = attr2[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 10)] = attr2[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 11)] = attr2[3];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in ivec4 attr1;
layout(location = 2) in ivec4 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int outData[72];
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
#version 310 es
precision highp float;
layout(location = 0) in vec4 attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in vec4 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[108];
};

void main (void)
{
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 3)] = attr0[3];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 4)] = attr1[0];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 5)] = attr1[1];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 6)] = attr1[2];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 7)] = attr1[3];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 8)] = attr2[0];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 9)] = attr2[1];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 10)] = attr2[2];
	outData[(gl_InstanceIndex * 108) + (vertexNum * 12 + 11)] = attr2[3];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in vec4 attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in vec4 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[36];
};

void main (void)
{
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 3)] = attr0[3];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 4)] = attr1[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 5)] = attr1[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 6)] = attr1[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 7)] = attr1[3];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 8)] = attr2[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 9)] = attr2[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 10)] = attr2[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 11)] = attr2[3];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in vec4 attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in vec4 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[108];
};

void main (void)
{
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 0)] = attr0[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 1)] = attr0[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 2)] = attr0[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 3)] = attr0[3];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 4)] = attr1[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 5)] = attr1[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 6)] = attr1[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 7)] = attr1[3];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 8)] = attr2[0];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 9)] = attr2[1];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 10)] = attr2[2];
	outData[(gl_InstanceIndex * 36) + (vertexNum * 12 + 11)] = attr2[3];

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in vec4 attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in vec4 attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	float outData[72];
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
#version 440
precision highp float;
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) in uint64_t attr0;
layout(location = 1) in uint64_t attr1;
layout(location = 2) in uint64_t attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint64_t outData[27];
};

void main (void)
{
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 440
precision highp float;
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) in uint64_t attr0;
layout(location = 1) in uint64_t attr1;
layout(location = 2) in uint64_t attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint64_t outData[9];
};

void main (void)
{
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 440
precision highp float;
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) in uint64_t attr0;
layout(location = 1) in uint64_t attr1;
layout(location = 2) in uint64_t attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint64_t outData[27];
};

void main (void)
{
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 440
precision highp float;
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) in uint64_t attr0;
layout(location = 1) in uint64_t attr1;
layout(location = 2) in uint64_t attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	uint64_t outData[18];
};

void main (void)
{
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
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
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 27) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 440
precision highp float;
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) in int64_t attr0;
layout(location = 1) in int64_t attr1;
layout(location = 2) in int64_t attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int64_t outData[9];
};

void main (void)
{
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 9) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
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
#version 440
precision highp float;
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) in int64_t attr0;
layout(location = 1) in int64_t attr1;
layout(location = 2) in int64_t attr2;
layout(location = 3) in int vertexNum;
layout(set = 0, binding = 0, std430) buffer outBuffer
{
	int64_t outData[18];
};

void main (void)
{
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 0)] = attr0;
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 1)] = attr1;
	outData[(gl_InstanceIndex * 18) + (vertexNum * 3 + 2)] = attr2;

	gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
