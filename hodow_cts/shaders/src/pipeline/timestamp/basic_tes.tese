#version 310 es
#extension GL_EXT_tessellation_shader : enable
layout(triangles, fractional_even_spacing, ccw) in;
layout(location = 0) in highp vec4 colors[];
layout(location = 0) out highp vec4 vtxColor;
void main() 
{
  float u = gl_TessCoord.x;
  float v = gl_TessCoord.y;
  float w = gl_TessCoord.z;
  vec4 pos = vec4(0);
  vec4 color = vec4(0);
  pos.xyz += u * gl_in[0].gl_Position.xyz;
  color.xyz += u * colors[0].xyz;
  pos.xyz += v * gl_in[1].gl_Position.xyz;
  color.xyz += v * colors[1].xyz;
  pos.xyz += w * gl_in[2].gl_Position.xyz;
  color.xyz += w * colors[2].xyz;
  pos.w = 1.0;
  color.w = 1.0;
  gl_Position = pos;
  vtxColor = color;
}
