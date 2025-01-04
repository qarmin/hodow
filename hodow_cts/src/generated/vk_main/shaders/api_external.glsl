#version 310 es
layout (local_size_x = 64, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) writeonly buffer Output {
    uint values[];
};

void main (void) {
    uint offset = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;

      atomicAdd(values[offset], 1u);
}
