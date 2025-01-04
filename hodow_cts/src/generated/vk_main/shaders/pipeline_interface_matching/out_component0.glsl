#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 0, component = 0 ) out vec4 looseVariable;
void main(void)
{
  gl_Position = inPosition;
  looseVariable = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in vec4 looseVariable;
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
layout(location = 1, component = 0 ) vec4 variableInBlock;
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
layout(location = 1) vec4 variableInBlock;
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
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in vec4 looseVariable[];
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

in block {
layout(location = 0) vec2 dummy;
layout(location = 1) vec4 variableInBlock;
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
layout(location = 0, component = 0 ) out vec4 looseVariable;
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
layout(location = 1, component = 0 ) vec4 variableInBlock;
} testBlock;
void main(void)
{
  gl_Position = vec4(gl_TessCoord.xy * 2.0 - 1.0, 0.0, 1.0);
  testBlock.variableInBlock = vec4(-4.0, -9.0, 3.0, 7.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0, component = 0 ) out vec4 looseVariable[];
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
layout(location = 0) in vec4 looseVariable[];
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
layout(location = 1, component = 0 ) vec4 variableInBlock;
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
layout(location = 1) vec4 variableInBlock;
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
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(location = 0) in vec4 looseVariable[];
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
layout(location = 1) vec4 variableInBlock;
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
layout(location = 0, component = 0 ) out vec4 looseVariable;
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
layout(location = 1, component = 0 ) vec4 variableInBlock;
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
