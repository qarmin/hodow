#version 450
layout(location = 0) in vec4 inPosition;
void main(void)
{
	gl_Position = inPosition;
	gl_PointSize = 1.0;
}
#version 450
precision highp float;
layout(location = 0) out vec4 fragColor;
void main (void)
{
	fragColor = vec4(0.2, 1.0, 0.5, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
void main(void) {
   gl_Position = gl_in[0].gl_Position;
   EmitVertex();
   EndPrimitive();
}
#version 450
layout(vertices = 1) out;
void main(void) {
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter[0] = 1.0;
   gl_TessLevelOuter[1] = 1.0;
   gl_TessLevelOuter[2] = 1.0;
}
#version 450
layout(triangles, point_mode) in;
void main(void) {
   gl_Position = gl_in[0].gl_Position;
}
#version 450
layout(location = 0) out vec4 fragColor;
void main (void) {
   fragColor = vec4(1.0);
}
