#version 450 core

layout(quads) in;

void main() {
   vec4 low = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord[0]);
   vec4 high = mix(gl_in[3].gl_Position, gl_in[2].gl_Position, gl_TessCoord[0]);
   gl_Position = mix(low, high, gl_TessCoord[1]);
}
