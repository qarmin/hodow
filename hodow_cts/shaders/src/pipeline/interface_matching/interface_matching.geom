#version 450
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
${geom_declarations}void main(void)
{
${geom_operations}  gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
  EmitVertex();
${geom_operations}  gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
  EmitVertex();
${geom_operations}  gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
