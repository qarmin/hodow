#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0) out vec4 looseVariable;
void main(void)
{
  gl_Position = inPosition;
  looseVariable = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in noperspective vec4 looseVariable;
void main(void)
{
  float result = 0.0;
  result = float(abs(looseVariable.x - -4.0) < 0.001) *
		   float(abs(looseVariable.y - -9.0) < 0.001) *
		   float(abs(looseVariable.z - 3.0) < 0.001) *
		   float(abs(looseVariable.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat vec4 looseVariable;
void main(void)
{
  float result = 0.0;
  result = float(abs(looseVariable.x - -4.0) < 0.001) *
		   float(abs(looseVariable.y - -9.0) < 0.001) *
		   float(abs(looseVariable.z - 3.0) < 0.001) *
		   float(abs(looseVariable.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0, component = 0 ) in vec4 looseVariable;
void main(void)
{
  float result = 0.0;
  result = float(abs(looseVariable.x - -4.0) < 0.001) *
		   float(abs(looseVariable.y - -9.0) < 0.001) *
		   float(abs(looseVariable.z - 3.0) < 0.001) *
		   float(abs(looseVariable.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0) out block {
  vec2 dummy;
layout(location = 1) vec4 variableInBlock;
} testBlock;
void main(void)
{
  gl_Position = inPosition;
  testBlock.variableInBlock = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
layout(location = 0) out vec4 fragColor;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1) noperspective vec4 variableInBlock;
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(abs(testBlock.variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock.variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock.variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock.variableInBlock.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1) flat vec4 variableInBlock;
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(abs(testBlock.variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock.variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock.variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock.variableInBlock.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1, component = 0 ) vec4 variableInBlock;
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(abs(testBlock.variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock.variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock.variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock.variableInBlock.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0) out struct {
  vec2 dummy;
  vec4 variableInStruct;
} testStruct;
void main(void)
{
  gl_Position = inPosition;
  testStruct.variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in noperspective struct {
  vec2 dummy;
  vec4 variableInStruct;
} testStruct;
void main(void)
{
  float result = 0.0;
  result = float(abs(testStruct.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStruct.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStruct.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStruct.variableInStruct.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat struct {
  vec2 dummy;
  vec4 variableInStruct;
} testStruct;
void main(void)
{
  float result = 0.0;
  result = float(abs(testStruct.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStruct.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStruct.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStruct.variableInStruct.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0) out struct {
  float dummy;
  vec4 variableInStruct;
} testStructArray[3];
void main(void)
{
  gl_Position = inPosition;
  testStructArray[2].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in noperspective struct {
  float dummy;
  vec4 variableInStruct;
} testStructArray[3];
void main(void)
{
  float result = 0.0;
  result = float(abs(testStructArray[2].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStructArray[2].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStructArray[2].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStructArray[2].variableInStruct.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat struct {
  float dummy;
  vec4 variableInStruct;
} testStructArray[3];
void main(void)
{
  float result = 0.0;
  result = float(abs(testStructArray[2].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStructArray[2].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStructArray[2].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStructArray[2].variableInStruct.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
struct TestStruct {
  vec2 dummy;
  vec4 variableInStruct;
};
layout(location = 0) out block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock;
void main(void)
{
  gl_Position = inPosition;
  testBlock.structInBlock.variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
layout(location = 0) out vec4 fragColor;
struct TestStruct {
  vec2 dummy;
  vec4 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  noperspective TestStruct structInBlock;
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(abs(testBlock.structInBlock.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock.structInBlock.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock.structInBlock.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock.structInBlock.variableInStruct.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
struct TestStruct {
  vec2 dummy;
  vec4 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  flat TestStruct structInBlock;
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(abs(testBlock.structInBlock.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock.structInBlock.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock.structInBlock.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock.structInBlock.variableInStruct.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
struct TestStruct {
  vec4 dummy;
  vec4 variableInStruct;
};
layout(location = 0) out block {
  TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  gl_Position = inPosition;
  testBlock.structArrayInBlock[1].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
layout(location = 0) out vec4 fragColor;
struct TestStruct {
  vec4 dummy;
  vec4 variableInStruct;
};layout(location = 0) in block {
  noperspective TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(abs(testBlock.structArrayInBlock[1].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock.structArrayInBlock[1].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock.structArrayInBlock[1].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock.structArrayInBlock[1].variableInStruct.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) out vec4 fragColor;
struct TestStruct {
  vec4 dummy;
  vec4 variableInStruct;
};layout(location = 0) in block {
  flat TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(abs(testBlock.structArrayInBlock[1].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock.structArrayInBlock[1].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock.structArrayInBlock[1].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock.structArrayInBlock[1].variableInStruct.w - 7.0) < 0.001);
  fragColor = vec4(result);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in noperspective vec4 looseVariable[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
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

layout(location = 0) in flat vec4 looseVariable[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0, component = 0 ) in vec4 looseVariable[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

in block {
layout(location = 0) vec2 dummy;
layout(location = 1) noperspective vec4 variableInBlock;
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

in block {
layout(location = 0) vec2 dummy;
layout(location = 1) flat vec4 variableInBlock;
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

in block {
layout(location = 0) vec2 dummy;
layout(location = 1, component = 0 ) vec4 variableInBlock;
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in noperspective struct {
  vec2 dummy;
  vec4 variableInStruct;
} testStruct[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(testStruct[0].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.w - 7.0) < 0.001);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in flat struct {
  vec2 dummy;
  vec4 variableInStruct;
} testStruct[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(testStruct[0].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.w - 7.0) < 0.001);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in noperspective struct {
  float dummy;
  vec4 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(testStructArray[0][2].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.w - 7.0) < 0.001);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in flat struct {
  float dummy;
  vec4 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(testStructArray[0][2].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.w - 7.0) < 0.001);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec2 dummy;
  vec4 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  noperspective TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(testBlock[0].structInBlock.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.w - 7.0) < 0.001);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec2 dummy;
  vec4 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  flat TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(testBlock[0].structInBlock.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.w - 7.0) < 0.001);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec4 dummy;
  vec4 variableInStruct;
};layout(location = 0) in block {
  noperspective TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.w - 7.0) < 0.001);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec4 dummy;
  vec4 variableInStruct;
};layout(location = 0) in block {
  flat TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.w - 7.0) < 0.001);
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
layout(location = 0) out vec4 looseVariable;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  looseVariable = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) out block {
  vec2 dummy;
layout(location = 1) vec4 variableInBlock;
} testBlock;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testBlock.variableInBlock = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) out struct {
  vec2 dummy;
  vec4 variableInStruct;
} testStruct;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testStruct.variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) out struct {
  float dummy;
  vec4 variableInStruct;
} testStructArray[3];
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testStructArray[2].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec2 dummy;
  vec4 variableInStruct;
};
layout(location = 0) out block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testBlock.structInBlock.variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec4 dummy;
  vec4 variableInStruct;
};
layout(location = 0) out block {
  TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testBlock.structArrayInBlock[1].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) out vec4 looseVariable[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  looseVariable[gl_InvocationID] = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in noperspective vec4 looseVariable[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in flat vec4 looseVariable[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0, component = 0 ) in vec4 looseVariable[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) out block {
  vec2 dummy;
layout(location = 1) vec4 variableInBlock;
} testBlock[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  testBlock[gl_InvocationID].variableInBlock = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1) noperspective vec4 variableInBlock;
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1) flat vec4 variableInBlock;
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1, component = 0 ) vec4 variableInBlock;
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) out struct {
  vec2 dummy;
  vec4 variableInStruct;
} testStruct[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  testStruct[gl_InvocationID].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in noperspective struct {
  vec2 dummy;
  vec4 variableInStruct;
} testStruct[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(testStruct[0].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in flat struct {
  vec2 dummy;
  vec4 variableInStruct;
} testStruct[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(testStruct[0].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) out struct {
  float dummy;
  vec4 variableInStruct;
} testStructArray[][3];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  testStructArray[gl_InvocationID][2].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in noperspective struct {
  float dummy;
  vec4 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(testStructArray[0][2].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in flat struct {
  float dummy;
  vec4 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(testStructArray[0][2].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec2 dummy;
  vec4 variableInStruct;
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
  testBlock[gl_InvocationID].structInBlock.variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec2 dummy;
  vec4 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  noperspective TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(testBlock[0].structInBlock.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec2 dummy;
  vec4 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  flat TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(testBlock[0].structInBlock.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec4 dummy;
  vec4 variableInStruct;
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
  testBlock[gl_InvocationID].structArrayInBlock[1].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec4 dummy;
  vec4 variableInStruct;
};layout(location = 0) in block {
  noperspective TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec4 dummy;
  vec4 variableInStruct;
};layout(location = 0) in block {
  flat TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.w - 7.0) < 0.001);
  outResult = result;
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in noperspective vec4 looseVariable[];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in flat vec4 looseVariable[];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0, component = 0 ) in vec4 looseVariable[];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(looseVariable[0].x - -4.0) < 0.001) *
		   float(abs(looseVariable[0].y - -9.0) < 0.001) *
		   float(abs(looseVariable[0].z - 3.0) < 0.001) *
		   float(abs(looseVariable[0].w - 7.0) < 0.001);
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
layout(location = 1) noperspective vec4 variableInBlock;
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
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
layout(location = 1) flat vec4 variableInBlock;
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
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
layout(location = 1, component = 0 ) vec4 variableInBlock;
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].variableInBlock.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].variableInBlock.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in noperspective struct {
  vec2 dummy;
  vec4 variableInStruct;
} testStruct[];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(testStruct[0].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testStruct[0].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testStruct[0].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in flat struct {
  vec2 dummy;
  vec4 variableInStruct;
} testStruct[];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(testStruct[0].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testStruct[0].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testStruct[0].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStruct[0].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in noperspective struct {
  float dummy;
  vec4 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(testStructArray[0][2].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testStructArray[0][2].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testStructArray[0][2].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in flat struct {
  float dummy;
  vec4 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(testStructArray[0][2].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testStructArray[0][2].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testStructArray[0][2].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testStructArray[0][2].variableInStruct.w - 7.0) < 0.001);
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
  vec4 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  noperspective TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(testBlock[0].structInBlock.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].structInBlock.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].structInBlock.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.w - 7.0) < 0.001);
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
  vec4 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  flat TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(testBlock[0].structInBlock.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].structInBlock.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].structInBlock.variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structInBlock.variableInStruct.w - 7.0) < 0.001);
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
  vec4 variableInStruct;
};layout(location = 0) in block {
  noperspective TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.w - 7.0) < 0.001);
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
  vec4 variableInStruct;
};layout(location = 0) in block {
  flat TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.x - -4.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.y - -9.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.z - 3.0) < 0.001) *
		   float(abs(testBlock[0].structArrayInBlock[1].variableInStruct.w - 7.0) < 0.001);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) out vec4 looseVariable;
void main(void)
{
  looseVariable = vec4(-4.0, -9.0, 3.0, 7.0);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  looseVariable = vec4(-4.0, -9.0, 3.0, 7.0);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  looseVariable = vec4(-4.0, -9.0, 3.0, 7.0);
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
layout(location = 1) vec4 variableInBlock;
} testBlock;
void main(void)
{
  testBlock.variableInBlock = vec4(-4.0, -9.0, 3.0, 7.0);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.variableInBlock = vec4(-4.0, -9.0, 3.0, 7.0);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.variableInBlock = vec4(-4.0, -9.0, 3.0, 7.0);
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
  vec4 variableInStruct;
} testStruct;
void main(void)
{
  testStruct.variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testStruct.variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testStruct.variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
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
  vec4 variableInStruct;
} testStructArray[3];
void main(void)
{
  testStructArray[2].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testStructArray[2].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testStructArray[2].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
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
  vec4 variableInStruct;
};
layout(location = 0) out block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock;
void main(void)
{
  testBlock.structInBlock.variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.structInBlock.variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.structInBlock.variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
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
  vec4 variableInStruct;
};
layout(location = 0) out block {
  TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  testBlock.structArrayInBlock[1].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.structArrayInBlock[1].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.structArrayInBlock[1].variableInStruct = vec4(-4.0, -9.0, 3.0, 7.0);
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
