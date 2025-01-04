#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupEqMaskARB;
  bool temp = true;
  uint64_t mask = uint64_t(1) << gl_SubGroupInvocationARB;
  temp = (value & mask) != 0;
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupEqMaskARB;
  bool temp = true;
  uint64_t mask = uint64_t(1) << gl_SubGroupInvocationARB;
  temp = (value & mask) != 0;
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupEqMaskARB;
  bool temp = true;
  uint64_t mask = uint64_t(1) << gl_SubGroupInvocationARB;
  temp = (value & mask) != 0;
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint64_t value = gl_SubGroupEqMaskARB;
  bool temp = true;
  uint64_t mask = uint64_t(1) << gl_SubGroupInvocationARB;
  temp = (value & mask) != 0;
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint64_t value = gl_SubGroupEqMaskARB;
  bool temp = true;
  uint64_t mask = uint64_t(1) << gl_SubGroupInvocationARB;
  temp = (value & mask) != 0;
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupEqMaskARB;
  bool temp = true;
  uint64_t mask = uint64_t(1) << gl_SubGroupInvocationARB;
  temp = (value & mask) != 0;
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupEqMaskARB;
  bool temp = true;
  uint64_t mask = uint64_t(1) << gl_SubGroupInvocationARB;
  temp = (value & mask) != 0;
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupGeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i >= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i < gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupGeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i >= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i < gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupGeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i >= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i < gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint64_t value = gl_SubGroupGeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i >= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i < gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint64_t value = gl_SubGroupGeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i >= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i < gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupGeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i >= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i < gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupGeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i >= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i < gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupGtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i > gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i <= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupGtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i > gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i <= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupGtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i > gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i <= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint64_t value = gl_SubGroupGtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i > gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i <= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint64_t value = gl_SubGroupGtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i > gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i <= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupGtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i > gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i <= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupGtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i > gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i <= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupLeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i <= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i > gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupLeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i <= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i > gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupLeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i <= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i > gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint64_t value = gl_SubGroupLeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i <= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i > gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint64_t value = gl_SubGroupLeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i <= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i > gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupLeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i <= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i > gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupLeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i <= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i > gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupLtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i < gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i >= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupLtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i < gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i >= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupLtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i < gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i >= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint64_t value = gl_SubGroupLtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i < gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i >= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint64_t value = gl_SubGroupLtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i < gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i >= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupLtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i < gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i >= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupLtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i < gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i >= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
