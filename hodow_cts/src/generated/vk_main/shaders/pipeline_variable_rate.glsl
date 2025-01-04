#version 450

layout(location=0) in vec2 inPos;

void main() {
    gl_Position = vec4(inPos, 0.0, 1.0);
}
#version 450

layout(set=0, binding=0, std430) buffer OutBuffer {
    int coverage[];
} out_buffer;

layout(push_constant) uniform PushConstants {
    int width;
    int height;
    int samples;
} push_constants;

void main() {
   ivec2 coord = ivec2(floor(gl_FragCoord.xy));
   int pos = ((coord.y * push_constants.width) + coord.x) * push_constants.samples + int(gl_SampleID);
   out_buffer.coverage[pos] = 1;
}
