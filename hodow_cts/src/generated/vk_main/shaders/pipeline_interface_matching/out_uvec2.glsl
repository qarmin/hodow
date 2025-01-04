#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0) out uvec2 looseVariable;
void main(void)
{
  gl_Position = inPosition;
  looseVariable = uvec2(2, 8);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat uvec2 looseVariable;
void main(void)
{
  float result = 0.0;
  result = float(looseVariable.x == 2) *
		   float(looseVariable.y == 8);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0) out block {
  vec2 dummy;
layout(location = 1) uvec2 variableInBlock;
} testBlock;
void main(void)
{
  gl_Position = inPosition;
  testBlock.variableInBlock = uvec2(2, 8);
}
#version 450
layout(location = 0) out vec4 fragColor;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1) flat uvec2 variableInBlock;
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(testBlock.variableInBlock.x == 2) *
		   float(testBlock.variableInBlock.y == 8);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0) out struct {
  vec2 dummy;
  uvec2 variableInStruct;
} testStruct;
void main(void)
{
  gl_Position = inPosition;
  testStruct.variableInStruct = uvec2(2, 8);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat struct {
  vec2 dummy;
  uvec2 variableInStruct;
} testStruct;
void main(void)
{
  float result = 0.0;
  result = float(testStruct.variableInStruct.x == 2) *
		   float(testStruct.variableInStruct.y == 8);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0) out struct {
  float dummy;
  uvec2 variableInStruct;
} testStructArray[3];
void main(void)
{
  gl_Position = inPosition;
  testStructArray[2].variableInStruct = uvec2(2, 8);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in flat struct {
  float dummy;
  uvec2 variableInStruct;
} testStructArray[3];
void main(void)
{
  float result = 0.0;
  result = float(testStructArray[2].variableInStruct.x == 2) *
		   float(testStructArray[2].variableInStruct.y == 8);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
struct TestStruct {
  vec2 dummy;
  uvec2 variableInStruct;
};
layout(location = 0) out block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock;
void main(void)
{
  gl_Position = inPosition;
  testBlock.structInBlock.variableInStruct = uvec2(2, 8);
}
#version 450
layout(location = 0) out vec4 fragColor;
struct TestStruct {
  vec2 dummy;
  uvec2 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  flat TestStruct structInBlock;
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(testBlock.structInBlock.variableInStruct.x == 2) *
		   float(testBlock.structInBlock.variableInStruct.y == 8);
  fragColor = vec4(result);
}
#version 450
layout(location = 0) in vec4 inPosition;
struct TestStruct {
  vec4 dummy;
  uvec2 variableInStruct;
};
layout(location = 0) out block {
  TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  gl_Position = inPosition;
  testBlock.structArrayInBlock[1].variableInStruct = uvec2(2, 8);
}
#version 450
layout(location = 0) out vec4 fragColor;
struct TestStruct {
  vec4 dummy;
  uvec2 variableInStruct;
};layout(location = 0) in block {
  flat TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  float result = 0.0;
  result = float(testBlock.structArrayInBlock[1].variableInStruct.x == 2) *
		   float(testBlock.structArrayInBlock[1].variableInStruct.y == 8);
  fragColor = vec4(result);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in uvec2 looseVariable[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(looseVariable[0].x == 2) *
		   float(looseVariable[0].y == 8);
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

in block {
layout(location = 0) vec2 dummy;
layout(location = 1) uvec2 variableInBlock;
} testBlock[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testBlock[0].variableInBlock.x == 2) *
		   float(testBlock[0].variableInBlock.y == 8);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in struct {
  vec2 dummy;
  uvec2 variableInStruct;
} testStruct[];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testStruct[0].variableInStruct.x == 2) *
		   float(testStruct[0].variableInStruct.y == 8);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in struct {
  float dummy;
  uvec2 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float outResult[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  float result;
  result = float(testStructArray[0][2].variableInStruct.x == 2) *
		   float(testStructArray[0][2].variableInStruct.y == 8);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec2 dummy;
  uvec2 variableInStruct;
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
  result = float(testBlock[0].structInBlock.variableInStruct.x == 2) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 8);
  outResult[gl_InvocationID] = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec4 dummy;
  uvec2 variableInStruct;
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
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == 2) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 8);
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
layout(location = 0) out uvec2 looseVariable;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  looseVariable = uvec2(2, 8);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) out block {
  vec2 dummy;
layout(location = 1) uvec2 variableInBlock;
} testBlock;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testBlock.variableInBlock = uvec2(2, 8);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) out struct {
  vec2 dummy;
  uvec2 variableInStruct;
} testStruct;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testStruct.variableInStruct = uvec2(2, 8);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) out struct {
  float dummy;
  uvec2 variableInStruct;
} testStructArray[3];
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testStructArray[2].variableInStruct = uvec2(2, 8);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec2 dummy;
  uvec2 variableInStruct;
};
layout(location = 0) out block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testBlock.structInBlock.variableInStruct = uvec2(2, 8);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec4 dummy;
  uvec2 variableInStruct;
};
layout(location = 0) out block {
  TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testBlock.structArrayInBlock[1].variableInStruct = uvec2(2, 8);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) out uvec2 looseVariable[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  looseVariable[gl_InvocationID] = uvec2(2, 8);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in uvec2 looseVariable[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(looseVariable[0].x == 2) *
		   float(looseVariable[0].y == 8);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) out block {
  vec2 dummy;
layout(location = 1) uvec2 variableInBlock;
} testBlock[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  testBlock[gl_InvocationID].variableInBlock = uvec2(2, 8);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
in block {
layout(location = 0) vec2 dummy;
layout(location = 1) uvec2 variableInBlock;
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testBlock[0].variableInBlock.x == 2) *
		   float(testBlock[0].variableInBlock.y == 8);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) out struct {
  vec2 dummy;
  uvec2 variableInStruct;
} testStruct[];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  testStruct[gl_InvocationID].variableInStruct = uvec2(2, 8);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in struct {
  vec2 dummy;
  uvec2 variableInStruct;
} testStruct[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testStruct[0].variableInStruct.x == 2) *
		   float(testStruct[0].variableInStruct.y == 8);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) out struct {
  float dummy;
  uvec2 variableInStruct;
} testStructArray[][3];
void main(void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  testStructArray[gl_InvocationID][2].variableInStruct = uvec2(2, 8);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
layout(location = 0) in struct {
  float dummy;
  uvec2 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testStructArray[0][2].variableInStruct.x == 2) *
		   float(testStructArray[0][2].variableInStruct.y == 8);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec2 dummy;
  uvec2 variableInStruct;
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
  testBlock[gl_InvocationID].structInBlock.variableInStruct = uvec2(2, 8);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec2 dummy;
  uvec2 variableInStruct;
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
  result = float(testBlock[0].structInBlock.variableInStruct.x == 2) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 8);
  outResult = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

struct TestStruct {
  vec4 dummy;
  uvec2 variableInStruct;
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
  testBlock[gl_InvocationID].structArrayInBlock[1].variableInStruct = uvec2(2, 8);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;
struct TestStruct {
  vec4 dummy;
  uvec2 variableInStruct;
};layout(location = 0) in block {
  TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float outResult;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  float result;
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == 2) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 8);
  outResult = result;
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in uvec2 looseVariable[];
layout(location = 0) out float result;
void main(void)
{
  result = float(looseVariable[0].x == 2) *
		   float(looseVariable[0].y == 8);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(looseVariable[0].x == 2) *
		   float(looseVariable[0].y == 8);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(looseVariable[0].x == 2) *
		   float(looseVariable[0].y == 8);
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
layout(location = 1) uvec2 variableInBlock;
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(testBlock[0].variableInBlock.x == 2) *
		   float(testBlock[0].variableInBlock.y == 8);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].variableInBlock.x == 2) *
		   float(testBlock[0].variableInBlock.y == 8);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].variableInBlock.x == 2) *
		   float(testBlock[0].variableInBlock.y == 8);
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
  uvec2 variableInStruct;
} testStruct[];
layout(location = 0) out float result;
void main(void)
{
  result = float(testStruct[0].variableInStruct.x == 2) *
		   float(testStruct[0].variableInStruct.y == 8);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testStruct[0].variableInStruct.x == 2) *
		   float(testStruct[0].variableInStruct.y == 8);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testStruct[0].variableInStruct.x == 2) *
		   float(testStruct[0].variableInStruct.y == 8);
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
  uvec2 variableInStruct;
} testStructArray[][3];
layout(location = 0) out float result;
void main(void)
{
  result = float(testStructArray[0][2].variableInStruct.x == 2) *
		   float(testStructArray[0][2].variableInStruct.y == 8);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testStructArray[0][2].variableInStruct.x == 2) *
		   float(testStructArray[0][2].variableInStruct.y == 8);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testStructArray[0][2].variableInStruct.x == 2) *
		   float(testStructArray[0][2].variableInStruct.y == 8);
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
  uvec2 variableInStruct;
};
layout(location = 0) in block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(testBlock[0].structInBlock.variableInStruct.x == 2) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 8);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].structInBlock.variableInStruct.x == 2) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 8);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].structInBlock.variableInStruct.x == 2) *
		   float(testBlock[0].structInBlock.variableInStruct.y == 8);
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
  uvec2 variableInStruct;
};layout(location = 0) in block {
  TestStruct structArrayInBlock[3];
} testBlock[];
layout(location = 0) out float result;
void main(void)
{
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == 2) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 8);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == 2) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 8);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  result = float(testBlock[0].structArrayInBlock[1].variableInStruct.x == 2) *
		   float(testBlock[0].structArrayInBlock[1].variableInStruct.y == 8);
  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) out uvec2 looseVariable;
void main(void)
{
  looseVariable = uvec2(2, 8);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  looseVariable = uvec2(2, 8);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  looseVariable = uvec2(2, 8);
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
layout(location = 1) uvec2 variableInBlock;
} testBlock;
void main(void)
{
  testBlock.variableInBlock = uvec2(2, 8);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.variableInBlock = uvec2(2, 8);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.variableInBlock = uvec2(2, 8);
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
  uvec2 variableInStruct;
} testStruct;
void main(void)
{
  testStruct.variableInStruct = uvec2(2, 8);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testStruct.variableInStruct = uvec2(2, 8);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testStruct.variableInStruct = uvec2(2, 8);
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
  uvec2 variableInStruct;
} testStructArray[3];
void main(void)
{
  testStructArray[2].variableInStruct = uvec2(2, 8);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testStructArray[2].variableInStruct = uvec2(2, 8);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testStructArray[2].variableInStruct = uvec2(2, 8);
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
  uvec2 variableInStruct;
};
layout(location = 0) out block {
  vec2 dummy;
  TestStruct structInBlock;
} testBlock;
void main(void)
{
  testBlock.structInBlock.variableInStruct = uvec2(2, 8);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.structInBlock.variableInStruct = uvec2(2, 8);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.structInBlock.variableInStruct = uvec2(2, 8);
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
  uvec2 variableInStruct;
};
layout(location = 0) out block {
  TestStruct structArrayInBlock[3];
} testBlock;
void main(void)
{
  testBlock.structArrayInBlock[1].variableInStruct = uvec2(2, 8);
  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.structArrayInBlock[1].variableInStruct = uvec2(2, 8);
  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
  testBlock.structArrayInBlock[1].variableInStruct = uvec2(2, 8);
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
