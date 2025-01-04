#version 450
#extension GL_KHR_shader_subgroup_vote: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  tempRes = subgroupAny(true) ? 0x1 : 0;
  tempRes |= subgroupAny(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
