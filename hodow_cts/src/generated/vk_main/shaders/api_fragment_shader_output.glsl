#version 450
layout(location=0) in vec4 pos;
void main() {
    gl_Position = vec4(pos.xyz, 1.0);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out vec4 color1;
layout(location = 4) out ivec4 color2;
layout(location = 3) out uvec4 color3;
void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = vec4(1.0,1.0,1.0,1.0);
  color2 = ivec4(111,111,111,111);
  color3 = uvec4(123,123,123,123);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out vec4 color1;
layout(location = 4) out uvec4 color2;
layout(location = 3) out ivec4 color3;
void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = vec4(1.0,1.0,1.0,1.0);
  color2 = uvec4(123,123,123,123);
  color3 = ivec4(111,111,111,111);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out ivec4 color1;
layout(location = 4) out vec4 color2;
layout(location = 3) out uvec4 color3;
void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = ivec4(111,111,111,111);
  color2 = vec4(1.0,1.0,1.0,1.0);
  color3 = uvec4(123,123,123,123);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out ivec4 color1;
layout(location = 4) out uvec4 color2;
layout(location = 3) out vec4 color3;
void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = ivec4(111,111,111,111);
  color2 = uvec4(123,123,123,123);
  color3 = vec4(1.0,1.0,1.0,1.0);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out uvec4 color1;
layout(location = 4) out vec4 color2;
layout(location = 3) out ivec4 color3;
void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = uvec4(123,123,123,123);
  color2 = vec4(1.0,1.0,1.0,1.0);
  color3 = ivec4(111,111,111,111);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out uvec4 color1;
layout(location = 4) out ivec4 color2;
layout(location = 3) out vec4 color3;
void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = uvec4(123,123,123,123);
  color2 = ivec4(111,111,111,111);
  color3 = vec4(1.0,1.0,1.0,1.0);
}
#version 450
layout(location = 0) out ivec4 color0;
layout(location = 1) out vec4 color1;
layout(location = 4) out vec4 color2;
layout(location = 3) out uvec4 color3;
void main() {
  color0 = ivec4(111,111,111,111);
  color1 = vec4(1.0,1.0,1.0,1.0);
  color2 = vec4(1.0,1.0,1.0,1.0);
  color3 = uvec4(123,123,123,123);
}
#version 450
layout(location = 0) out ivec4 color0;
layout(location = 1) out vec4 color1;
layout(location = 4) out uvec4 color2;
layout(location = 3) out vec4 color3;
void main() {
  color0 = ivec4(111,111,111,111);
  color1 = vec4(1.0,1.0,1.0,1.0);
  color2 = uvec4(123,123,123,123);
  color3 = vec4(1.0,1.0,1.0,1.0);
}
#version 450
layout(location = 0) out ivec4 color0;
layout(location = 1) out uvec4 color1;
layout(location = 4) out vec4 color2;
layout(location = 3) out vec4 color3;
void main() {
  color0 = ivec4(111,111,111,111);
  color1 = uvec4(123,123,123,123);
  color2 = vec4(1.0,1.0,1.0,1.0);
  color3 = vec4(1.0,1.0,1.0,1.0);
}
#version 450
layout(location = 0) out uvec4 color0;
layout(location = 1) out vec4 color1;
layout(location = 4) out vec4 color2;
layout(location = 3) out ivec4 color3;
void main() {
  color0 = uvec4(123,123,123,123);
  color1 = vec4(1.0,1.0,1.0,1.0);
  color2 = vec4(1.0,1.0,1.0,1.0);
  color3 = ivec4(111,111,111,111);
}
#version 450
layout(location = 0) out uvec4 color0;
layout(location = 1) out vec4 color1;
layout(location = 4) out ivec4 color2;
layout(location = 3) out vec4 color3;
void main() {
  color0 = uvec4(123,123,123,123);
  color1 = vec4(1.0,1.0,1.0,1.0);
  color2 = ivec4(111,111,111,111);
  color3 = vec4(1.0,1.0,1.0,1.0);
}
#version 450
layout(location = 0) out uvec4 color0;
layout(location = 1) out ivec4 color1;
layout(location = 4) out vec4 color2;
layout(location = 3) out vec4 color3;
void main() {
  color0 = uvec4(123,123,123,123);
  color1 = ivec4(111,111,111,111);
  color2 = vec4(1.0,1.0,1.0,1.0);
  color3 = vec4(1.0,1.0,1.0,1.0);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out vec4 color1;

layout(location = 3) out uvec4 color3;
void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = vec4(1.0,1.0,1.0,1.0);
  
  color3 = uvec4(123,123,123,123);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out vec4 color1;

layout(location = 3) out ivec4 color3;
void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = vec4(1.0,1.0,1.0,1.0);
  
  color3 = ivec4(111,111,111,111);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out ivec4 color1;

layout(location = 3) out uvec4 color3;
void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = ivec4(111,111,111,111);
  
  color3 = uvec4(123,123,123,123);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out ivec4 color1;

layout(location = 3) out vec4 color3;
void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = ivec4(111,111,111,111);
  
  color3 = vec4(1.0,1.0,1.0,1.0);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out uvec4 color1;

layout(location = 3) out ivec4 color3;
void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = uvec4(123,123,123,123);
  
  color3 = ivec4(111,111,111,111);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out uvec4 color1;

layout(location = 3) out vec4 color3;
void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = uvec4(123,123,123,123);
  
  color3 = vec4(1.0,1.0,1.0,1.0);
}
#version 450
layout(location = 0) out ivec4 color0;
layout(location = 1) out vec4 color1;

layout(location = 3) out uvec4 color3;
void main() {
  color0 = ivec4(111,111,111,111);
  color1 = vec4(1.0,1.0,1.0,1.0);
  
  color3 = uvec4(123,123,123,123);
}
#version 450
layout(location = 0) out ivec4 color0;
layout(location = 1) out vec4 color1;

layout(location = 3) out vec4 color3;
void main() {
  color0 = ivec4(111,111,111,111);
  color1 = vec4(1.0,1.0,1.0,1.0);
  
  color3 = vec4(1.0,1.0,1.0,1.0);
}
#version 450
layout(location = 0) out ivec4 color0;
layout(location = 1) out uvec4 color1;

layout(location = 3) out vec4 color3;
void main() {
  color0 = ivec4(111,111,111,111);
  color1 = uvec4(123,123,123,123);
  
  color3 = vec4(1.0,1.0,1.0,1.0);
}
#version 450
layout(location = 0) out uvec4 color0;
layout(location = 1) out vec4 color1;

layout(location = 3) out ivec4 color3;
void main() {
  color0 = uvec4(123,123,123,123);
  color1 = vec4(1.0,1.0,1.0,1.0);
  
  color3 = ivec4(111,111,111,111);
}
#version 450
layout(location = 0) out uvec4 color0;
layout(location = 1) out vec4 color1;

layout(location = 3) out vec4 color3;
void main() {
  color0 = uvec4(123,123,123,123);
  color1 = vec4(1.0,1.0,1.0,1.0);
  
  color3 = vec4(1.0,1.0,1.0,1.0);
}
#version 450
layout(location = 0) out uvec4 color0;
layout(location = 1) out ivec4 color1;

layout(location = 3) out vec4 color3;
void main() {
  color0 = uvec4(123,123,123,123);
  color1 = ivec4(111,111,111,111);
  
  color3 = vec4(1.0,1.0,1.0,1.0);
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out vec4 color1;


void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = vec4(1.0,1.0,1.0,1.0);
  
  
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out ivec4 color1;


void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = ivec4(111,111,111,111);
  
  
}
#version 450
layout(location = 0) out vec4 color0;
layout(location = 1) out uvec4 color1;


void main() {
  color0 = vec4(1.0,1.0,1.0,1.0);
  color1 = uvec4(123,123,123,123);
  
  
}
#version 450
layout(location = 0) out ivec4 color0;
layout(location = 1) out vec4 color1;


void main() {
  color0 = ivec4(111,111,111,111);
  color1 = vec4(1.0,1.0,1.0,1.0);
  
  
}
#version 450
layout(location = 0) out ivec4 color0;
layout(location = 1) out uvec4 color1;


void main() {
  color0 = ivec4(111,111,111,111);
  color1 = uvec4(123,123,123,123);
  
  
}
#version 450
layout(location = 0) out uvec4 color0;
layout(location = 1) out vec4 color1;


void main() {
  color0 = uvec4(123,123,123,123);
  color1 = vec4(1.0,1.0,1.0,1.0);
  
  
}
#version 450
layout(location = 0) out uvec4 color0;
layout(location = 1) out ivec4 color1;


void main() {
  color0 = uvec4(123,123,123,123);
  color1 = ivec4(111,111,111,111);
  
  
}
