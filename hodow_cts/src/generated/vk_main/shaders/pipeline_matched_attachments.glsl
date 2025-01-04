#version 450

void main(){
    gl_Position = vec4(1);
}
#version 450

layout(input_attachment_index=0, set=0, binding=0) uniform subpassInput x;
layout(location=0) out vec4 color;
void main() {
   color = subpassLoad(x);
}
