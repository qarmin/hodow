#version 450
layout(location = 0) out vec4 outColor;
layout(push_constant) uniform constants {
     int pass;
} pc;
void main() {
   if (pc.pass == 1) {
      outColor = vec4(0., 1., 1., 1.);
    } else {
      outColor = vec4(1., 0., 1., 1.);
    }
}
