#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) buffer OutBlock { uint value; } outBuffer;
layout (push_constant, std430) uniform PushConstantBlock { uint a; uint b; } pc;
void main(void) { outBuffer.value = ((pc.a == pc.b) ? 1u : 0u); }
#version 460
layout (location=0) in vec4 inPos;
void main (void) { gl_Position = inPos; }
#version 460
layout (location=0) out vec4 outColor;
layout (set=0, binding=0, std430) readonly buffer ColorBlock { vec4 colorA; vec4 colorB; } inColor;
void main (void) { outColor = inColor.colorA; }
#version 460
layout (location=0) out vec4 outColor;
layout (set=0, binding=0, std430) readonly buffer ColorBlock { vec4 colorA; vec4 colorB; } inColor;
void main (void) { outColor = inColor.colorB; }
#version 460
#extension GL_EXT_ray_tracing : require
layout (set=0, binding=0) buffer OutBlock { uint value; } outBuffer;
void main (void) { outBuffer.value = 1u; }
