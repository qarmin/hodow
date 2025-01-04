#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump int in0;
};
struct Outputs
{
	mediump int out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	int in0 = int(inputs[invocationNdx].in0);
	int out0;

	out0 = abs(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp int in0;
};
struct Outputs
{
	highp int out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	int in0 = int(inputs[invocationNdx].in0);
	int out0;

	out0 = abs(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec2 in0;
};
struct Outputs
{
	mediump ivec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec2 in0 = ivec2(inputs[invocationNdx].in0);
	ivec2 out0;

	out0 = abs(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec2 in0;
};
struct Outputs
{
	highp ivec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec2 in0 = ivec2(inputs[invocationNdx].in0);
	ivec2 out0;

	out0 = abs(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec3 in0;
};
struct Outputs
{
	mediump ivec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec3 in0 = ivec3(inputs[invocationNdx].in0);
	ivec3 out0;

	out0 = abs(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec3 in0;
};
struct Outputs
{
	highp ivec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec3 in0 = ivec3(inputs[invocationNdx].in0);
	ivec3 out0;

	out0 = abs(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec4 in0;
};
struct Outputs
{
	mediump ivec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec4 in0 = ivec4(inputs[invocationNdx].in0);
	ivec4 out0;

	out0 = abs(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec4 in0;
};
struct Outputs
{
	highp ivec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec4 in0 = ivec4(inputs[invocationNdx].in0);
	ivec4 out0;

	out0 = abs(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<int, 5> in0;
};
struct Outputs
{
	mediump vector<int, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<int, 5> in0 = vector<int, 5>(inputs[invocationNdx].in0);
	vector<int, 5> out0;

	out0 = abs(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<int, 5> in0;
};
struct Outputs
{
	highp vector<int, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<int, 5> in0 = vector<int, 5>(inputs[invocationNdx].in0);
	vector<int, 5> out0;

	out0 = abs(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump int in0;
};
struct Outputs
{
	mediump int out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	int in0 = int(inputs[invocationNdx].in0);
	int out0;

	out0 = sign(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp int in0;
};
struct Outputs
{
	highp int out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	int in0 = int(inputs[invocationNdx].in0);
	int out0;

	out0 = sign(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec2 in0;
};
struct Outputs
{
	mediump ivec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec2 in0 = ivec2(inputs[invocationNdx].in0);
	ivec2 out0;

	out0 = sign(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec2 in0;
};
struct Outputs
{
	highp ivec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec2 in0 = ivec2(inputs[invocationNdx].in0);
	ivec2 out0;

	out0 = sign(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec3 in0;
};
struct Outputs
{
	mediump ivec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec3 in0 = ivec3(inputs[invocationNdx].in0);
	ivec3 out0;

	out0 = sign(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec3 in0;
};
struct Outputs
{
	highp ivec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec3 in0 = ivec3(inputs[invocationNdx].in0);
	ivec3 out0;

	out0 = sign(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec4 in0;
};
struct Outputs
{
	mediump ivec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec4 in0 = ivec4(inputs[invocationNdx].in0);
	ivec4 out0;

	out0 = sign(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec4 in0;
};
struct Outputs
{
	highp ivec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec4 in0 = ivec4(inputs[invocationNdx].in0);
	ivec4 out0;

	out0 = sign(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<int, 5> in0;
};
struct Outputs
{
	mediump vector<int, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<int, 5> in0 = vector<int, 5>(inputs[invocationNdx].in0);
	vector<int, 5> out0;

	out0 = sign(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<int, 5> in0;
};
struct Outputs
{
	highp vector<int, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<int, 5> in0 = vector<int, 5>(inputs[invocationNdx].in0);
	vector<int, 5> out0;

	out0 = sign(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump float in0;
};
struct Outputs
{
	bool out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	float in0 = float(inputs[invocationNdx].in0);
	bool out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp float in0;
};
struct Outputs
{
	bool out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	float in0 = float(inputs[invocationNdx].in0);
	bool out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec2 in0;
};
struct Outputs
{
	bvec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	bvec2 out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 in0;
};
struct Outputs
{
	bvec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	bvec2 out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec3 in0;
};
struct Outputs
{
	bvec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec3 in0 = vec3(inputs[invocationNdx].in0);
	bvec3 out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 in0;
};
struct Outputs
{
	bvec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec3 in0 = vec3(inputs[invocationNdx].in0);
	bvec3 out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec4 in0;
};
struct Outputs
{
	bvec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec4 in0 = vec4(inputs[invocationNdx].in0);
	bvec4 out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 in0;
};
struct Outputs
{
	bvec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec4 in0 = vec4(inputs[invocationNdx].in0);
	bvec4 out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<float, 5> in0;
};
struct Outputs
{
	vector<bool, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<float, 5> in0 = vector<float, 5>(inputs[invocationNdx].in0);
	vector<bool, 5> out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<float, 5> in0;
};
struct Outputs
{
	vector<bool, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<float, 5> in0 = vector<float, 5>(inputs[invocationNdx].in0);
	vector<bool, 5> out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump float in0;
};
struct Outputs
{
	bool out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	float in0 = float(inputs[invocationNdx].in0);
	bool out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp float in0;
};
struct Outputs
{
	bool out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	float in0 = float(inputs[invocationNdx].in0);
	bool out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec2 in0;
};
struct Outputs
{
	bvec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	bvec2 out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 in0;
};
struct Outputs
{
	bvec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	bvec2 out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec3 in0;
};
struct Outputs
{
	bvec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec3 in0 = vec3(inputs[invocationNdx].in0);
	bvec3 out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 in0;
};
struct Outputs
{
	bvec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec3 in0 = vec3(inputs[invocationNdx].in0);
	bvec3 out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec4 in0;
};
struct Outputs
{
	bvec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec4 in0 = vec4(inputs[invocationNdx].in0);
	bvec4 out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 in0;
};
struct Outputs
{
	bvec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec4 in0 = vec4(inputs[invocationNdx].in0);
	bvec4 out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<float, 5> in0;
};
struct Outputs
{
	vector<bool, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<float, 5> in0 = vector<float, 5>(inputs[invocationNdx].in0);
	vector<bool, 5> out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<float, 5> in0;
};
struct Outputs
{
	vector<bool, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<float, 5> in0 = vector<float, 5>(inputs[invocationNdx].in0);
	vector<bool, 5> out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump float in0;
};
struct Outputs
{
	highp int out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	float in0 = float(inputs[invocationNdx].in0);
	int out0;

	out0 = floatBitsToInt(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp float in0;
};
struct Outputs
{
	highp int out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	float in0 = float(inputs[invocationNdx].in0);
	int out0;

	out0 = floatBitsToInt(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec2 in0;
};
struct Outputs
{
	highp ivec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	ivec2 out0;

	out0 = floatBitsToInt(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 in0;
};
struct Outputs
{
	highp ivec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	ivec2 out0;

	out0 = floatBitsToInt(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec3 in0;
};
struct Outputs
{
	highp ivec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec3 in0 = vec3(inputs[invocationNdx].in0);
	ivec3 out0;

	out0 = floatBitsToInt(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 in0;
};
struct Outputs
{
	highp ivec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec3 in0 = vec3(inputs[invocationNdx].in0);
	ivec3 out0;

	out0 = floatBitsToInt(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec4 in0;
};
struct Outputs
{
	highp ivec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec4 in0 = vec4(inputs[invocationNdx].in0);
	ivec4 out0;

	out0 = floatBitsToInt(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 in0;
};
struct Outputs
{
	highp ivec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec4 in0 = vec4(inputs[invocationNdx].in0);
	ivec4 out0;

	out0 = floatBitsToInt(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<float, 5> in0;
};
struct Outputs
{
	highp vector<int, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<float, 5> in0 = vector<float, 5>(inputs[invocationNdx].in0);
	vector<int, 5> out0;

	out0 = floatBitsToInt(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<float, 5> in0;
};
struct Outputs
{
	highp vector<int, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<float, 5> in0 = vector<float, 5>(inputs[invocationNdx].in0);
	vector<int, 5> out0;

	out0 = floatBitsToInt(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump float in0;
};
struct Outputs
{
	highp uint out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	float in0 = float(inputs[invocationNdx].in0);
	uint out0;

	out0 = floatBitsToUint(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp float in0;
};
struct Outputs
{
	highp uint out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	float in0 = float(inputs[invocationNdx].in0);
	uint out0;

	out0 = floatBitsToUint(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec2 in0;
};
struct Outputs
{
	highp uvec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	uvec2 out0;

	out0 = floatBitsToUint(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 in0;
};
struct Outputs
{
	highp uvec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	uvec2 out0;

	out0 = floatBitsToUint(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec3 in0;
};
struct Outputs
{
	highp uvec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec3 in0 = vec3(inputs[invocationNdx].in0);
	uvec3 out0;

	out0 = floatBitsToUint(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 in0;
};
struct Outputs
{
	highp uvec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec3 in0 = vec3(inputs[invocationNdx].in0);
	uvec3 out0;

	out0 = floatBitsToUint(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec4 in0;
};
struct Outputs
{
	highp uvec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec4 in0 = vec4(inputs[invocationNdx].in0);
	uvec4 out0;

	out0 = floatBitsToUint(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 in0;
};
struct Outputs
{
	highp uvec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec4 in0 = vec4(inputs[invocationNdx].in0);
	uvec4 out0;

	out0 = floatBitsToUint(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<float, 5> in0;
};
struct Outputs
{
	highp vector<uint, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<float, 5> in0 = vector<float, 5>(inputs[invocationNdx].in0);
	vector<uint, 5> out0;

	out0 = floatBitsToUint(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<float, 5> in0;
};
struct Outputs
{
	highp vector<uint, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<float, 5> in0 = vector<float, 5>(inputs[invocationNdx].in0);
	vector<uint, 5> out0;

	out0 = floatBitsToUint(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp int in0;
};
struct Outputs
{
	highp float out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	int in0 = int(inputs[invocationNdx].in0);
	float out0;

	out0 = intBitsToFloat(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec2 in0;
};
struct Outputs
{
	highp vec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec2 in0 = ivec2(inputs[invocationNdx].in0);
	vec2 out0;

	out0 = intBitsToFloat(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec3 in0;
};
struct Outputs
{
	highp vec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec3 in0 = ivec3(inputs[invocationNdx].in0);
	vec3 out0;

	out0 = intBitsToFloat(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec4 in0;
};
struct Outputs
{
	highp vec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	ivec4 in0 = ivec4(inputs[invocationNdx].in0);
	vec4 out0;

	out0 = intBitsToFloat(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<int, 5> in0;
};
struct Outputs
{
	highp vector<float, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<int, 5> in0 = vector<int, 5>(inputs[invocationNdx].in0);
	vector<float, 5> out0;

	out0 = intBitsToFloat(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint in0;
};
struct Outputs
{
	highp float out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint in0 = uint(inputs[invocationNdx].in0);
	float out0;

	out0 = uintBitsToFloat(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec2 in0;
};
struct Outputs
{
	highp vec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uvec2 in0 = uvec2(inputs[invocationNdx].in0);
	vec2 out0;

	out0 = uintBitsToFloat(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec3 in0;
};
struct Outputs
{
	highp vec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uvec3 in0 = uvec3(inputs[invocationNdx].in0);
	vec3 out0;

	out0 = uintBitsToFloat(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec4 in0;
};
struct Outputs
{
	highp vec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uvec4 in0 = uvec4(inputs[invocationNdx].in0);
	vec4 out0;

	out0 = uintBitsToFloat(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<uint, 5> in0;
};
struct Outputs
{
	highp vector<float, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<uint, 5> in0 = vector<uint, 5>(inputs[invocationNdx].in0);
	vector<float, 5> out0;

	out0 = uintBitsToFloat(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	double in0;
};
struct Outputs
{
	bool out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	double in0 = double(inputs[invocationNdx].in0);
	bool out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	dvec2 in0;
};
struct Outputs
{
	bvec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	dvec2 in0 = dvec2(inputs[invocationNdx].in0);
	bvec2 out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	dvec3 in0;
};
struct Outputs
{
	bvec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	dvec3 in0 = dvec3(inputs[invocationNdx].in0);
	bvec3 out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	dvec4 in0;
};
struct Outputs
{
	bvec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	dvec4 in0 = dvec4(inputs[invocationNdx].in0);
	bvec4 out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	vector<double, 5> in0;
};
struct Outputs
{
	vector<bool, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<double, 5> in0 = vector<double, 5>(inputs[invocationNdx].in0);
	vector<bool, 5> out0;

	out0 = isnan(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	double in0;
};
struct Outputs
{
	bool out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	double in0 = double(inputs[invocationNdx].in0);
	bool out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	dvec2 in0;
};
struct Outputs
{
	bvec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	dvec2 in0 = dvec2(inputs[invocationNdx].in0);
	bvec2 out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	dvec3 in0;
};
struct Outputs
{
	bvec3 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	dvec3 in0 = dvec3(inputs[invocationNdx].in0);
	bvec3 out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	dvec4 in0;
};
struct Outputs
{
	bvec4 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	dvec4 in0 = dvec4(inputs[invocationNdx].in0);
	bvec4 out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	vector<double, 5> in0;
};
struct Outputs
{
	vector<bool, 5> out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vector<double, 5> in0 = vector<double, 5>(inputs[invocationNdx].in0);
	vector<bool, 5> out0;

	out0 = isinf(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
const vec2 data[4] = vec2[](
    vec2(-1.0, -1.0),
    vec2(3.0, -1.0),
    vec2(-1.0, 3.0),
    vec2(3.0, 3.0)
);

layout(local_size_x = 1) in;

struct Inputs
{
	highp int in0;
};
struct Outputs
{
	highp vec2 out0;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	int in0 = int(inputs[invocationNdx].in0);
	vec2 out0;

	vec2 pos_xy = data[clamp(in0, 0, 3)];
	out0 = clamp(pos_xy, vec2(0.0, 0.0), vec2(1.0, 1.0));

	outputs[invocationNdx].out0 = out0;
}
