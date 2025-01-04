#version 310 es
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
layout(location = 0) out highp vec4 vtxColor;
void main (void)
{
  gl_Position = position;
  vtxColor = color;
}
#version 310 es
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
  fragColor = vtxColor;
}
#version 310 es
#extension GL_EXT_geometry_shader : enable
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) in highp vec4 in_vtxColor[];
layout(location = 0) out highp vec4 vtxColor;
void main (void)
{
  for(int ndx=0; ndx<3; ndx++)
  {
    gl_Position = gl_in[ndx].gl_Position;
    vtxColor    = in_vtxColor[ndx];
    EmitVertex();
  }
  EndPrimitive();
}
#version 310 es
#extension GL_EXT_tessellation_shader : enable
layout(vertices = 3) out;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor[];
void main()
{
  gl_TessLevelOuter[0] = 4.0;
  gl_TessLevelOuter[1] = 4.0;
  gl_TessLevelOuter[2] = 4.0;
  gl_TessLevelInner[0] = 4.0;
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  vtxColor[gl_InvocationID] = color[gl_InvocationID];
}
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
#version 310 es
layout(local_size_x = 128) in;
layout(std430) buffer;
layout(binding = 0) readonly buffer Input0
{
  vec4 elements[];
} input_data0;
layout(binding = 1) writeonly buffer Output
{
  vec4 elements[];
} output_data;
void main()
{
  uint ident = gl_GlobalInvocationID.x;
  output_data.elements[ident] = input_data0.elements[ident] * input_data0.elements[ident];
}
#version 310 es
precision highp float;
layout(location = 0) out vec4 vtxPos;
void main (void)
{
    // Hard-coded triangle positions
    vec4 positions[3] = vec4[3](
        vec4(-0.5, -0.5, 0.0, 1.0),
        vec4( 0.5, -0.5, 0.0, 1.0),
        vec4( 0.0,  0.5, 0.0, 1.0)
    );
    
    gl_Position = positions[gl_VertexIndex % 3];
    vtxPos = positions[gl_VertexIndex % 3];
}
#version 310 es
precision highp float;
layout(location = 0) out vec4 fragColor;
void main (void)
{
  fragColor = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 310 es
layout(local_size_x = 16) in;
layout(std430, binding = 0) buffer Buffer
{
 uint values[];
};
void main(void)
{
 uint gID = gl_GlobalInvocationID.x;
 if (gID < uint(values.length()))
 {
 values[gID] = gID * 2u;
 }
}
