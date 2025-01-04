#version 460
layout (location=0) in vec4 inPos;
void main(void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
}
#version 460
layout (location=0) out vec4 outColor;
layout (push_constant, std430) uniform PCBlock {
    uint width;
    uint height;
} pc;
void main(void) {
    const float green = gl_FragCoord.x / float(pc.width);
    const float blue  = gl_FragCoord.y / float(pc.height);
    outColor = vec4(0.0, green, blue, 1.0);
}
#version 460
layout (local_size_x=32) in;
layout (set=0, binding=0, std430) buffer OutputBlock {
    uint values[];
} ob;

uint getWorkGroupSize (void) {
    const uint workGroupSize = gl_WorkGroupSize.x * gl_WorkGroupSize.y * gl_WorkGroupSize.z;
    return workGroupSize;
}

uint getWorkGroupIndex (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z +
                                gl_NumWorkGroups.x * gl_WorkGroupID.y +
                                gl_WorkGroupID.x;
    return workGroupIndex;
}

uint getGlobalInvocationIndex (void) {
    const uint globalInvocationIndex = getWorkGroupIndex() * getWorkGroupSize() + gl_LocalInvocationIndex;
    return globalInvocationIndex;
}

void main(void) {
    const uint index = getGlobalInvocationIndex();
    ob.values[index] = index;
}
