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
