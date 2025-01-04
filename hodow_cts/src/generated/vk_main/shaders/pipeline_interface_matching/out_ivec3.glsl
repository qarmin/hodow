#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0) out ivec3 looseVariable;
void main(void)
{
  gl_Position = inPosition;
  looseVariable = ivec3(-5, 10, 15);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat ivec3 looseVariable;
void main(void)
{
  float result = 0.0;
  result = float(looseVariable.x == -5) *
		   float(looseVariable.y == 10) *
		   float(looseVariable.z == 15);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat ivec2 looseVariable;
void main(void)
{
  float result = 0.0;
  result = float(looseVariable.x == -5) *
		   float(looseVariable.y == 10);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0) out block {
  vec2 dummy;
layout(location = 1) ivec3 variableInBlock;
} testBlock;
void main(void)
{
  gl_Position = inPosition;
  testBlock.variableInBlock = ivec3(-5, 10, 15);
}
#version 450
layout(location = 0) out vec4 fragColor;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1) flat ivec3 variableInBlock;
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(testBlock.variableInBlock.x == -5) *
		   float(testBlock.variableInBlock.y == 10) *
		   float(testBlock.variableInBlock.z == 15);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1) flat ivec2 variableInBlock;
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(testBlock.variableInBlock.x == -5) *
		   float(testBlock.variableInBlock.y == 10);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0) out struct {
  vec2 dummy;
  ivec3 variableInStruct;
} testStruct;
void main(void)
{
  gl_Position = inPosition;
  testStruct.variableInStruct = ivec3(-5, 10, 15);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat struct {
  vec2 dummy;
  ivec3 variableInStruct;
} testStruct;
void main(void)
{
  float result = 0.0;
  result = float(testStruct.variableInStruct.x == -5) *
		   float(testStruct.variableInStruct.y == 10) *
		   float(testStruct.variableInStruct.z == 15);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat struct {
  vec2 dummy;
  ivec2 variableInStruct;
} testStruct;
void main(void)
{
  float result = 0.0;
  result = float(testStruct.variableInStruct.x == -5) *
		   float(testStruct.variableInStruct.y == 10);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0) out struct {
  float dummy;
  ivec3 variableInStruct;
} testStructArray[3];
void main(void)
{
  gl_Position = inPosition;
  testStructArray[2].variableInStruct = ivec3(-5, 10, 15);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat struct {
  float dummy;
  ivec3 variableInStruct;
} testStructArray[3];
void main(void)
{
  float result = 0.0;
  result = float(testStructArray[2].variableInStruct.x == -5) *
		   float(testStructArray[2].variableInStruct.y == 10) *
		   float(testStructArray[2].variableInStruct.z == 15);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat struct {
  float dummy;
  ivec2 variableInStruct;
} testStructArray[3];
void main(void)
{
  float result = 0.0;
  result = float(testStructArray[2].variableInStruct.x == -5) *
		   float(testStructArray[2].variableInStruct.y == 10);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
struct TestStruct {
  vec2 dummy;
  ivec3 variableInStruct;
};
layout(location = 0) out block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock;
void main(void)
{
  gl_Position = inPosition;
  testBlock.structInBlock.variableInStruct = ivec3(-5, 10, 15);
}
#version 450
layout(location = 0) out vec4 fragColor;
struct TestStruct {
  vec2 dummy;
  ivec3 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  flat TestStruct structInBlock;
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(testBlock.structInBlock.variableInStruct.x == -5) *
		   float(testBlock.structInBlock.variableInStruct.y == 10) *
		   float(testBlock.structInBlock.variableInStruct.z == 15);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
struct TestStruct {
  vec2 dummy;
  ivec2 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  flat TestStruct structInBlock;
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(testBlock.structInBlock.variableInStruct.x == -5) *
		   float(testBlock.structInBlock.variableInStruct.y == 10);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
struct TestStruct {
  vec4 dummy;
  ivec3 variableInStruct;
};
layout(location = 0) out block {
  TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  gl_Position = inPosition;
  testBlock.structArrayInBlock[1].variableInStruct = ivec3(-5, 10, 15);
}
#version 450
layout(location = 0) out vec4 fragColor;
struct TestStruct {
  vec4 dummy;
  ivec3 variableInStruct;
};layout(location = 0) in block {
  flat TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(testBlock.structArrayInBlock[1].variableInStruct.x == -5) *
		   float(testBlock.structArrayInBlock[1].variableInStruct.y == 10) *
		   float(testBlock.structArrayInBlock[1].variableInStruct.z == 15);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
struct TestStruct {
  vec4 dummy;
  ivec2 variableInStruct;
};layout(location = 0) in block {
  flat TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(testBlock.structArrayInBlock[1].variableInStruct.x == -5) *
		   float(testBlock.structArrayInBlock[1].variableInStruct.y == 10);
  fragColor = vec4(result);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in ivec3 looseVariable[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(looseVariable[0].x == -5) *
		   float(looseVariable[0].y == 10) *
		   float(looseVariable[0].z == 15);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in float inResult[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  outResult = inResult[0];
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat float result;
void main(void)
{
  fragColor = vec4(result);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in ivec2 looseVariable[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(looseVariable[0].x == -5) *
		   float(looseVariable[0].y == 10);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

in block {
layout(location = 0) vec2 dummy;
layout(location = 1) ivec3 variableInBlock;
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testBlock[0].variableInBlock.x == -5) *
		   float(testBlock[0].variableInBlock.y == 10) *
		   float(testBlock[0].variableInBlock.z == 15);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

in block {
layout(location = 0) vec2 dummy;
layout(location = 1) ivec2 variableInBlock;
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testBlock[0].variableInBlock.x == -5) *
		   float(testBlock[0].variableInBlock.y == 10);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in struct {
  vec2 dummy;
  ivec3 variableInStruct;
} testStruct[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testStruct[0].variableInStruct.x == -5) *
		   float(testStruct[0].variableInStruct.y == 10) *
		   float(testStruct[0].variableInStruct.z == 15);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in struct {
  vec2 dummy;
  ivec2 variableInStruct;
} testStruct[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testStruct[0].variableInStruct.x == -5) *
		   float(testStruct[0].variableInStruct.y == 10);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in struct {
  float dummy;
  ivec3 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testStructArray[0][2].variableInStruct.x == -5) *
		   float(testStructArray[0][2].variableInStruct.y == 10) *
		   float(testStructArray[0][2].variableInStruct.z == 15);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in struct {
  float dummy;
  ivec2 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testStructArray[0][2].variableInStruct.x == -5) *
		   float(testStructArray[0][2].variableInStruct.y == 10);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec2 dummy;
  ivec3 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testBlock[0].structInBlock.variableInStruct.x == -5) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 10) *
		   float(testBlock[0].structInBlock.variableInStruct.z == 15);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec2 dummy;
  ivec2 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testBlock[0].structInBlock.variableInStruct.x == -5) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 10);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec4 dummy;
  ivec3 variableInStruct;
};layout(location = 0) in block {
  TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == -5) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 10) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.z == 15);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec4 dummy;
  ivec2 variableInStruct;
};layout(location = 0) in block {
  TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == -5) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 10);
  outResult[gl_InvocationID] = result;
}
#version 450
layout(location = 0) in vec4 inPosition;
void main(void)
{
  gl_Position = inPosition;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) out ivec3 looseVariable;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  looseVariable = ivec3(-5, 10, 15);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) out block {
  vec2 dummy;
layout(location = 1) ivec3 variableInBlock;
} testBlock;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testBlock.variableInBlock = ivec3(-5, 10, 15);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) out struct {
  vec2 dummy;
  ivec3 variableInStruct;
} testStruct;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testStruct.variableInStruct = ivec3(-5, 10, 15);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) out struct {
  float dummy;
  ivec3 variableInStruct;
} testStructArray[3];
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testStructArray[2].variableInStruct = ivec3(-5, 10, 15);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec2 dummy;
  ivec3 variableInStruct;
};
layout(location = 0) out block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testBlock.structInBlock.variableInStruct = ivec3(-5, 10, 15);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec4 dummy;
  ivec3 variableInStruct;
};
layout(location = 0) out block {
  TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testBlock.structArrayInBlock[1].variableInStruct = ivec3(-5, 10, 15);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) out ivec3 looseVariable[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  looseVariable[gl_InvocationID] = ivec3(-5, 10, 15);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in ivec3 looseVariable[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(looseVariable[0].x == -5) *
		   float(looseVariable[0].y == 10) *
		   float(looseVariable[0].z == 15);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in ivec2 looseVariable[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(looseVariable[0].x == -5) *
		   float(looseVariable[0].y == 10);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) out block {
  vec2 dummy;
layout(location = 1) ivec3 variableInBlock;
} testBlock[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  testBlock[gl_InvocationID].variableInBlock = ivec3(-5, 10, 15);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1) ivec3 variableInBlock;
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testBlock[0].variableInBlock.x == -5) *
		   float(testBlock[0].variableInBlock.y == 10) *
		   float(testBlock[0].variableInBlock.z == 15);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1) ivec2 variableInBlock;
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testBlock[0].variableInBlock.x == -5) *
		   float(testBlock[0].variableInBlock.y == 10);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) out struct {
  vec2 dummy;
  ivec3 variableInStruct;
} testStruct[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  testStruct[gl_InvocationID].variableInStruct = ivec3(-5, 10, 15);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in struct {
  vec2 dummy;
  ivec3 variableInStruct;
} testStruct[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testStruct[0].variableInStruct.x == -5) *
		   float(testStruct[0].variableInStruct.y == 10) *
		   float(testStruct[0].variableInStruct.z == 15);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in struct {
  vec2 dummy;
  ivec2 variableInStruct;
} testStruct[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testStruct[0].variableInStruct.x == -5) *
		   float(testStruct[0].variableInStruct.y == 10);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) out struct {
  float dummy;
  ivec3 variableInStruct;
} testStructArray[][3];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  testStructArray[gl_InvocationID][2].variableInStruct = ivec3(-5, 10, 15);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in struct {
  float dummy;
  ivec3 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testStructArray[0][2].variableInStruct.x == -5) *
		   float(testStructArray[0][2].variableInStruct.y == 10) *
		   float(testStructArray[0][2].variableInStruct.z == 15);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in struct {
  float dummy;
  ivec2 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testStructArray[0][2].variableInStruct.x == -5) *
		   float(testStructArray[0][2].variableInStruct.y == 10);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec2 dummy;
  ivec3 variableInStruct;
};
layout(location = 0) out block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  testBlock[gl_InvocationID].structInBlock.variableInStruct = ivec3(-5, 10, 15);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec2 dummy;
  ivec3 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testBlock[0].structInBlock.variableInStruct.x == -5) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 10) *
		   float(testBlock[0].structInBlock.variableInStruct.z == 15);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec2 dummy;
  ivec2 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testBlock[0].structInBlock.variableInStruct.x == -5) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 10);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec4 dummy;
  ivec3 variableInStruct;
};
layout(location = 0) out block {
  TestStruct structArrayInBlock[3];
} testBlock[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  testBlock[gl_InvocationID].structArrayInBlock[1].variableInStruct = ivec3(-5, 10, 15);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec4 dummy;
  ivec3 variableInStruct;
};layout(location = 0) in block {
  TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == -5) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 10) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.z == 15);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec4 dummy;
  ivec2 variableInStruct;
};layout(location = 0) in block {
  TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == -5) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 10);
  outResult = result;
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in ivec3 looseVariable[];
layout(location = 0) out float result;
void main(void)
{
  result = float(looseVariable[0].x == -5) *
		   float(looseVariable[0].y == 10) *
		   float(looseVariable[0].z == 15);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(looseVariable[0].x == -5) *
		   float(looseVariable[0].y == 10) *
		   float(looseVariable[0].z == 15);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(looseVariable[0].x == -5) *
		   float(looseVariable[0].y == 10) *
		   float(looseVariable[0].z == 15);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in ivec2 looseVariable[];
layout(location = 0) out float result;
void main(void)
{
  result = float(looseVariable[0].x == -5) *
		   float(looseVariable[0].y == 10);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(looseVariable[0].x == -5) *
		   float(looseVariable[0].y == 10);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(looseVariable[0].x == -5) *
		   float(looseVariable[0].y == 10);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1) ivec3 variableInBlock;
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(testBlock[0].variableInBlock.x == -5) *
		   float(testBlock[0].variableInBlock.y == 10) *
		   float(testBlock[0].variableInBlock.z == 15);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].variableInBlock.x == -5) *
		   float(testBlock[0].variableInBlock.y == 10) *
		   float(testBlock[0].variableInBlock.z == 15);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].variableInBlock.x == -5) *
		   float(testBlock[0].variableInBlock.y == 10) *
		   float(testBlock[0].variableInBlock.z == 15);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1) ivec2 variableInBlock;
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(testBlock[0].variableInBlock.x == -5) *
		   float(testBlock[0].variableInBlock.y == 10);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].variableInBlock.x == -5) *
		   float(testBlock[0].variableInBlock.y == 10);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].variableInBlock.x == -5) *
		   float(testBlock[0].variableInBlock.y == 10);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in struct {
  vec2 dummy;
  ivec3 variableInStruct;
} testStruct[];
layout(location = 0) out float result;
void main(void)
{
  result = float(testStruct[0].variableInStruct.x == -5) *
		   float(testStruct[0].variableInStruct.y == 10) *
		   float(testStruct[0].variableInStruct.z == 15);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testStruct[0].variableInStruct.x == -5) *
		   float(testStruct[0].variableInStruct.y == 10) *
		   float(testStruct[0].variableInStruct.z == 15);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testStruct[0].variableInStruct.x == -5) *
		   float(testStruct[0].variableInStruct.y == 10) *
		   float(testStruct[0].variableInStruct.z == 15);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in struct {
  vec2 dummy;
  ivec2 variableInStruct;
} testStruct[];
layout(location = 0) out float result;
void main(void)
{
  result = float(testStruct[0].variableInStruct.x == -5) *
		   float(testStruct[0].variableInStruct.y == 10);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testStruct[0].variableInStruct.x == -5) *
		   float(testStruct[0].variableInStruct.y == 10);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testStruct[0].variableInStruct.x == -5) *
		   float(testStruct[0].variableInStruct.y == 10);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in struct {
  float dummy;
  ivec3 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float result;
void main(void)
{
  result = float(testStructArray[0][2].variableInStruct.x == -5) *
		   float(testStructArray[0][2].variableInStruct.y == 10) *
		   float(testStructArray[0][2].variableInStruct.z == 15);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testStructArray[0][2].variableInStruct.x == -5) *
		   float(testStructArray[0][2].variableInStruct.y == 10) *
		   float(testStructArray[0][2].variableInStruct.z == 15);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testStructArray[0][2].variableInStruct.x == -5) *
		   float(testStructArray[0][2].variableInStruct.y == 10) *
		   float(testStructArray[0][2].variableInStruct.z == 15);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in struct {
  float dummy;
  ivec2 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float result;
void main(void)
{
  result = float(testStructArray[0][2].variableInStruct.x == -5) *
		   float(testStructArray[0][2].variableInStruct.y == 10);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testStructArray[0][2].variableInStruct.x == -5) *
		   float(testStructArray[0][2].variableInStruct.y == 10);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testStructArray[0][2].variableInStruct.x == -5) *
		   float(testStructArray[0][2].variableInStruct.y == 10);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
struct TestStruct {
  vec2 dummy;
  ivec3 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(testBlock[0].structInBlock.variableInStruct.x == -5) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 10) *
		   float(testBlock[0].structInBlock.variableInStruct.z == 15);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].structInBlock.variableInStruct.x == -5) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 10) *
		   float(testBlock[0].structInBlock.variableInStruct.z == 15);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].structInBlock.variableInStruct.x == -5) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 10) *
		   float(testBlock[0].structInBlock.variableInStruct.z == 15);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
struct TestStruct {
  vec2 dummy;
  ivec2 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(testBlock[0].structInBlock.variableInStruct.x == -5) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 10);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].structInBlock.variableInStruct.x == -5) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 10);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].structInBlock.variableInStruct.x == -5) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 10);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
struct TestStruct {
  vec4 dummy;
  ivec3 variableInStruct;
};layout(location = 0) in block {
  TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == -5) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 10) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.z == 15);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == -5) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 10) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.z == 15);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == -5) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 10) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.z == 15);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
struct TestStruct {
  vec4 dummy;
  ivec2 variableInStruct;
};layout(location = 0) in block {
  TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == -5) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 10);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == -5) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 10);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == -5) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 10);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) out ivec3 looseVariable;
void main(void)
{
  looseVariable = ivec3(-5, 10, 15);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  looseVariable = ivec3(-5, 10, 15);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  looseVariable = ivec3(-5, 10, 15);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) out block {
  vec2 dummy;
layout(location = 1) ivec3 variableInBlock;
} testBlock;
void main(void)
{
  testBlock.variableInBlock = ivec3(-5, 10, 15);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.variableInBlock = ivec3(-5, 10, 15);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.variableInBlock = ivec3(-5, 10, 15);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) out struct {
  vec2 dummy;
  ivec3 variableInStruct;
} testStruct;
void main(void)
{
  testStruct.variableInStruct = ivec3(-5, 10, 15);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testStruct.variableInStruct = ivec3(-5, 10, 15);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testStruct.variableInStruct = ivec3(-5, 10, 15);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) out struct {
  float dummy;
  ivec3 variableInStruct;
} testStructArray[3];
void main(void)
{
  testStructArray[2].variableInStruct = ivec3(-5, 10, 15);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testStructArray[2].variableInStruct = ivec3(-5, 10, 15);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testStructArray[2].variableInStruct = ivec3(-5, 10, 15);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
struct TestStruct {
  vec2 dummy;
  ivec3 variableInStruct;
};
layout(location = 0) out block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock;
void main(void)
{
  testBlock.structInBlock.variableInStruct = ivec3(-5, 10, 15);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.structInBlock.variableInStruct = ivec3(-5, 10, 15);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.structInBlock.variableInStruct = ivec3(-5, 10, 15);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
struct TestStruct {
  vec4 dummy;
  ivec3 variableInStruct;
};
layout(location = 0) out block {
  TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  testBlock.structArrayInBlock[1].variableInStruct = ivec3(-5, 10, 15);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.structArrayInBlock[1].variableInStruct = ivec3(-5, 10, 15);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.structArrayInBlock[1].variableInStruct = ivec3(-5, 10, 15);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in float inResult[];
layout(location = 0) out float outResult;
void main(void)
{
  outResult = inResult[0];
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  outResult = inResult[0];
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  outResult = inResult[0];
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
}
