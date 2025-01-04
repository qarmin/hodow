#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  tempRes = allInvocationsARB(true) ? 0x1 : 0;
  tempRes |= allInvocationsARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  tempRes = allInvocationsARB(true) ? 0x1 : 0;
  tempRes |= allInvocationsARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  tempRes = allInvocationsARB(true) ? 0x1 : 0;
  tempRes |= allInvocationsARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  tempRes = allInvocationsARB(true) ? 0x1 : 0;
  tempRes |= allInvocationsARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  tempRes = allInvocationsARB(true) ? 0x1 : 0;
  tempRes |= allInvocationsARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  tempRes = allInvocationsARB(true) ? 0x1 : 0;
  tempRes |= allInvocationsARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  tempRes = allInvocationsARB(true) ? 0x1 : 0;
  tempRes |= allInvocationsARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
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
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) out uint out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};
void main()
{
  uint tempRes = 0u;
  if (dFdx(gl_SubgroupInvocationID * gl_FragCoord.x * gl_FragCoord.y) - dFdy(gl_SubgroupInvocationID * gl_FragCoord.x * gl_FragCoord.y) > 0.0f)
  {
    tempRes |= 0x20;
  }
  bool helper = anyInvocationARB(gl_HelperInvocation);
  if (helper)
  {
    tempRes |= 0x40;
  }
  tempRes |= allInvocationsARB(!gl_HelperInvocation) ? 0x0 : 0x1;
  tempRes |= allInvocationsARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color = tempRes;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  tempRes = anyInvocationARB(true) ? 0x1 : 0;
  tempRes |= anyInvocationARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  tempRes = anyInvocationARB(true) ? 0x1 : 0;
  tempRes |= anyInvocationARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  tempRes = anyInvocationARB(true) ? 0x1 : 0;
  tempRes |= anyInvocationARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  tempRes = anyInvocationARB(true) ? 0x1 : 0;
  tempRes |= anyInvocationARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  tempRes = anyInvocationARB(true) ? 0x1 : 0;
  tempRes |= anyInvocationARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  tempRes = anyInvocationARB(true) ? 0x1 : 0;
  tempRes |= anyInvocationARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  tempRes = anyInvocationARB(true) ? 0x1 : 0;
  tempRes |= anyInvocationARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) out uint out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};
void main()
{
  uint tempRes = 0u;
  if (dFdx(gl_SubgroupInvocationID * gl_FragCoord.x * gl_FragCoord.y) - dFdy(gl_SubgroupInvocationID * gl_FragCoord.x * gl_FragCoord.y) > 0.0f)
  {
    tempRes |= 0x20;
  }
  bool helper = anyInvocationARB(gl_HelperInvocation);
  if (helper)
  {
    tempRes |= 0x40;
  }
  tempRes |= anyInvocationARB(gl_HelperInvocation) ? 0x1 : 0x0;
  tempRes |= anyInvocationARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color = tempRes;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  uint tempRes;
  bool valueEqual = bool(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bool valueNoEqual = bool(subgroupElect());
  tempRes = allInvocationsEqualARB(bool(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= allInvocationsEqualARB(data[0]) ? 0x4 : 0;
  tempRes |= allInvocationsEqualARB(valueEqual) ? 0x8 : 0x0;
  tempRes |= allInvocationsEqualARB(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  uint tempRes;
  bool valueEqual = bool(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bool valueNoEqual = bool(subgroupElect());
  tempRes = allInvocationsEqualARB(bool(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= allInvocationsEqualARB(data[0]) ? 0x4 : 0;
  tempRes |= allInvocationsEqualARB(valueEqual) ? 0x8 : 0x0;
  tempRes |= allInvocationsEqualARB(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  uint tempRes;
  bool valueEqual = bool(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bool valueNoEqual = bool(subgroupElect());
  tempRes = allInvocationsEqualARB(bool(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= allInvocationsEqualARB(data[0]) ? 0x4 : 0;
  tempRes |= allInvocationsEqualARB(valueEqual) ? 0x8 : 0x0;
  tempRes |= allInvocationsEqualARB(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  bool valueEqual = bool(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bool valueNoEqual = bool(subgroupElect());
  tempRes = allInvocationsEqualARB(bool(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= allInvocationsEqualARB(data[0]) ? 0x4 : 0;
  tempRes |= allInvocationsEqualARB(valueEqual) ? 0x8 : 0x0;
  tempRes |= allInvocationsEqualARB(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  bool valueEqual = bool(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bool valueNoEqual = bool(subgroupElect());
  tempRes = allInvocationsEqualARB(bool(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= allInvocationsEqualARB(data[0]) ? 0x4 : 0;
  tempRes |= allInvocationsEqualARB(valueEqual) ? 0x8 : 0x0;
  tempRes |= allInvocationsEqualARB(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  uint tempRes;
  bool valueEqual = bool(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bool valueNoEqual = bool(subgroupElect());
  tempRes = allInvocationsEqualARB(bool(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= allInvocationsEqualARB(data[0]) ? 0x4 : 0;
  tempRes |= allInvocationsEqualARB(valueEqual) ? 0x8 : 0x0;
  tempRes |= allInvocationsEqualARB(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  uint tempRes;
  bool valueEqual = bool(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bool valueNoEqual = bool(subgroupElect());
  tempRes = allInvocationsEqualARB(bool(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= allInvocationsEqualARB(data[0]) ? 0x4 : 0;
  tempRes |= allInvocationsEqualARB(valueEqual) ? 0x8 : 0x0;
  tempRes |= allInvocationsEqualARB(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) out uint out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};
void main()
{
  uint tempRes = 0u;
  if (dFdx(gl_SubgroupInvocationID * gl_FragCoord.x * gl_FragCoord.y) - dFdy(gl_SubgroupInvocationID * gl_FragCoord.x * gl_FragCoord.y) > 0.0f)
  {
    tempRes |= 0x20;
  }
  bool helper = anyInvocationARB(gl_HelperInvocation);
  if (helper)
  {
    tempRes |= 0x40;
  }
  bool valueEqual = bool(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bool valueNoEqual = bool(subgroupElect());
  tempRes |= allInvocationsEqualARB(bool(1)) ? 0x10 : 0;
  tempRes |= 0x2;
  tempRes |= allInvocationsEqualARB(data[0]) ? 0x4 : 0;
  tempRes |= allInvocationsEqualARB(valueEqual) ? 0x8 : 0x0;
  tempRes |= allInvocationsEqualARB(gl_HelperInvocation) ? 0x0 : 0x1;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  out_color = tempRes;
}
