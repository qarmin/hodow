#version 450
layout (location=0) in vec4 rgba;
layout (location=1) in vec4 xyzw;
layout (location=0) out vec4 outColor;
void main() {
    vec2 pos = vec2(-float(gl_InstanceIndex & 1), -float((gl_InstanceIndex >> 1) & 1));
    vec4 vertex = vec4(xyzw);
    vec4 color = vec4(rgba);
    gl_Position = vertex + vec4(pos, 0.0f, 1.0f);
    outColor = color;
}
#version 450
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main() {
    outColor = inColor;
}
#version 450
layout (location=0) in vec2 rg;
layout (location=1) in vec2 xy;
layout (location=2) in vec2 ba;
layout (location=3) in vec2 zw;
layout (location=0) out vec4 outColor;
void main() {
    vec2 pos = vec2(-float(gl_InstanceIndex & 1), -float((gl_InstanceIndex >> 1) & 1));
    vec4 vertex = vec4(xy, zw);
    vec4 color = vec4(rg, ba);
    gl_Position = vertex + vec4(pos, 0.0f, 1.0f);
    outColor = color;
}
#version 450
layout (location=0) in vec2 rg;
layout (location=1) in vec2 xy;
layout (location=2) in float b;
layout (location=3) in float z;
layout (location=4) in float a;
layout (location=5) in float w;
layout (location=0) out vec4 outColor;
void main() {
    vec2 pos = vec2(-float(gl_InstanceIndex & 1), -float((gl_InstanceIndex >> 1) & 1));
    vec4 vertex = vec4(xy, z, w);
    vec4 color = vec4(rg, b, a);
    gl_Position = vertex + vec4(pos, 0.0f, 1.0f);
    outColor = color;
}
#version 450
layout (location=0) in float r;
layout (location=1) in float x;
layout (location=2) in float g;
layout (location=3) in float y;
layout (location=4) in float b;
layout (location=5) in float z;
layout (location=6) in float a;
layout (location=7) in float w;
layout (location=0) out vec4 outColor;
void main() {
    vec2 pos = vec2(-float(gl_InstanceIndex & 1), -float((gl_InstanceIndex >> 1) & 1));
    vec4 vertex = vec4(x, y, z, w);
    vec4 color = vec4(r, g, b, a);
    gl_Position = vertex + vec4(pos, 0.0f, 1.0f);
    outColor = color;
}
#version 450
layout(location = 0) in vec3 in_color;
layout(location = 1) in vec2 pos1;
layout(location = 2) in vec2 pos2;
layout(location = 3) in vec2 pos3;
layout(location = 4) in vec2 pos4;
layout(location = 0) out vec3 out_color;
void main() {
  gl_Position = vec4(pos1+pos2+pos3+pos4, 0.0, 1.0);
  out_color = in_color;
}
#version 450
layout (location = 0) in  vec3 in_color;
layout (location = 0) out vec4 out_color;
void main() {
    out_color = vec4(in_color, 1.0);
}
#version 450
layout(location = 0) in vec3 in_color;
layout(location = 1) in vec2 pos1;
layout(location = 2) in vec2 pos2;
layout(location = 3) in vec2 pos3;
layout(location = 4) in vec2 pos4;
layout(location = 5) in vec2 pos5;
layout(location = 6) in vec2 pos6;
layout(location = 7) in vec2 pos7;
layout(location = 8) in vec2 pos8;
layout(location = 0) out vec3 out_color;
void main() {
  gl_Position = vec4(pos1+pos2+pos3+pos4+pos5+pos6+pos7+pos8, 0.0, 1.0);
  out_color = in_color;
}
