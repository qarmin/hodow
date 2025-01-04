#version 450 core
layout(location = 0) out int primID;
void main()
{
  primID = gl_InstanceIndex;
  gl_Position = vec4( 2.0*float(gl_VertexIndex&2) - 1.0, 4.0*(gl_VertexIndex&1)-1.0, 1.0 - 2.0 * float(gl_VertexIndex&1), 1);
}
