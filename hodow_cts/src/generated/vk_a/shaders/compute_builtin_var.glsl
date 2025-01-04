#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_NumWorkGroups;
}
#version 310 es
layout (local_size_x = 2, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_NumWorkGroups;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_WorkGroupSize;
}
#version 310 es
layout (local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_WorkGroupSize;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 3, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_WorkGroupSize;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 7) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_WorkGroupSize;
}
#version 310 es
layout (local_size_x = 10, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_WorkGroupSize;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_WorkGroupID;
}
#version 310 es
layout (local_size_x = 2, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_WorkGroupID;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_LocalInvocationID;
}
#version 310 es
layout (local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_LocalInvocationID;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 3, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_LocalInvocationID;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 7) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_LocalInvocationID;
}
#version 310 es
layout (local_size_x = 10, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_LocalInvocationID;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_GlobalInvocationID;
}
#version 310 es
layout (local_size_x = 2, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_GlobalInvocationID;
}
#version 310 es
layout (local_size_x = 10, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_GlobalInvocationID;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_NumWorkGroups.z;
    sb_out.result[offset].y = gl_NumWorkGroups.y;
    sb_out.result[offset].x = gl_NumWorkGroups.x;
}
#version 310 es
layout (local_size_x = 2, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_NumWorkGroups.z;
    sb_out.result[offset].y = gl_NumWorkGroups.y;
    sb_out.result[offset].x = gl_NumWorkGroups.x;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_WorkGroupSize.z;
    sb_out.result[offset].y = gl_WorkGroupSize.y;
    sb_out.result[offset].x = gl_WorkGroupSize.x;
}
#version 310 es
layout (local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_WorkGroupSize.z;
    sb_out.result[offset].y = gl_WorkGroupSize.y;
    sb_out.result[offset].x = gl_WorkGroupSize.x;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 3, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_WorkGroupSize.z;
    sb_out.result[offset].y = gl_WorkGroupSize.y;
    sb_out.result[offset].x = gl_WorkGroupSize.x;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 7) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_WorkGroupSize.z;
    sb_out.result[offset].y = gl_WorkGroupSize.y;
    sb_out.result[offset].x = gl_WorkGroupSize.x;
}
#version 310 es
layout (local_size_x = 10, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_WorkGroupSize.z;
    sb_out.result[offset].y = gl_WorkGroupSize.y;
    sb_out.result[offset].x = gl_WorkGroupSize.x;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_WorkGroupID.z;
    sb_out.result[offset].y = gl_WorkGroupID.y;
    sb_out.result[offset].x = gl_WorkGroupID.x;
}
#version 310 es
layout (local_size_x = 2, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_WorkGroupID.z;
    sb_out.result[offset].y = gl_WorkGroupID.y;
    sb_out.result[offset].x = gl_WorkGroupID.x;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_LocalInvocationID.z;
    sb_out.result[offset].y = gl_LocalInvocationID.y;
    sb_out.result[offset].x = gl_LocalInvocationID.x;
}
#version 310 es
layout (local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_LocalInvocationID.z;
    sb_out.result[offset].y = gl_LocalInvocationID.y;
    sb_out.result[offset].x = gl_LocalInvocationID.x;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 3, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_LocalInvocationID.z;
    sb_out.result[offset].y = gl_LocalInvocationID.y;
    sb_out.result[offset].x = gl_LocalInvocationID.x;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 7) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_LocalInvocationID.z;
    sb_out.result[offset].y = gl_LocalInvocationID.y;
    sb_out.result[offset].x = gl_LocalInvocationID.x;
}
#version 310 es
layout (local_size_x = 10, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_LocalInvocationID.z;
    sb_out.result[offset].y = gl_LocalInvocationID.y;
    sb_out.result[offset].x = gl_LocalInvocationID.x;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_GlobalInvocationID.z;
    sb_out.result[offset].y = gl_GlobalInvocationID.y;
    sb_out.result[offset].x = gl_GlobalInvocationID.x;
}
#version 310 es
layout (local_size_x = 2, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_GlobalInvocationID.z;
    sb_out.result[offset].y = gl_GlobalInvocationID.y;
    sb_out.result[offset].x = gl_GlobalInvocationID.x;
}
#version 310 es
layout (local_size_x = 10, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uvec3 result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset].z = gl_GlobalInvocationID.z;
    sb_out.result[offset].y = gl_GlobalInvocationID.y;
    sb_out.result[offset].x = gl_GlobalInvocationID.x;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uint result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_LocalInvocationIndex;
}
#version 310 es
layout (local_size_x = 2, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uint result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_LocalInvocationIndex;
}
#version 310 es
layout (local_size_x = 10, local_size_y = 3, local_size_z = 4) in;
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) uniform Stride
{
    uvec2 u_stride;
}stride;
layout(set = 0, binding = 1, std430) buffer Output
{
    uint result[];
} sb_out;

void main (void)
{
    highp uint offset = stride.u_stride.x*gl_GlobalInvocationID.z + stride.u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    sb_out.result[offset] = gl_LocalInvocationIndex;
}
#version 310 es
layout (local_size_x = 4, local_size_y = 2, local_size_z = 4) in;
layout(binding = 0) buffer InOut {
    uint values[32768];
} sb_inout;
layout(binding = 1) readonly uniform uniformInput {
    uvec3 gridSize;
} ubo_in;
void main (void) {
    uvec3 size = ubo_in.gridSize * gl_WorkGroupSize;
    uint numValuesPerInv = uint(sb_inout.values.length()) / (size.x*size.y*size.z);
    uint index = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset = numValuesPerInv*index;
    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_inout.values[offset + ndx] = ~sb_inout.values[offset + ndx];
}
#version 310 es
#extension GL_EXT_device_group : require
layout (local_size_x = 3, local_size_y = 2, local_size_z = 1) in;
layout(binding = 0) buffer InOut {
    uint values[96];
} sb_inout;
layout(binding = 1) readonly uniform uniformInput {
    uint baseOffset[1+32];
} ubo_in;
void main (void) {
    uvec3 size = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(sb_inout.values.length()) / (size.x*size.y*size.z);
    uint index = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset = numValuesPerInv*index;
    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_inout.values[offset + ndx] = ubo_in.baseOffset[0] + ubo_in.baseOffset[gl_DeviceIndex + 1];
}
#version 310 es
layout (local_size_x = 1024, local_size_y = 1, local_size_z = 1) in;
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
#extension GL_EXT_shader_64bit_indexing : enable
#pragma shader_64bit_indexing
layout (local_size_x = 1024, local_size_y = 1, local_size_z = 1) in;
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
               OpCapability Shader
               OpCapability UntypedPointersKHR
               OpCapability Int64
               OpExtension "SPV_KHR_untyped_pointers"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %b
               OpExecutionMode %main LocalSize 1 1 1
               OpDecorate %_runtimearr_float ArrayStride 4
               OpDecorate %B Block
               OpMemberDecorate %B 0 NonWritable
               OpMemberDecorate %B 0 Offset 0
               OpDecorate %b NonWritable
               OpDecorate %b Binding 0
               OpDecorate %b DescriptorSet 0
       %void = OpTypeVoid
          %4 = OpTypeFunction %void
      %float = OpTypeFloat 32
%_runtimearr_float = OpTypeRuntimeArray %float
          %B = OpTypeStruct %_runtimearr_float
        %ptr = OpTypeUntypedPointerKHR StorageBuffer
          %b = OpUntypedVariableKHR %ptr StorageBuffer %B
      %ulong = OpTypeInt 64 0
       %long = OpTypeInt 64 1
       %main = OpFunction %void None %4
          %6 = OpLabel
         %13 = OpUntypedArrayLengthKHR %ulong %B %b 0
         %15 = OpBitcast %long %13
               OpReturn
               OpFunctionEnd
    
