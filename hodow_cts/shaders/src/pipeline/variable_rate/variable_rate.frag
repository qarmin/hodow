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
