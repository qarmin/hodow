#version 450
layout(location = 0) in highp vec4 in_position;
void main (void)
{
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
layout(location = 0) in float in_color;
layout(location = 0) out uint out_color;
void main()
{
    out_color = uint(in_color);
}
#version 450
#extension GL_KHR_shader_subgroup_basic: enable
#extension GL_EXT_tessellation_shader : require
layout(vertices = 2) out;
void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_tessellation_shader : require
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) in float in_color[];
layout(location = 0) out float out_color;

void main (void)
{
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  out_color = in_color[0];
}
