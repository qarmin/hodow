#version 450
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;

void main (void)
{
  uint tempRes;
  tempRes = gl_SubgroupSize;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_basic: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  tempRes = gl_SubgroupSize;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_basic: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  tempRes = gl_SubgroupSize;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_basic: enable
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
  tempRes = gl_SubgroupSize;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_basic: enable
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
  tempRes = gl_SubgroupSize;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_basic: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  tempRes = gl_SubgroupSize;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_basic: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  tempRes = gl_SubgroupSize;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
void main (void)
{
  vec2 uv = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
  gl_Position = vec4(uv * 4.0f -2.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
precision highp int;
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) out uint out_color;
void main()
{
uint tempResult = gl_SubgroupSize;
     out_color = tempResult;
}
