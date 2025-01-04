#version 310 es
layout (local_size_x = 1) in;
void main (void) {}
#version 450
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) buffer VerificationBlock { uint value; } verif;
void main () { atomicAdd(verif.value, 1u); }
#version 450

layout(constant_id=0) const int local_size_x_val = 1;
layout(constant_id=1) const int local_size_y_val = 1;
layout(constant_id=2) const int local_size_z_val = 1;

layout(local_size_x_id=0, local_size_y_id=1, local_size_z_id=2) in;

layout(set=0, binding=0) buffer StorageBuffer {
    uint values[];
} ssbo;

void main() {
    ssbo.values[gl_LocalInvocationIndex] = 1u;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) readonly uniform Input {
    uint values[256];
} ub_in;
layout(binding = 1, std140) writeonly buffer Output {
    uint values[256];
} sb_out;
void main (void) {
    uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(ub_in.values.length()) / (size.x*size.y*size.z);
    uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset          = numValuesPerInv*groupNdx;

    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_out.values[offset + ndx] = ~ub_in.values[offset + ndx];
}
#version 310 es
layout (local_size_x = 2, local_size_y = 1, local_size_z = 4) in;
layout(binding = 0) readonly uniform Input {
    uint values[1024];
} ub_in;
layout(binding = 1, std140) writeonly buffer Output {
    uint values[1024];
} sb_out;
void main (void) {
    uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(ub_in.values.length()) / (size.x*size.y*size.z);
    uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset          = numValuesPerInv*groupNdx;

    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_out.values[offset + ndx] = ~ub_in.values[offset + ndx];
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) readonly uniform Input {
    uint values[1024];
} ub_in;
layout(binding = 1, std140) writeonly buffer Output {
    uint values[1024];
} sb_out;
void main (void) {
    uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(ub_in.values.length()) / (size.x*size.y*size.z);
    uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset          = numValuesPerInv*groupNdx;

    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_out.values[offset + ndx] = ~ub_in.values[offset + ndx];
}
#version 310 es
layout (local_size_x = 1, local_size_y = 4, local_size_z = 2) in;
layout(binding = 0) readonly uniform Input {
    uint values[1024];
} ub_in;
layout(binding = 1, std140) writeonly buffer Output {
    uint values[1024];
} sb_out;
void main (void) {
    uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(ub_in.values.length()) / (size.x*size.y*size.z);
    uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset          = numValuesPerInv*groupNdx;

    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_out.values[offset + ndx] = ~ub_in.values[offset + ndx];
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) readonly buffer Input {
    uint values[];
} sb_in;
layout (binding = 1, std140) writeonly buffer Output {
    uint values[];
} sb_out;
void main (void) {
    uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(sb_out.values.length()) / (size.x*size.y*size.z);
    uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset          = numValuesPerInv*groupNdx;

    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_out.values[offset + ndx] = ~sb_in.values[offset + ndx];
}
#version 310 es
layout (local_size_x = 1, local_size_y = 4, local_size_z = 2) in;
layout(binding = 0, std140) readonly buffer Input {
    uint values[];
} sb_in;
layout (binding = 1, std140) writeonly buffer Output {
    uint values[];
} sb_out;
void main (void) {
    uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(sb_out.values.length()) / (size.x*size.y*size.z);
    uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset          = numValuesPerInv*groupNdx;

    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_out.values[offset + ndx] = ~sb_in.values[offset + ndx];
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) buffer InOut {
    uint values[256];
} sb_inout;
void main (void) {
    uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(sb_inout.values.length()) / (size.x*size.y*size.z);
    uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset          = numValuesPerInv*groupNdx;

    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_inout.values[offset + ndx] = ~sb_inout.values[offset + ndx];
}
#version 310 es
layout (local_size_x = 1, local_size_y = 4, local_size_z = 2) in;
layout(binding = 0) buffer InOut {
    uint values[1024];
} sb_inout;
void main (void) {
    uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(sb_inout.values.length()) / (size.x*size.y*size.z);
    uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset          = numValuesPerInv*groupNdx;

    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_inout.values[offset + ndx] = ~sb_inout.values[offset + ndx];
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) buffer InOut {
    uint values[];
} sb_inout;
void main (void) {
    uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(sb_inout.values.length()) / (size.x*size.y*size.z);
    uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset          = numValuesPerInv*groupNdx;

    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_inout.values[offset + ndx] = ~sb_inout.values[offset + ndx];
}
#version 310 es
layout (local_size_x = 1, local_size_y = 4, local_size_z = 2) in;
layout(binding = 0) buffer InOut {
    uint values[];
} sb_inout;
void main (void) {
    uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(sb_inout.values.length()) / (size.x*size.y*size.z);
    uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset          = numValuesPerInv*groupNdx;

    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_inout.values[offset + ndx] = ~sb_inout.values[offset + ndx];
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) writeonly buffer Out0 {
    uint values[256];
} sb_out0;
layout(binding = 1) writeonly buffer Out1 {
    uint values[256];
} sb_out1;
void main (void) {
    uvec3 size      = gl_NumWorkGroups * gl_WorkGroupSize;
    uint groupNdx   = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;

    {
        uint numValuesPerInv = uint(sb_out0.values.length()) / (size.x*size.y*size.z);
        uint offset          = numValuesPerInv*groupNdx;

        for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
            sb_out0.values[offset + ndx] = offset + ndx;
    }
    {
        uint numValuesPerInv = uint(sb_out1.values.length()) / (size.x*size.y*size.z);
        uint offset          = numValuesPerInv*groupNdx;

        for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
            sb_out1.values[offset + ndx] = uint(sb_out1.values.length()) - offset - ndx;
    }
}
#version 310 es
layout (local_size_x = 1, local_size_y = 4, local_size_z = 2) in;
layout(binding = 0) writeonly buffer Out0 {
    uint values[1024];
} sb_out0;
layout(binding = 1) writeonly buffer Out1 {
    uint values[1024];
} sb_out1;
void main (void) {
    uvec3 size      = gl_NumWorkGroups * gl_WorkGroupSize;
    uint groupNdx   = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;

    {
        uint numValuesPerInv = uint(sb_out0.values.length()) / (size.x*size.y*size.z);
        uint offset          = numValuesPerInv*groupNdx;

        for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
            sb_out0.values[offset + ndx] = offset + ndx;
    }
    {
        uint numValuesPerInv = uint(sb_out1.values.length()) / (size.x*size.y*size.z);
        uint offset          = numValuesPerInv*groupNdx;

        for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
            sb_out1.values[offset + ndx] = uint(sb_out1.values.length()) - offset - ndx;
    }
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) writeonly buffer Out0 {
    uint values[];
} sb_out0;
layout(binding = 1) writeonly buffer Out1 {
    uint values[];
} sb_out1;
void main (void) {
    uvec3 size      = gl_NumWorkGroups * gl_WorkGroupSize;
    uint groupNdx   = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;

    {
        uint numValuesPerInv = uint(sb_out0.values.length()) / (size.x*size.y*size.z);
        uint offset          = numValuesPerInv*groupNdx;

        for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
            sb_out0.values[offset + ndx] = offset + ndx;
    }
    {
        uint numValuesPerInv = uint(sb_out1.values.length()) / (size.x*size.y*size.z);
        uint offset          = numValuesPerInv*groupNdx;

        for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
            sb_out1.values[offset + ndx] = uint(sb_out1.values.length()) - offset - ndx;
    }
}
#version 310 es
layout (local_size_x = 1, local_size_y = 4, local_size_z = 2) in;
layout(binding = 0) writeonly buffer Out0 {
    uint values[];
} sb_out0;
layout(binding = 1) writeonly buffer Out1 {
    uint values[];
} sb_out1;
void main (void) {
    uvec3 size      = gl_NumWorkGroups * gl_WorkGroupSize;
    uint groupNdx   = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;

    {
        uint numValuesPerInv = uint(sb_out0.values.length()) / (size.x*size.y*size.z);
        uint offset          = numValuesPerInv*groupNdx;

        for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
            sb_out0.values[offset + ndx] = offset + ndx;
    }
    {
        uint numValuesPerInv = uint(sb_out1.values.length()) / (size.x*size.y*size.z);
        uint offset          = numValuesPerInv*groupNdx;

        for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
            sb_out1.values[offset + ndx] = uint(sb_out1.values.length()) - offset - ndx;
    }
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) coherent buffer Output {
    uint values[1];
} sb_out;

void main (void) {
    uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;
    uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint globalOffs = localSize*globalNdx;
    uint localOffs  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_LocalInvocationID.z + gl_WorkGroupSize.x*gl_LocalInvocationID.y + gl_LocalInvocationID.x;

    sb_out.values[globalOffs + localOffs] = globalOffs;
    memoryBarrierBuffer();
    barrier();
    sb_out.values[globalOffs + ((localOffs+1u)%localSize)] += localOffs;
    memoryBarrierBuffer();
    barrier();
    sb_out.values[globalOffs + ((localOffs+2u)%localSize)] += localOffs;
}
#version 310 es
layout (local_size_x = 3, local_size_y = 2, local_size_z = 5) in;
layout(binding = 0) coherent buffer Output {
    uint values[30];
} sb_out;

void main (void) {
    uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;
    uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint globalOffs = localSize*globalNdx;
    uint localOffs  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_LocalInvocationID.z + gl_WorkGroupSize.x*gl_LocalInvocationID.y + gl_LocalInvocationID.x;

    sb_out.values[globalOffs + localOffs] = globalOffs;
    memoryBarrierBuffer();
    barrier();
    sb_out.values[globalOffs + ((localOffs+1u)%localSize)] += localOffs;
    memoryBarrierBuffer();
    barrier();
    sb_out.values[globalOffs + ((localOffs+2u)%localSize)] += localOffs;
}
#version 310 es
layout (local_size_x = 3, local_size_y = 4, local_size_z = 1) in;
layout(binding = 0) coherent buffer Output {
    uint values[504];
} sb_out;

void main (void) {
    uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;
    uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint globalOffs = localSize*globalNdx;
    uint localOffs  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_LocalInvocationID.z + gl_WorkGroupSize.x*gl_LocalInvocationID.y + gl_LocalInvocationID.x;

    sb_out.values[globalOffs + localOffs] = globalOffs;
    memoryBarrierBuffer();
    barrier();
    sb_out.values[globalOffs + ((localOffs+1u)%localSize)] += localOffs;
    memoryBarrierBuffer();
    barrier();
    sb_out.values[globalOffs + ((localOffs+2u)%localSize)] += localOffs;
}
#version 310 es
layout (local_size_x = 1) in;
layout(binding = 2) readonly uniform Constants {
    uint u_baseVal;
};
layout(binding = 1) writeonly buffer Output {
    uint values[];
};
void main (void) {
    uint offset = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    values[offset] = u_baseVal + offset;
}
#version 310 es
layout (local_size_x = 1) in;
layout(binding = 1) readonly buffer Input {
    uint values[];
};
layout(binding = 0) coherent buffer Output {
    uint sum;
};
void main (void) {
    uint offset = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint value  = values[offset];
    atomicAdd(sum, value);
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) writeonly buffer Output {
    uint values[1];
} sb_out;

shared uint offsets[1];

void main (void) {
    uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;
    uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint globalOffs = localSize*globalNdx;
    uint localOffs  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_LocalInvocationID.z + gl_WorkGroupSize.x*gl_LocalInvocationID.y + gl_LocalInvocationID.x;

    offsets[localSize-localOffs-1u] = globalOffs + localOffs*localOffs;
    memoryBarrierShared();
    barrier();
    sb_out.values[globalOffs + localOffs] = offsets[localOffs];
}
#version 310 es
layout (local_size_x = 3, local_size_y = 2, local_size_z = 5) in;
layout(binding = 0) writeonly buffer Output {
    uint values[30];
} sb_out;

shared uint offsets[30];

void main (void) {
    uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;
    uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint globalOffs = localSize*globalNdx;
    uint localOffs  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_LocalInvocationID.z + gl_WorkGroupSize.x*gl_LocalInvocationID.y + gl_LocalInvocationID.x;

    offsets[localSize-localOffs-1u] = globalOffs + localOffs*localOffs;
    memoryBarrierShared();
    barrier();
    sb_out.values[globalOffs + localOffs] = offsets[localOffs];
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) writeonly buffer Output {
    uint values[40];
} sb_out;

shared uint offsets[1];

void main (void) {
    uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;
    uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint globalOffs = localSize*globalNdx;
    uint localOffs  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_LocalInvocationID.z + gl_WorkGroupSize.x*gl_LocalInvocationID.y + gl_LocalInvocationID.x;

    offsets[localSize-localOffs-1u] = globalOffs + localOffs*localOffs;
    memoryBarrierShared();
    barrier();
    sb_out.values[globalOffs + localOffs] = offsets[localOffs];
}
#version 310 es
layout (local_size_x = 3, local_size_y = 4, local_size_z = 1) in;
layout(binding = 0) writeonly buffer Output {
    uint values[504];
} sb_out;

shared uint offsets[12];

void main (void) {
    uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;
    uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint globalOffs = localSize*globalNdx;
    uint localOffs  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_LocalInvocationID.z + gl_WorkGroupSize.x*gl_LocalInvocationID.y + gl_LocalInvocationID.x;

    offsets[localSize-localOffs-1u] = globalOffs + localOffs*localOffs;
    memoryBarrierShared();
    barrier();
    sb_out.values[globalOffs + localOffs] = offsets[localOffs];
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) writeonly buffer Output {
    uint values[1];
} sb_out;

shared uint count;

void main (void) {
    uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;
    uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint globalOffs = localSize*globalNdx;

    count = 0u;
    memoryBarrierShared();
    barrier();
    uint oldVal = atomicAdd(count, 1u);
    sb_out.values[globalOffs+oldVal] = oldVal+1u;
}
#version 310 es
layout (local_size_x = 3, local_size_y = 2, local_size_z = 5) in;
layout(binding = 0) writeonly buffer Output {
    uint values[30];
} sb_out;

shared uint count;

void main (void) {
    uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;
    uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint globalOffs = localSize*globalNdx;

    count = 0u;
    memoryBarrierShared();
    barrier();
    uint oldVal = atomicAdd(count, 1u);
    sb_out.values[globalOffs+oldVal] = oldVal+1u;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) writeonly buffer Output {
    uint values[40];
} sb_out;

shared uint count;

void main (void) {
    uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;
    uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint globalOffs = localSize*globalNdx;

    count = 0u;
    memoryBarrierShared();
    barrier();
    uint oldVal = atomicAdd(count, 1u);
    sb_out.values[globalOffs+oldVal] = oldVal+1u;
}
#version 310 es
layout (local_size_x = 3, local_size_y = 4, local_size_z = 1) in;
layout(binding = 0) writeonly buffer Output {
    uint values[504];
} sb_out;

shared uint count;

void main (void) {
    uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;
    uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint globalOffs = localSize*globalNdx;

    count = 0u;
    memoryBarrierShared();
    barrier();
    uint oldVal = atomicAdd(count, 1u);
    sb_out.values[globalOffs+oldVal] = oldVal+1u;
}
