#version 450
layout(location = 0) in vec4 a_position;
void main (void) {
    gl_Position = a_position;
}
#version 450
layout(location = 0) out vec4 outColor;
void main() {
    outColor = vec4(1., 1., 0., .4);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=4) in;
layout (set=0, binding=0) uniform sampler2DMS inImage;
layout (set=0, binding=1, std430) buffer OutBlock { vec4 color[]; } outBuffer;
void main (void) {
    const uint width = gl_WorkGroupSize.x;
    const uint height = gl_WorkGroupSize.y;
    const uint samples = gl_WorkGroupSize.z;
    const uint x = gl_LocalInvocationID.x;
    const uint y = gl_LocalInvocationID.y;
    const uint s = gl_LocalInvocationID.z;
    const uint idx = samples * width * y + samples * x + s;
    const vec4 color = texelFetch(inImage, ivec2(x, y), int(s));
    outBuffer.color[idx] = color;
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=4) in;
layout (set=0, binding=0, rgba8) uniform image2DMS inImage;
layout (set=0, binding=1, std430) buffer OutBlock { vec4 color[]; } outBuffer;
void main (void) {
    const uint width = gl_WorkGroupSize.x;
    const uint height = gl_WorkGroupSize.y;
    const uint samples = gl_WorkGroupSize.z;
    const uint x = gl_LocalInvocationID.x;
    const uint y = gl_LocalInvocationID.y;
    const uint s = gl_LocalInvocationID.z;
    const uint idx = samples * width * y + samples * x + s;
    const vec4 color = imageLoad(inImage, ivec2(x, y), int(s));
    outBuffer.color[idx] = color;
}
